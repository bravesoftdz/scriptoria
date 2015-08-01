unit EnhanceImageFrm;

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, ComCtrls, ExtCtrls, Utils;

type

  { TEnhanceImageForm }

  TEnhanceImageForm = class(TForm)
    btCancel: TButton;
    btOK: TButton;
    btReset: TButton;
    edBrightness: TSpinEdit;
    edContrast: TSpinEdit;
    imOriginal: TImage;
    imNew: TImage;
    lbCyan: TLabel;
    lbColorLevels: TLabel;
    lbMagenta: TLabel;
    lbYellow: TLabel;
    lbRed: TLabel;
    lbGreen: TLabel;
    lbBlue: TLabel;
    lbBrightness: TLabel;
    lbContrast: TLabel;
    PageControl: TPageControl;
    edRed: TSpinEdit;
    edGreen: TSpinEdit;
    edBlue: TSpinEdit;
    tbBightnessContrast: TTabSheet;
    tbBrightness: TTrackBar;
    tbColorbalance: TTabSheet;
    tbContrast: TTrackBar;
    tbRed: TTrackBar;
    tbGreen: TTrackBar;
    tbBlue: TTrackBar;
    procedure btResetClick(Sender: TObject);
    procedure edBlueChange(Sender: TObject);
    procedure edBrightnessChange(Sender: TObject);
    procedure edContrastChange(Sender: TObject);
    procedure edGreenChange(Sender: TObject);
    procedure edRedChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbBlueChange(Sender: TObject);
    procedure tbBrightnessChange(Sender: TObject);
    procedure tbContrastChange(Sender: TObject);
    procedure tbGreenChange(Sender: TObject);
    procedure tbRedChange(Sender: TObject);
  private
    { private declarations }
    fEnhancer: TCustomImageEnhancer;
    procedure BrightnessContrastChanged;
    procedure ColorBalanceChanged;
    procedure UpdateBrightnessContrastEnhancer;
    procedure UpdateColorBalanceEnhancer;
    procedure UpdateImage;
  public
    { public declarations }
    procedure SetEnhancer(AEnhancer: TCustomImageEnhancer);
    procedure SetImage(APicture: TPicture);
    procedure SetDialogAsBrightnessAndContrast;
    procedure SetBrightnessAndContrast(Brightness,Contrast: Integer);
    function GetBrightness: Integer;
    function GetContrast: Integer;
    procedure SetDialogAsRedGreenBlue;
    procedure SetRedGreenBlue(Red,Green,Blue: Integer);
    function GetRed: Integer;
    function GetGreen: Integer;
    function GetBlue: Integer;
   end;

var
  EnhanceImageForm: TEnhanceImageForm;

implementation

{$R *.lfm}

{ TEnhanceImageForm }

procedure TEnhanceImageForm.btResetClick(Sender: TObject);
begin
  SetBrightnessAndContrast(0,0);
  SetRedGreenBlue(0,0,0);
  UpdateImage;
end;

procedure TEnhanceImageForm.edContrastChange(Sender: TObject);
begin
  tbContrast.Position:= edContrast.Value;
  BrightnessContrastChanged;
end;

procedure TEnhanceImageForm.edBlueChange(Sender: TObject);
begin
  tbBlue.Position:= edBlue.Value;
  ColorBalanceChanged;
end;

procedure TEnhanceImageForm.edBrightnessChange(Sender: TObject);
begin
  tbBrightness.Position:= edBrightness.Value;
  BrightnessContrastChanged;
end;

procedure TEnhanceImageForm.edGreenChange(Sender: TObject);
begin
  tbGreen.Position:= edGreen.Value;
  ColorBalanceChanged;
end;

procedure TEnhanceImageForm.edRedChange(Sender: TObject);
begin
  tbRed.Position:= edRed.Value;
  ColorBalanceChanged;
end;

procedure TEnhanceImageForm.FormDestroy(Sender: TObject);
begin
  if Assigned(fEnhancer) then
    fEnhancer.Free;
end;

procedure TEnhanceImageForm.tbBlueChange(Sender: TObject);
begin
  edBlue.Value:= tbBlue.Position;
  ColorBalanceChanged;
end;

procedure TEnhanceImageForm.tbBrightnessChange(Sender: TObject);
begin
  edBrightness.Value:= tbBrightness.Position;
  BrightnessContrastChanged;
end;

procedure TEnhanceImageForm.tbContrastChange(Sender: TObject);
begin
  edContrast.Value:= tbContrast.Position;
  BrightnessContrastChanged;
end;

procedure TEnhanceImageForm.tbGreenChange(Sender: TObject);
begin
  edGreen.Value:= tbGreen.Position;
  ColorBalanceChanged;
end;

procedure TEnhanceImageForm.tbRedChange(Sender: TObject);
begin
  edRed.Value:= tbRed.Position;
  ColorBalanceChanged;
end;

procedure TEnhanceImageForm.UpdateBrightnessContrastEnhancer;
begin
  TBrightnessContrastEnhancer(fEnhancer).Brightness:= tbBrightness.Position;
  TBrightnessContrastEnhancer(fEnhancer).Contrast:= tbContrast.Position;
end;

procedure TEnhanceImageForm.BrightnessContrastChanged;
begin
  UpdateBrightnessContrastEnhancer;
  UpdateImage;
end;

procedure TEnhanceImageForm.ColorBalanceChanged;
begin
  UpdateColorBalanceEnhancer;
  UpdateImage;
end;

procedure TEnhanceImageForm.UpdateColorBalanceEnhancer;
begin
  TColorBalanceEnhancer(fEnhancer).Red:= tbRed.Position;
  TColorBalanceEnhancer(fEnhancer).Green:= tbGreen.Position;;
  TColorBalanceEnhancer(fEnhancer).Blue:= tbBlue.Position;
end;

procedure TEnhanceImageForm.UpdateImage;
begin
  imNew.Picture.Assign(fEnhancer.EnhancePicture(imOriginal.Picture));
end;

procedure TEnhanceImageForm.SetDialogAsBrightnessAndContrast;
begin
  PageControl.ActivePageIndex:= 0;
end;

procedure TEnhanceImageForm.SetEnhancer(AEnhancer: TCustomImageEnhancer);
begin
  fEnhancer:= AEnhancer;
end;

procedure TEnhanceImageForm.SetImage(APicture: TPicture);
begin
  if Assigned(APicture) then
    begin
      imOriginal.Picture.Assign(APicture);
      imNew.Picture.Assign(APicture);
    end;
end;


procedure TEnhanceImageForm.SetBrightnessAndContrast(Brightness,
  Contrast: Integer);
begin
  tbBrightness.Position:= Brightness;
  edBrightness.Value:= Brightness;
  tbContrast.Position:= Contrast;
  edContrast.Value:= Contrast;
end;

function TEnhanceImageForm.GetBrightness: Integer;
begin
  Result:= edBrightness.Value;
end;

function TEnhanceImageForm.GetContrast: Integer;
begin
  Result:= edContrast.Value;
end;

procedure TEnhanceImageForm.SetDialogAsRedGreenBlue;
begin
  PageControl.ActivePageIndex:= 1;
end;

procedure TEnhanceImageForm.SetRedGreenBlue(Red, Green, Blue: Integer);
begin
  tbRed.Position:= Red;
  edRed.Value:= Red;
  tbGreen.Position:= Green;
  edGreen.Value:= Green;
  tbBlue.Position:= Blue;
  edBlue.Value:= Blue;
end;

function TEnhanceImageForm.GetRed: Integer;
begin
  Result:= edRed.Value;
end;

function TEnhanceImageForm.GetGreen: Integer;
begin
  Result:= edGreen.Value;
end;

function TEnhanceImageForm.GetBlue: Integer;
begin
  Result:= edBlue.Value;
end;

end.

