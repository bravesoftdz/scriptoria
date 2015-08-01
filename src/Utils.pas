unit Utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Graphics,IntfGraphics;

type

  PRGB24 = ^TRGB24;
  TRGB24 = record
    Blue, Green, Red: Byte;
  end;
  PRGB24Array = ^TRGB24Array;
  TRGB24Array = array of TRGB24;
  PRGB32 = ^TRGB32;
  TRGB32 = record
    Blue, Green, Red, Alpha: Byte;
  end;
  PRGB32Array = ^TRGB32Array;
  TRGB32Array = array of TRGB32;

  { TCustomImageEnhancer }

  TCustomImageEnhancer = class
    private
      function GetALazIntfImageInBGR32PixelFormat(ABitmap: TBitmap): TLazIntfImage;
      function ProcessBitmapPixelByPixel(ABitmap: TBitmap): TBitmap;
    protected
      procedure ProcessBGR32Pixel(var Pixel: TRGB32); virtual; abstract;
    public
      function EnhancePicture(APicture: TPicture): TPicture; virtual; abstract;
  end;

  { TPictureEx }

  TPictureEx = class
    private
      fMaxZoom: Double;
      fMinZoom: Double;
      fPicture: TPicture;
      fZoomFactor: Double;
      function GetHeight: Integer;
      function GetPicture: TPicture;
      function GetWidth: Integer;
      procedure SetMaxZoom(AValue: Double);
      procedure SetMinZoom(AValue: Double);
      procedure SetZoomFactor(AValue: Double);
      procedure UpdateIfZoomFactorGreaterThanMaxZoom;
      procedure UpdateIfZoomFactorLesserThanMinZoom;
    public
      constructor Create(AFileName: string);
      constructor Create(APicture: TPicture);
      destructor Destroy; override;
      procedure ZoomIn;
      procedure ZoomOut;
      procedure RestoreZoom;
      function CanZoomIn: Boolean;
      function CanZoomOut: Boolean;
      function GetThumbnail(AHeight, AWidth: Integer): TPicture;
      procedure EnhanceMeWith(AEnhancer: TCustomImageEnhancer);
      property Height: Integer read GetHeight;
      property Width: Integer read GetWidth;
      property Picture: TPicture read GetPicture;
      property ZoomFactor: Double read fZoomFactor write SetZoomFactor;
      property MinZoom: Double read fMinZoom write SetMinZoom;
      property MaxZoom: Double read fMaxZoom write SetMaxZoom;
  end;

  { TImageInfo }

  TImageInfo = class
    private
      fPicture: TPicture;
      fFileName: string;
      fFileSize: Int64;
      function GetHeight: Integer;
      function GetPicture: TPicture;
      function GetWidth: Integer;
    public
      constructor Create(AFileName: string);
      destructor Destroy; override;
      property FileName: string read fFileName;
      property FileSize: Int64 read fFileSize;
      property Height: Integer read GetHeight;
      property Width: Integer read GetWidth;
      property Picture: TPicture read GetPicture;
  end;

  { TBrightnessContrastEnhancer }

  TBrightnessContrastEnhancer = class(TCustomImageEnhancer)
    private
      fBrightness: Integer;
      fContrast: Integer;
      ContrastLookupTable: array[0..255] of Byte;
      BrightnessLookupTable: array[0..255] of Byte;
      procedure ApplyBrightness(var Pixel: TRGB32);
      procedure ApplyBrightnessTo(var Color: Byte);
      procedure ApplyContrast(var Pixel: TRGB32);
      procedure ApplyContrastTo(var Color: Byte);
      function GetNormalizedContrast: Double;
      procedure SetBrightness(AValue: Integer);
      procedure SetContrast(AValue: Integer);
      procedure CreateBrightnessLookupTable;
      procedure CreateContrastLookupTable;
    protected
      procedure ProcessBGR32Pixel(var Pixel: TRGB32); override;
    public
      constructor Create;
      function EnhancePicture(APicture: TPicture): TPicture; override;
      property Brightness: Integer read fBrightness write SetBrightness;
      property Contrast: Integer read fContrast write SetContrast;
  end;

  { TColorBalanceEnhancer }

  TColorBalanceEnhancer = class(TCustomImageEnhancer)
    private
      fBlue: Integer;
      fGreen: Integer;
      fRed: Integer;
      RedLookupTable: array[0..255] of Byte;
      GreenLookupTable: array[0..255] of Byte;
      BlueLookupTable: array[0..255] of Byte;
      procedure SetBlue(AValue: Integer);
      procedure SetGreen(AValue: Integer);
      procedure SetRed(AValue: Integer);
      procedure CreateRedLookupTable;
      procedure CreateGreenLookupTable;
      procedure CreateBlueLookupTable;
      procedure ApplyRed(var Pixel: TRGB32);
      procedure ApplyGreen(var Pixel: TRGB32);
      procedure ApplyBlue(var Pixel: TRGB32);
    protected
      procedure ProcessBGR32Pixel(var Pixel: TRGB32); override;
    public
      constructor Create;
      function EnhancePicture(APicture: TPicture): TPicture; override;
      property Red: Integer read fRed write SetRed;
      property Green: Integer read fGreen write SetGreen;
      property Blue: Integer read fBlue write SetBlue;
  end;

function FormatByteSize(const bytes: Longint): string;

implementation

uses GraphType;

//type
//  THistogram = array[0..255] of Byte;

function TruncateToColorRange(AValue: Integer): Integer;
  begin
    Result:= AValue;
    if AValue < 0 then Result:= 0;
    if AValue > 255 then Result:= 255;
end;


//Format file byte size
 function FormatByteSize(const bytes: Longint): string;
 const
   B = 1; //byte
   KB = 1024 * B; //kilobyte
   MB = 1024 * KB; //megabyte
   GB = 1024 * MB; //gigabyte
 begin
   if bytes > GB then
     result := FormatFloat('#.## GB', bytes / GB)
   else
     if bytes > MB then
       result := FormatFloat('#.## MB', bytes / MB)
     else
       if bytes > KB then
         result := FormatFloat('#.# KB', bytes / KB)
       else
         result := FormatFloat('#.# bytes', bytes) ;
 end;

{ TCustomImageEnhancer }

function TCustomImageEnhancer.GetALazIntfImageInBGR32PixelFormat(ABitmap: TBitmap): TLazIntfImage;
var
  BGR32PixelFormat: TRawImageDescription;
begin
  BGR32PixelFormat.Init_BPP32_B8G8R8_BIO_TTB(ABitmap.Width, ABitmap.Height);
  Result:= ABitmap.CreateIntfImage;
//  Result.DataDescription:= BGR32PixelFormat;
end;

function TCustomImageEnhancer.ProcessBitmapPixelByPixel(ABitmap: TBitmap): TBitmap;
var
  ImageToProcess: TLazIntfImage;
  y,x: Integer;
  Line: PRGB32;
begin
  ImageToProcess:= GetALazIntfImageInBGR32PixelFormat(ABitmap);
  Result:= TBitmap.Create;
  try
    for y:=0 to ImageToProcess.Height-1 do
      begin
        Line:= ImageToProcess.GetDataLineStart(y);
        for x:= 0 to ImageToProcess.Width-1 do
          ProcessBGR32Pixel(Line[x]);
      end;
    Result.LoadFromIntfImage(ImageToProcess);
  finally
    ImageToProcess.Free;
  end;
end;

{ TColorBalanceEnhancer }

constructor TColorBalanceEnhancer.Create;
begin
  fRed:= 0;
  fGreen:= 0;
  fBlue:= 0;
  CreateRedLookupTable;
  CreateGreenLookupTable;
  CreateBlueLookupTable;
end;

procedure TColorBalanceEnhancer.SetBlue(AValue: Integer);
begin
  if fBlue=AValue then Exit;
  fBlue:=AValue;
  CreateBlueLookupTable;
end;

procedure TColorBalanceEnhancer.SetGreen(AValue: Integer);
begin
  if fGreen=AValue then Exit;
  fGreen:=AValue;
  CreateGreenLookupTable;
end;

procedure TColorBalanceEnhancer.SetRed(AValue: Integer);
begin
  if fRed=AValue then Exit;
  fRed:=AValue;
  CreateRedLookupTable;
end;

procedure TColorBalanceEnhancer.CreateRedLookupTable;
var
  i: Byte;
begin
  for i:= 0 to 255 do
    RedLookupTable[i]:= TruncateToColorRange(i + Red);
end;

procedure TColorBalanceEnhancer.CreateGreenLookupTable;
var
  i: Byte;
begin
  for i:= 0 to 255 do
    GreenLookupTable[i]:= TruncateToColorRange(i + Green);
end;

procedure TColorBalanceEnhancer.CreateBlueLookupTable;
var
  i: Byte;
begin
  for i:= 0 to 255 do
    BlueLookupTable[i]:= TruncateToColorRange(i + Blue);
end;

procedure TColorBalanceEnhancer.ApplyRed(var Pixel: TRGB32);
begin
  Pixel.Red:= RedLookupTable[Pixel.Red];
end;

procedure TColorBalanceEnhancer.ApplyGreen(var Pixel: TRGB32);
begin
  Pixel.Green:= GreenLookupTable[Pixel.Green];
end;

procedure TColorBalanceEnhancer.ApplyBlue(var Pixel: TRGB32);
begin
  Pixel.Blue:= BlueLookupTable[Pixel.Blue];
end;

function TColorBalanceEnhancer.EnhancePicture(APicture: TPicture): TPicture;
begin
  Result:= TPicture.Create;
  Result.Bitmap.Assign(ProcessBitmapPixelByPixel(APicture.Bitmap));
end;

procedure TColorBalanceEnhancer.ProcessBGR32Pixel(var Pixel: TRGB32);
begin
  ApplyRed(Pixel);
  ApplyGreen(Pixel);
  ApplyBlue(Pixel);
end;

{ TBrightnessContrastEnhancer }

constructor TBrightnessContrastEnhancer.Create;
begin
  fBrightness:= 0;
  fContrast:= 0;
  CreateBrightnessLookupTable;
  CreateContrastLookupTable;
end;

procedure TBrightnessContrastEnhancer.SetBrightness(AValue: Integer);
begin
  if fBrightness=AValue then Exit;
  fBrightness:=AValue;
  CreateBrightnessLookupTable;
end;

procedure TBrightnessContrastEnhancer.CreateBrightnessLookupTable;
var
  i: Byte;
begin
  for i:= 0 to 255 do
    BrightnessLookupTable[i]:= TruncateToColorRange(i + Brightness);
end;

procedure TBrightnessContrastEnhancer.SetContrast(AValue: Integer);
begin
  if fContrast=AValue then Exit;
  fContrast:=AValue;
  CreateContrastLookupTable;
end;

procedure TBrightnessContrastEnhancer.CreateContrastLookupTable;
var
  NormalizedContrast: Double;
  PixelColor: Double;
  i: Byte;
begin
  NormalizedContrast:= GetNormalizedContrast;
  for i:= 0 to 255 do
    begin
      PixelColor:= i/255;
      PixelColor:= PixelColor - 0.5;
      PixelColor:= NormalizedContrast*PixelColor;
      PixelColor:= PixelColor + 0.5;
      PixelColor:= 255*PixelColor;
      ContrastLookupTable[i]:= TruncateToColorRange(Round(PixelColor));
    end;
end;

function TBrightnessContrastEnhancer.EnhancePicture(APicture: TPicture
  ): TPicture;
begin
  Result:= TPicture.Create;
  Result.Bitmap.Assign(ProcessBitmapPixelByPixel(APicture.Bitmap));
end;

procedure TBrightnessContrastEnhancer.ProcessBGR32Pixel(var Pixel: TRGB32);
begin
  ApplyBrightness(Pixel);
  ApplyContrast(Pixel);
end;

procedure TBrightnessContrastEnhancer.ApplyBrightness(var Pixel: TRGB32);
begin
  ApplyBrightnessTo(Pixel.Red);
  ApplyBrightnessTo(Pixel.Green);
  ApplyBrightnessTo(Pixel.Blue);
end;

procedure TBrightnessContrastEnhancer.ApplyBrightnessTo(var Color: Byte);
begin
  Color:= BrightnessLookupTable[Color];
end;

procedure TBrightnessContrastEnhancer.ApplyContrast(var Pixel: TRGB32);
begin
  ApplyContrastTo(Pixel.Red);
  ApplyContrastTo(Pixel.Green);
  ApplyContrastTo(Pixel.Blue);
end;

procedure TBrightnessContrastEnhancer.ApplyContrastTo(var Color: Byte);
begin
  Color:= ContrastLookupTable[Color];
end;

function TBrightnessContrastEnhancer.GetNormalizedContrast: Double;
begin
  // normalize from [-255..255] to [0..4]
  Result:= (255 + Contrast)/255;
  Result:= Result*Result;
end;

{ TImageInfo }

function TImageInfo.GetHeight: Integer;
begin
  Result:= fPicture.Height;
end;

function TImageInfo.GetPicture: TPicture;
begin
  Result:= TPicture.Create;
  try
    Result.Assign(fPicture);
  except
    Result:= nil;
  end;
end;

function TImageInfo.GetWidth: Integer;
begin
  Result:= fPicture.Width;
end;

constructor TImageInfo.Create(AFileName: string);
begin
  fFileName:= AFileName;
  fFileSize:= FileUtil.FileSize(fFileName);

  fPicture:= TPicture.Create;
  fPicture.LoadFromFile(AFileName);
end;

destructor TImageInfo.Destroy;
begin
  FreeAndNil(fPicture);
  inherited Destroy;
end;

{ TPictureEx }

function TPictureEx.GetPicture: TPicture;
begin
  Result:= GetThumbnail(Round(ZoomFactor*Height),Round(ZoomFactor*Width));
end;

function TPictureEx.GetHeight: Integer;
begin
  Result:= fPicture.Height;
end;

function TPictureEx.GetWidth: Integer;
begin
  Result:= fPicture.Width;
end;

procedure TPictureEx.SetMaxZoom(AValue: Double);
begin
  fMaxZoom:= AValue;
  UpdateIfZoomFactorGreaterThanMaxZoom;
end;

procedure TPictureEx.SetMinZoom(AValue: Double);
begin
  fMinZoom:= AValue;
  UpdateIfZoomFactorLesserThanMinZoom;
end;

procedure TPictureEx.SetZoomFactor(AValue: Double);
begin
  fZoomFactor:= AValue;
  UpdateIfZoomFactorLesserThanMinZoom;
  UpdateIfZoomFactorGreaterThanMaxZoom;
end;

procedure TPictureEx.UpdateIfZoomFactorGreaterThanMaxZoom;
begin
  if ZoomFactor > MaxZoom  then
    fZoomFactor:= MaxZoom;
end;

procedure TPictureEx.UpdateIfZoomFactorLesserThanMinZoom;
begin
  if ZoomFactor < MinZoom then
    fZoomFactor:= MinZoom;
end;

constructor TPictureEx.Create(AFileName: string);
var
  tmpPic: TPicture;
begin
  tmpPic:= TPicture.Create;
  try
    tmpPic.LoadFromFile(AFileName);
    Create(tmpPic);
  finally
    tmpPic.Free;
  end;
end;

constructor TPictureEx.Create(APicture: TPicture);
begin
  MaxZoom:= 10;
  MinZoom:= 0.1;
  ZoomFactor:= 1.0;
  fPicture:= TPicture.Create;
  fPicture.Assign(APicture);
end;

destructor TPictureEx.Destroy;
begin
  fPicture.Free;
  inherited Destroy;
end;

procedure TPictureEx.ZoomIn;
begin
  ZoomFactor:= 2*ZoomFactor;
end;

procedure TPictureEx.ZoomOut;
begin
  ZoomFactor:= ZoomFactor/2;
end;

procedure TPictureEx.RestoreZoom;
begin
  ZoomFactor:= 1;
end;

function TPictureEx.CanZoomIn: Boolean;
begin
  Result:= (ZoomFactor < MaxZoom);
end;

function TPictureEx.CanZoomOut: Boolean;
begin
  Result:= (ZoomFactor > MinZoom);
end;

function TPictureEx.GetThumbnail(AHeight, AWidth: Integer): TPicture;
var
  Rect : TRect;
begin
  Result:= TPicture.Create;
  try
    Rect.Left:= 0;
    Rect.Top:= 0;
    Rect.Right:= AWidth;
    Rect.Bottom:= AHeight;
    Result.Bitmap.Width:= Rect.Right;
    Result.Bitmap.Height:= Rect.Bottom;
    Result.Bitmap.Canvas.StretchDraw(Rect, fPicture.Bitmap) ;
  except
    Result.Free;
  end;
end;

procedure TPictureEx.EnhanceMeWith(AEnhancer: TCustomImageEnhancer);
begin
  fPicture.Assign(AEnhancer.EnhancePicture(fPicture));
end;

{   GrayScale
// calculate luminance for the current pixel
Gray := Round((0.299 * Pixels[X].Red) + (0.587 * Pixels[X].Green) + (0.114 * Pixels[X].Blue));
// and assign the luminance to each color component of the current pixel
Pixels[X].Red := Gray;
Pixels[X].Green := Gray;
Pixels[X].Blue := Gray;
}

end.

