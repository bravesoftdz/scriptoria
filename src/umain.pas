{
    Copyright (C) 2010,2013 João Marcelo S. Vaz

    This file is part of Scriptoria, a program that helps you to transcribe
    scanned old documents, with an interface that combines a text editor
    and an image viewer.

    Scriptoria is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Scriptoria is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

}

unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  PairSplitter, Menus, ExtCtrls, ActnList, StdActns, ComCtrls,
  ExtDlgs, SynEditTypes, SynEdit, LCLIntf, uDialogs, Utils, types;

type

  { TfmMain }

  TfmMain = class(TForm)
    acHelpAbout: TAction;
    acFileClose: TAction;
    acFileSave: TAction;
    acFileNew: TAction;
    acTextFind: TAction;
    acTextFindNext: TAction;
    acTextFindPrevious: TAction;
    acTextReplace: TAction;
    acOptionsImageTop: TAction;
    acOptionsImageLeft: TAction;
    acOptionsImageBottom: TAction;
    acOptionsImageRight: TAction;
    acHelpHelp: TAction;
    acShowFontDialog: TAction;
    acHelpVisitHomePage: TAction;
    acFileOpen: TAction;
    acBrightnessContrast: TAction;
    acColorBalance: TAction;
    acZoomOut: TAction;
    acZoomIn: TAction;
    alImage: TActionList;
    alText: TActionList;
    alApplication: TActionList;
    acFileExit: TFileExit;
    acFileSaveAs: TFileSaveAs;
    acEditCut: TEditCut;
    acEditCopy: TEditCopy;
    acEditDelete: TEditDelete;
    acEditPaste: TEditPaste;
    acEditSelectAll: TEditSelectAll;
    acEditUndo: TEditUndo;
    acEditRedo: TEditUndo;
    FindDialog: TFindDialog;
    FontDialog: TFontDialog;
    ilImageList: TImageList;
    imImage: TImage;
    MainMenu: TMainMenu;
    miImageBrightnessContrast: TMenuItem;
    miImageColorBalance: TMenuItem;
    miImageSep1: TMenuItem;
    miZoomOut: TMenuItem;
    miZoomIn: TMenuItem;
    miHelpHomePage: TMenuItem;
    miShowFontDialog: TMenuItem;
    miTextSep3: TMenuItem;
    miTextDelete: TMenuItem;
    miTextSelectAll: TMenuItem;
    miHelpHelp: TMenuItem;
    miOptionsImageRight: TMenuItem;
    miOptionsImageBottom: TMenuItem;
    miOptionsImageLeft: TMenuItem;
    miOptionsImageTop: TMenuItem;
    miOptionsImagePosition: TMenuItem;
    miOptions: TMenuItem;
    miTextFindPrevious: TMenuItem;
    miTextRedo: TMenuItem;
    miTextReplace: TMenuItem;
    miTextFindNext: TMenuItem;
    miTextFind: TMenuItem;
    miTextSep2: TMenuItem;
    miTextPaste: TMenuItem;
    miTextCut: TMenuItem;
    miTextCopy: TMenuItem;
    miTextSep1: TMenuItem;
    miTextUndo: TMenuItem;
    miText: TMenuItem;
    miImage: TMenuItem;
    miFileSep1: TMenuItem;
    miFileSaveAs: TMenuItem;
    miFileSave: TMenuItem;
    miFileNew: TMenuItem;
    miHelpAbout: TMenuItem;
    miHelpSe1: TMenuItem;
    miFileSep2: TMenuItem;
    miFileClose: TMenuItem;
    miFileOpen: TMenuItem;
    miFileExit: TMenuItem;
    mHelp: TMenuItem;
    miFile: TMenuItem;
    OpenPictureDialog: TOpenPictureDialog;
    ReplaceDialog: TReplaceDialog;
    sbImage: TScrollBox;
    SplitterPanel: TPairSplitter;
    PairSplitterSide0: TPairSplitterSide;
    PairSplitterSide1: TPairSplitterSide;
    pnImage: TPanel;
    pnText: TPanel;
    edText: TSynEdit;
    tbText: TToolBar;
    tbImage: TToolBar;
    tbTextCopy: TToolButton;
    tbTextCut: TToolButton;
    tbTextPaste: TToolButton;
    tbTextRedo: TToolButton;
    tbTextUndo: TToolButton;
    tbTexyDiv1: TToolButton;
    tbTextDiv2: TToolButton;
    tbTextFind: TToolButton;
    tbTextFindNext: TToolButton;
    tbFindPrevious: TToolButton;
    tbReplace: TToolButton;
    tbImageOpen: TToolButton;
    tbImageDiv1: TToolButton;
    tbImageZoomIn: TToolButton;
    tbImageZoomOut: TToolButton;
    tbImageDiv2: TToolButton;
    tbImageBrightnessContrast: TToolButton;
    tbImageColorBalance: TToolButton;
    procedure acBrightnessContrastExecute(Sender: TObject);
    procedure acBrightnessContrastUpdate(Sender: TObject);
    procedure acColorBalanceExecute(Sender: TObject);
    procedure acColorBalanceUpdate(Sender: TObject);
    procedure acEditCopyExecute(Sender: TObject);
    procedure acEditCopyUpdate(Sender: TObject);
    procedure acEditCutExecute(Sender: TObject);
    procedure acEditCutUpdate(Sender: TObject);
    procedure acEditDeleteExecute(Sender: TObject);
    procedure acEditDeleteUpdate(Sender: TObject);
    procedure acEditPasteExecute(Sender: TObject);
    procedure acEditPasteUpdate(Sender: TObject);
    procedure acEditRedoExecute(Sender: TObject);
    procedure acEditRedoUpdate(Sender: TObject);
    procedure acEditSelectAllExecute(Sender: TObject);
    procedure acEditUndoExecute(Sender: TObject);
    procedure acEditUndoUpdate(Sender: TObject);
    procedure acFileOpenExecute(Sender: TObject);
    procedure acHelpAboutExecute(Sender: TObject);
    procedure acOptionsImageBottomExecute(Sender: TObject);
    procedure acOptionsImageLeftExecute(Sender: TObject);
    procedure acOptionsImageRightExecute(Sender: TObject);
    procedure acOptionsImageTopExecute(Sender: TObject);
    procedure acShowFontDialogExecute(Sender: TObject);
    procedure acTextFindExecute(Sender: TObject);
    procedure acTextFindNextExecute(Sender: TObject);
    procedure acTextFindNextUpdate(Sender: TObject);
    procedure acTextFindPreviousExecute(Sender: TObject);
    procedure acTextFindPreviousUpdate(Sender: TObject);
    procedure acTextFindUpdate(Sender: TObject);
    procedure acTextReplaceExecute(Sender: TObject);
    procedure acHelpVisitHomePageExecute(Sender: TObject);
    procedure acTextReplaceUpdate(Sender: TObject);
    procedure acZoomInExecute(Sender: TObject);
    procedure acZoomInUpdate(Sender: TObject);
    procedure acZoomOutExecute(Sender: TObject);
    procedure acZoomOutUpdate(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure FindDialogShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imImageMouseLeave(Sender: TObject);
    procedure imImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imImageMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edTextReplaceText(Sender: TObject; const ASearch,
      AReplace: string; Line, Column: integer;
      var ReplaceAction: TSynReplaceAction);
    procedure ReplaceDialogShow(Sender: TObject);
  private
    { private declarations }
    fCurrentImage: TPictureEx;
    TheSpot : TPoint;
    ImageDragging:Boolean;
    AccumulatedWheelDelta: Integer;
    fSearchText: string;
    fReplaceText: string;
    SearchOptions: TSynSearchOptions;
    ReplaceOptions: TSynSearchOptions;
    procedure ChangeCurrentImage(AFileName: string);
    procedure DoSearchReplaceText(Options: TSynSearchOptions);
    procedure DoZoomOnMouseWheel;
    procedure DrawImage;
    function SearchTextIsNotEmpty: Boolean;
    procedure ShowImageEnhancerDialog(AImageEnhancerDialog: TImageEnhancerDialog);
    function TextIsNotEmpty: Boolean;
    procedure UpdateAccumulatedWheelDelta(WheelDelta: Integer);
  public
    { public declarations }
    procedure SetImagePosition(const APosition: TAlign);
    function ShowPromptDialog(X, Y, Y2: Integer; AReplaceText: string): Integer;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.lfm}

{
 TODO: as the TSynEdit editor is monospaced, changing its font from Courier New is a bad idea.
       But the TMemo doesn't have Search, Replace and Redo features
}

uses VersionInfo, uStrings, uVersion;

const
  MouseWheelDeltaThreshold = 1*120;


{ TfmMain }

procedure TfmMain.FormResize(Sender: TObject);
begin
  if SplitterPanel.SplitterType = pstVertical then
    SplitterPanel.Position:= SplitterPanel.ClientHeight div 2;
  if SplitterPanel.SplitterType = pstHorizontal then
    SplitterPanel.Position:= SplitterPanel.ClientWidth div 2;
end;

function TfmMain.ShowPromptDialog(X, Y, Y2: Integer; AReplaceText: string): Integer;
begin
  with CreateMessageDialog(Format(sReplaceQuestion, [AReplaceText]), mtConfirmation, [ mbYes, mbNo, mbYesToAll ] ) do
    try
      HelpContext := 0;
      if X >= 0 then
        Left:= X;
      if Left + Width > Screen.Width then
        Left:= Screen.Width - Width;
      if Y >= 0 then
        Top:= Y2 + 5;
      if Top + Height > Screen.Height then
        Top:= Y - Height - 5;
      Result:= ShowModal;
    finally
      Free;
    end;
end;

procedure TfmMain.edTextReplaceText(Sender: TObject; const ASearch,
  AReplace: string; Line, Column: integer; var ReplaceAction: TSynReplaceAction
  );
var
  APos: TPoint;
begin
  if ASearch = AReplace then
    ReplaceAction:= raSkip
  else
    begin
      APos := Point(Column, Line);
      APos := edText.ClientToScreen(edText.RowColumnToPixels(APos));
      case ShowPromptDialog(APos.X, APos.Y,APos.Y + edText.LineHeight, ASearch) of
        mrYes:
          ReplaceAction:= raReplace;
        mrYesToAll:
          ReplaceAction:= raReplaceAll;
        mrNo:
          ReplaceAction:= raSkip;
      else
        ReplaceAction:= raCancel;
      end;

    end;
end;


procedure TfmMain.DoSearchReplaceText(Options: TSynSearchOptions);
begin
  if edText.SearchReplace(fSearchText, fReplaceText, Options) = 0 then
    begin
      ShowMessage(Format(sSearchStringNotFound,[fSearchText]));
      if ssoBackwards in Options then
        edText.BlockEnd:= edText.BlockBegin
      else
        edText.BlockBegin:= edText.BlockEnd;
      edText.CaretXY:= edText.BlockBegin;
    end
  else
    if ssoReplace in Options then
      ReplaceDialog.CloseDialog
    else
      FindDialog.CloseDialog;
end;

procedure TfmMain.DoZoomOnMouseWheel;
begin
  if AccumulatedWheelDelta > MouseWheelDeltaThreshold then
    begin
      fCurrentImage.ZoomFactor:= 1.1*fCurrentImage.ZoomFactor;
      DrawImage;
      AccumulatedWheelDelta:= 0;
    end;
  if AccumulatedWheelDelta < -MouseWheelDeltaThreshold then
    begin
      fCurrentImage.ZoomFactor:= fCurrentImage.ZoomFactor/1.1;
      DrawImage;
      AccumulatedWheelDelta:= 0;
    end;
end;

procedure TfmMain.ChangeCurrentImage(AFileName: string);
begin
  fCurrentImage.Free;
  fCurrentImage:= TPictureEx.Create(AFileName);
end;

procedure TfmMain.DrawImage;
begin
  Screen.Cursor:= crHourGlass;
  try
    imImage.Picture.Assign(fCurrentImage.Picture);
  finally
    Screen.Cursor:= crDefault;
  end;
end;

function TfmMain.SearchTextIsNotEmpty: Boolean;
begin
  Result:= (fSearchText <> '')
end;

procedure TfmMain.ShowImageEnhancerDialog(AImageEnhancerDialog: TImageEnhancerDialog);
begin
  with AImageEnhancerDialog do
    try
      Picture:= fCurrentImage.GetThumbnail(100,400);
       if Execute then
        begin
          fCurrentImage.EnhanceMeWith(Enhancer);
          DrawImage;
        end;
    finally
      Free;
    end;
end;

function TfmMain.TextIsNotEmpty: Boolean;
begin
  Result:= Length(edText.Lines.Text) > 1
end;

procedure TfmMain.UpdateAccumulatedWheelDelta(WheelDelta: Integer);
begin
  if (AccumulatedWheelDelta * WheelDelta) > 0 then // same direction
    AccumulatedWheelDelta:= AccumulatedWheelDelta + WheelDelta
  else // changed direction => reset
    AccumulatedWheelDelta:= WheelDelta;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  Caption:= Application.Title;
  acHelpAbout.Caption:= Format(sAboutBoxCaption, [Application.Title]);
  acOptionsImageLeftExecute(Sender);
  AccumulatedWheelDelta:= 0;
end;

procedure TfmMain.acHelpAboutExecute(Sender: TObject);
var
  AboutBox: TAboutBoxDialog;
  PI: TProductInfo;
  FileName: String;
begin
  AboutBox:= TAboutBoxDialog.Create;
  try
    //   populating AboutBox
      AboutBox.Title:= Format(sAboutBoxCaption, [Application.Title]);
      AboutBox.ProgramTitle:= Application.Title;
      AboutBox.HomePage:= HomePage;
      AboutBox.AboutTabCaption:= sAboutTabCaption;
      AboutBox.CreditsTabCaption:= sCreditsTabCaption;
      AboutBox.HistoryTabCaption:= sHistoryTabCaption;
      AboutBox.LicenseTabCaption:= sLicenseTabCaption;
      AboutBox.InfoTabCaption:= sInfoTabCaption;
      AboutBox.ShowHistoryTab:= False;

      // updating Credits memo on AboutBox
      FileName:= AppendPathDelim(ProgramDirectory) + 'credits.txt';
      if FileExists(FileName) then
        AboutBox.Credits.LoadFromFile(FileName)
      else
        AboutBox.Credits.Add(Format(sFileDoesNotExist, [FileName]));


      // updating License memo on AboutBox
      FileName:= AppendPathDelim(ProgramDirectory) + 'license.txt';
      if FileExists(FileName) then
        AboutBox.License.LoadFromFile(FileName)
      else
        AboutBox.License.Add(Format(sFileDoesNotExist, [FileName]));


      // updating History memo on AboutBox
      FileName:= AppendPathDelim(ProgramDirectory) + 'history.txt';
      if FileExists(FileName) then
        AboutBox.History.LoadFromFile(FileName)
      else
        AboutBox.History.Add(Format(sFileDoesNotExist, [FileName]));

      PI:= TProductInfo.Create;
      try
        AboutBox.ProgramVersion:= Format(sVersionCaption, [VersionInfoToString(PI.FileVersion)]);
        AboutBox.Copyright:= PI.LegalCopyright;

        // updating About memo on AboutBox
        AboutBox.About.Add(Application.Title);
        AboutBox.About.Add('');
        AboutBox.About.Add(PI.FileDescription);
        AboutBox.About.Add('');
        AboutBox.About.Add(LicenseNotice1);
        AboutBox.About.Add('');
        AboutBox.About.Add(LicenseNotice2);

        // updating Info memo on AboutBox
        AboutBox.Info.Add(Application.Title);
        AboutBox.Info.Add(Format(sVersionCaption, [VersionInfoToString(PI.FileVersion)]));
        AboutBox.Info.Add(Format(sBuildDate, [DateToStr(PI.BuildDate)]));
        AboutBox.Info.Add(Format(sPlatform, [PI.CPU]));
        AboutBox.Info.Add(Format(sOS, [PI.OS]));
        AboutBox.Info.Add(Format(sWidgetSet, [PI.WidgetSet]));
        AboutBox.Info.Add(Format(sFPCVersionCaption, [VersionInfoToString(PI.FPCVersion)]));
        AboutBox.Info.Add(Format(sLCLVersionCaption, [VersionInfoToString(PI.LCLVersion)]));
      finally
        PI.Free;
      end;

    AboutBox.Execute;
  finally
    AboutBox.Free;
  end;
end;

procedure TfmMain.acOptionsImageBottomExecute(Sender: TObject);
begin
  acOptionsImageTop.Checked:= False;
  acOptionsImageLeft.Checked:= False;
  acOptionsImageBottom.Checked:= True;
  acOptionsImageRight.Checked:= False;
  SetImagePosition(alBottom);
end;

procedure TfmMain.acOptionsImageLeftExecute(Sender: TObject);
begin
  acOptionsImageTop.Checked:= False;
  acOptionsImageLeft.Checked:= True;
  acOptionsImageBottom.Checked:= False;
  acOptionsImageRight.Checked:= False;
  SetImagePosition(alLeft);
end;

procedure TfmMain.acOptionsImageRightExecute(Sender: TObject);
begin
  acOptionsImageTop.Checked:= False;
  acOptionsImageLeft.Checked:= False;
  acOptionsImageBottom.Checked:= False;
  acOptionsImageRight.Checked:= True;
  SetImagePosition(alRight);
end;

procedure TfmMain.acOptionsImageTopExecute(Sender: TObject);
begin
  acOptionsImageTop.Checked:= True;
  acOptionsImageLeft.Checked:= False;
  acOptionsImageBottom.Checked:= False;
  acOptionsImageRight.Checked:= False;
  SetImagePosition(alTop);
end;

procedure TfmMain.acShowFontDialogExecute(Sender: TObject);
begin
  FontDialog.Font:= edText.Font;
  if FontDialog.Execute then
    edText.Font:= FontDialog.Font;
end;

procedure TfmMain.acEditUndoExecute(Sender: TObject);
begin
  edText.Undo;
end;

procedure TfmMain.acEditUndoUpdate(Sender: TObject);
begin
  acEditUndo.Enabled:= edText.CanUndo;
end;

procedure TfmMain.acFileOpenExecute(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
    begin
      ChangeCurrentImage(OpenPictureDialog.FileName);
      DrawImage;
    end;
end;

procedure TfmMain.acEditRedoExecute(Sender: TObject);
begin
  edText.Redo;
end;

procedure TfmMain.acEditRedoUpdate(Sender: TObject);
begin
  acEditRedo.Enabled:= edText.CanRedo;
end;

procedure TfmMain.acEditSelectAllExecute(Sender: TObject);
begin
  edText.SelectAll;
end;

procedure TfmMain.acEditCutExecute(Sender: TObject);
begin
  edText.CutToClipboard;
end;

procedure TfmMain.acEditCutUpdate(Sender: TObject);
begin
  acEditCut.Enabled:= edText.SelAvail;
end;

procedure TfmMain.acEditDeleteExecute(Sender: TObject);
begin
  edText.ClearSelection;
end;

procedure TfmMain.acEditDeleteUpdate(Sender: TObject);
begin
  acEditDelete.Enabled:= edText.SelAvail;
end;

procedure TfmMain.acEditPasteExecute(Sender: TObject);
begin
  edText.PasteFromClipboard;
end;

procedure TfmMain.acEditPasteUpdate(Sender: TObject);
begin
  acEditPaste.Enabled:= edText.CanPaste;
end;

procedure TfmMain.acEditCopyExecute(Sender: TObject);
begin
  edText.CopyToClipboard;
end;

procedure TfmMain.acBrightnessContrastExecute(Sender: TObject);
begin
  ShowImageEnhancerDialog(TBrightnessContrastDialog.Create);
end;

procedure TfmMain.acBrightnessContrastUpdate(Sender: TObject);
begin
  acBrightnessContrast.Enabled:= Assigned(fCurrentImage);
end;

procedure TfmMain.acColorBalanceExecute(Sender: TObject);
begin
  ShowImageEnhancerDialog(TColorBalanceDialog.Create);
end;

procedure TfmMain.acColorBalanceUpdate(Sender: TObject);
begin
  acColorBalance.Enabled:= Assigned(fCurrentImage);
end;

procedure TfmMain.acEditCopyUpdate(Sender: TObject);
begin
  acEditCopy.Enabled:= edText.SelAvail;
end;

procedure TfmMain.acTextFindExecute(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TfmMain.acTextFindNextExecute(Sender: TObject);
begin
  Exclude(SearchOptions, ssoEntireScope);
  Exclude(SearchOptions, ssoBackwards);
  DoSearchReplaceText(SearchOptions);
end;

procedure TfmMain.acTextFindNextUpdate(Sender: TObject);
begin
  acTextFindNext.Enabled:= SearchTextIsNotEmpty;
end;

procedure TfmMain.acTextFindPreviousExecute(Sender: TObject);
begin
  Exclude(SearchOptions, ssoEntireScope);
  Include(SearchOptions, ssoBackwards);
  DoSearchReplaceText(SearchOptions);
end;

procedure TfmMain.acTextFindPreviousUpdate(Sender: TObject);
begin
  acTextFindPrevious.Enabled:= SearchTextIsNotEmpty;
end;

procedure TfmMain.acTextFindUpdate(Sender: TObject);
begin
  acTextFind.Enabled:= TextIsNotEmpty;
end;

procedure TfmMain.acTextReplaceExecute(Sender: TObject);
begin
  ReplaceDialog.Execute;
end;

procedure TfmMain.acHelpVisitHomePageExecute(Sender: TObject);
begin
  OpenURL(HomePage);
end;

procedure TfmMain.acTextReplaceUpdate(Sender: TObject);
begin
  acTextReplace.Enabled:= TextIsNotEmpty;
end;

procedure TfmMain.acZoomInExecute(Sender: TObject);
begin
  fCurrentImage.ZoomIn;
  DrawImage;
end;

procedure TfmMain.acZoomInUpdate(Sender: TObject);
begin
  if Assigned(fCurrentImage) then
    acZoomIn.Enabled:= fCurrentImage.CanZoomIn
  else
    acZoomIn.Enabled:= False;
end;

procedure TfmMain.acZoomOutExecute(Sender: TObject);
begin
  fCurrentImage.ZoomOut;
  DrawImage;
end;

procedure TfmMain.acZoomOutUpdate(Sender: TObject);
begin
  if Assigned(fCurrentImage) then
    acZoomOut.Enabled:= fCurrentImage.CanZoomOut
  else
    acZoomOut.Enabled:= False;
end;

procedure TfmMain.FindDialogFind(Sender: TObject);
begin
  fSearchText:= FindDialog.FindText;
  // assign search options
  SearchOptions:= [];
  if (frMatchCase in FindDialog.Options) then
    Include(SearchOptions, ssoMatchCase);
  if (frWholeWord in FindDialog.Options) then
    Include(SearchOptions, ssoWholeWord);
  if (frEntireScope in FindDialog.Options) then
    Include(SearchOptions, ssoEntireScope);
  if not (frDown in FindDialog.Options) then
    Include(SearchOptions, ssoBackwards);

  DoSearchReplaceText(SearchOptions);
end;

procedure TfmMain.FindDialogShow(Sender: TObject);
begin
  // if something is selected search for that text
  if edText.SelAvail and (edText.BlockBegin.Y = edText.BlockEnd.Y) then
    FindDialog.FindText := edText.SelText
  else
    FindDialog.FindText := edText.GetWordAtRowCol(edText.CaretXY);
  if FindDialog.FindText = '' then
    FindDialog.FindText:= fSearchText;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  fCurrentImage.Free;
end;

procedure TfmMain.imImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft)and Assigned(fCurrentImage) then
    begin
      ImageDragging:= True;
      TheSpot.X:=X;
      TheSpot.Y:=Y;
      imImage.Cursor:= crHandPoint;
    end;
end;

procedure TfmMain.imImageMouseLeave(Sender: TObject);
begin
  if ImageDragging then
    begin
      ImageDragging:= False;
      imImage.Cursor:= crDefault;
    end;
end;

procedure TfmMain.imImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ImageDragging then
    begin
      sbImage.ScrollBy(X - TheSpot.X,Y  - TheSpot.Y);
      TheSpot.X:=X;
      TheSpot.Y:=Y;
    end;
end;

procedure TfmMain.imImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ImageDragging then
    begin
      ImageDragging:= False;
      imImage.Cursor:= crDefault;
    end;
end;

procedure TfmMain.imImageMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if Assigned(fCurrentImage) then
    begin
      UpdateAccumulatedWheelDelta(WheelDelta);
      DoZoomOnMouseWheel;
    end;
  Handled:= True;
end;

procedure TfmMain.ReplaceDialogReplace(Sender: TObject);
begin
//  Include(ReplaceOptions, ssoPrompt);
  fSearchText:= ReplaceDialog.FindText;
  fReplaceText:= ReplaceDialog.ReplaceText;
  // assign search options
  ReplaceOptions:= [ssoPrompt, ssoReplace, ssoReplaceAll];
  if (frMatchCase in ReplaceDialog.Options) then
    Include(ReplaceOptions, ssoMatchCase);
  if (frWholeWord in ReplaceDialog.Options) then
    Include(ReplaceOptions, ssoWholeWord);
  if (frEntireScope in ReplaceDialog.Options) then
    Include(ReplaceOptions, ssoEntireScope);
  if not (frDown in ReplaceDialog.Options) then
    Include(ReplaceOptions, ssoBackwards);

  DoSearchReplaceText(ReplaceOptions);
end;

procedure TfmMain.ReplaceDialogShow(Sender: TObject);
begin
  // if something is selected search for that text
  if edText.SelAvail and (edText.BlockBegin.Y = edText.BlockEnd.Y) then
    ReplaceDialog.FindText := edText.SelText
  else
    ReplaceDialog.FindText := edText.GetWordAtRowCol(edText.CaretXY);
  if ReplaceDialog.FindText = '' then
    ReplaceDialog.FindText:= fSearchText;
  ReplaceDialog.ReplaceText:= fReplaceText;
end;

procedure TfmMain.SetImagePosition(const APosition: TAlign);
begin
  if APosition = alTop then
    begin
      SplitterPanel.SplitterType:= pstVertical;
      SplitterPanel.Cursor:= crVSplit;
      pnImage.Parent:= SplitterPanel.Sides[0];
      pnText.Parent:= SplitterPanel.Sides[1];
    end;
  if APosition = alBottom then
    begin
      SplitterPanel.SplitterType:= pstVertical;
      SplitterPanel.Cursor:= crVSplit;
      pnText.Parent:= SplitterPanel.Sides[0];
      pnImage.Parent:= SplitterPanel.Sides[1];
    end;
  if APosition = alRight then
    begin
      SplitterPanel.SplitterType:= pstHorizontal;
      SplitterPanel.Cursor:= crHSplit;
      pnText.Parent:= SplitterPanel.Sides[0];
      pnImage.Parent:= SplitterPanel.Sides[1];
    end;
  if APosition = alLeft then
    begin
      SplitterPanel.SplitterType:= pstHorizontal;
      SplitterPanel.Cursor:= crHSplit;
      pnText.Parent:= SplitterPanel.Sides[1];
      pnImage.Parent:= SplitterPanel.Sides[0];
   end;
end;


end.

{

(*
  SAR.PAS 1.1
  --------  --------  --------  --------  --------  --------  --------  --------
  Contents:
     TSearchAndReplace - Simple-To-Use Text Search & Replace component which
                         wraps the functionallity of TFindDialog and
                         TReplaceDialog.

  --------  --------  --------  --------  --------  --------  --------  --------
     Copyrights (C) 1997 ved T Skovmand Eriksen
     email: TSEriksen@cyberdude.com
     ALL RIGHTS RESERVED

     PARTS MAY BE COPYRIGHTED BY BORLAND INTL.
  --------  --------  --------  --------  --------  --------  --------  --------

  This source is freeware and may be used as follows:

    * In development of in-house applications which will not be published.

    * In development of freeware applications PROVIDED that credit is given
      to me in the applications aboutbox or helpfile.

    * In development of shareware and commercial applications PROVIDED that
      I, Troels S Eriksen, recieve a free unlimited copy of all versions of
      said application AND that credits are given to me in the applications
      aboutbox or helpfile.

    * In printed or electronic form (fx. in a book) or in a source-library
      (fx. on CD) PROVIDED that I, Troels S Eriksen, recieve a royality-free
      unlimited copy of said book or library.

    * In any other way PROVIDED that I, Troels S Eriksen, give my explicit
      permission to the suggested use.

  By using this source you do acknowledge that the above restrictions apply to
  you and your use of this component and that you will confirm by them.

  --------  --------  --------  --------  --------  --------  --------  --------

  Revision history:
    TSearchAndReplace
     Rev 01 - Control created.
     Rev 02 - SearchMemo() rewritten using ideas from a Borland DemoApp.
     Rev 03 - Full national chars support (runtime detect) added.
     Rev 04 - Minor bug-fixes implemented.

  --------  --------  --------  --------  --------  --------  --------  --------

  Thanks to:
    * Warny B Saurbrey - Who patiently Alfa-tests a lot of my stuff

  --------  --------  --------  --------  --------  --------  --------  --------

  TSearchAndReplace Properties:
    * Memo      - The TMemo that should be searced.
    * NotFound  - The message shown when no more matches is found. Should
                  contain "%s" for inserting the find-text.

  TSearchAndReplace Methods:
    * FindDialog    - Start a search session.
    * FindNext      - Continues a previous search
    * ReplaceDialog - Start a search and replace session

  --------  --------  --------  --------  --------  --------  --------  --------

  Known bugs and other issues:

    TSearchAndReplace
    * AV occured when memo contained more than 8 Kb text - fixed.
    * Memo didn't scroll correctly when text was found - fixed.

  --------  --------  --------  --------  --------  --------  --------  --------

  How to use:
    Drop a SearchAndReplace component on a form or datamodule. Link
    it to a Memo-field. Set the Memo's Hideselection property to false.
    Now just call the methods "FindDialog", "FindNext" and/or "ReplaceDialog"
    from your application's menu or toolbar. Nothing else is required.

  --------  --------  --------  --------  --------  --------  --------  --------
*)

unit SAR;

{$MODE Delphi}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TDelimiter = Set of char;

type
  TSearchAndReplace = class(TComponent)
  private
    fFindDialog    : TFindDialog;
    fReplaceDialog : TReplaceDialog;
    fMemo          : TCustomEdit;
    fNotFound      : string;
  protected
    function  SearchMemo(Memo: TCustomEdit;Find:TFindDialog):Boolean;
    procedure OnFindEvent(sender:TObject);
    procedure OnReplaceEvent(sender:TObject);

  public
    WordDelimiters: TDelimiter;

    constructor Create(AnOwner:TComponent); override;
    destructor  Destroy; override;
    procedure   Free;

    procedure   FindDialog;
    procedure   ReplaceDialog;
    procedure   FindNext;
  published
    property  Memo    : TCustomEdit read fMemo write fMemo;
    property  NotFound: string read fNotFound write fNotFound;
  end;

procedure Register;

implementation

constructor TSearchAndReplace.Create(AnOwner:TComponent);
var
  c : char;
begin
  inherited ;
  Memo   :=NIL;
  fFindDialog   :=TFindDialog.Create(Application.MainForm);
  fReplaceDialog:=TReplaceDialog.Create(Application.MainForm);

  fFindDialog   .OnFind:=OnFindEvent;
  fReplaceDialog.OnFind:=OnFindEvent;
  fReplaceDialog.OnReplace:=OnReplaceEvent;
  fNotFound:='"%s" was not found in text';
  WordDelimiters:=[#0..#255];
  For c:=#0 to #255 do if isCharAlphaNumeric(c) then
    WordDelimiters:=WordDelimiters-[c];
end;

destructor TSearchAndReplace.Destroy;
begin
  fFindDialog.Destroy;
  fReplaceDialog.Destroy;
  inherited ;
end;

procedure TSearchAndReplace.free;
begin
  fFindDialog.free;
  fReplaceDialog.free;
  inherited ;
end;

function TSearchAndReplace.SearchMemo(Memo: TCustomEdit;Find:TFindDialog):boolean;

  function SearchBuf(const Buf: PChar; BufLen: Integer;
                     SelStart, SelLength: Integer;
                     const SearchString: String;
                     Options: TFindOptions): PChar;
  { This sub-function is a minor rewrite of a function in a Borland
    Demo-application.
  }
  var
    SearchCount, I: Integer;
    C: Char;
    Direction: integer;

    function FindNextWordStart(var BufPtr: PChar): Boolean;
    begin
      Result := False;
       { When Direction is forward (1), skip non delimiters, then skip delimiters. }
       { When Direction is backward (-1), skip delims, then skip non delims }
      while (SearchCount > 0) and
            ((Direction = 1) xor (BufPtr^ in WordDelimiters)) do begin
        Inc(BufPtr, Direction);
        Dec(SearchCount);
      end;
      while (SearchCount > 0) and
            ((Direction = -1) xor (BufPtr^ in WordDelimiters)) do begin
        Inc(BufPtr, Direction);
        Dec(SearchCount);
      end;
      Result := SearchCount >= 0;
      if (Direction = -1) and (BufPtr^ in WordDelimiters) then begin
        { back up one char, to leave ptr on first non delim }
        Dec(BufPtr, Direction);
        Inc(SearchCount);
      end;
    end;

  begin
    Result := nil;
    if BufLen <= 0 then Exit;
    if frDown in Options then begin
      Direction := 1;
      Inc(SelStart, SelLength);
      SearchCount := BufLen - SelStart - Length(SearchString);
      if SearchCount < 0 then Exit;
      if Longint(SelStart) + SearchCount > BufLen then Exit;
    end else begin
      Direction := -1;
      Dec(SelStart, Length(SearchString));
      SearchCount := SelStart;
    end;
    if (SelStart < 0) or (SelStart > BufLen) then Exit;
    Result := @Buf[SelStart];
    while SearchCount >= 0 do begin
      if frWholeWord in Options then
        if not FindNextWordStart(Result) then Break;
      I := 0;
      while (Result[I] = SearchString[I+1]) do begin
        Inc(I);
        if I >= Length(SearchString) then begin
          if (not (frWholeWord in Options)) or
             (SearchCount = 0) or
             (Result[I] in WordDelimiters) then Exit;
          Break;
        end;
      end;
      Inc(Result, Direction);
      Dec(SearchCount);
    end;
    Result := nil;
  end;
var
  size   : integer;
  pM,pO  : PChar;
  Buffer : pChar;
begin
  Result := False;
  if (Length(Find.FindText) = 0) or
     (Memo.GetTextLen = 0) then Exit;
  If frMatchCase in Find.Options then begin
    pO:=pChar(Memo.Text);
    pM:=SearchBuf(pO, Memo.GetTextLen, Memo.SelStart, Memo.SelLength,
                  Find.FindText, Find.Options);
  end else try
    // Fejl ved Search and Replace i filer over 8 Kb opstår muligvis her !
    // Kan det tænkes, at der kun er "plads" til 8K på heap/stack ?
    size:=Memo.GetTextLen;
    GetMem(Buffer,size+4);
    StrPLCopy(Buffer,AnsiLowercase(Memo.Text)+#0,Size+1);
    pO:=Buffer;
    pM:=SearchBuf(pO, size, Memo.SelStart, Memo.SelLength,
                  AnsiLowercase(Find.FindText), Find.Options);
  finally
    FreeMem(Buffer,size+4);
  end;
  if pM<>nil then begin
    Memo.SelStart:=pM-pO;
    Memo.SelLength:=Length(Find.FindText);
    Result := True;
  end;
end;

procedure TSearchAndReplace.OnFindEvent(sender:TObject);
begin
  If not SearchMemo(fMemo,TFindDialog(Sender)) then
   application.messagebox(
    pChar(Format(NotFound,[TFindDialog(Sender).FindText])),
    pChar(Application.Title), mb_ok or Mb_IconInformation);
  Memo.perform(EM_SCROLLCARET,0,0)
end;

procedure TSearchAndReplace.OnReplaceEvent(sender:TObject);
begin
  With TReplaceDialog(sender) do if not (frReplaceAll in options) then begin
    if fMemo.SelLength>0 then
      fMemo.SelText:=fReplaceDialog.ReplaceText;
    if not SearchMemo(fMemo,fReplaceDialog) then
      application.messagebox(
       pChar(Format(NotFound,[fReplaceDialog.FindText])),
       pChar(Application.Title),mb_ok or Mb_IconInformation);
  end else begin
    fMemo.SelStart:=0;
    fMemo.Sellength:=0;
    while SearchMemo(fMemo,fReplaceDialog) do
      fMemo.SelText:=fReplaceDialog.ReplaceText;
    fMemo.SelStart:=0;
  end;
end;

procedure TSearchAndReplace.FindDialog;
{ Shows the FindDialog and thus starts the find-session.
}
begin
  if fMemo.SelLength>0 then
    fFindDialog.FindText:=fMemo.Seltext;
  fFindDialog.Options:=[frDown];
  fMemo.SelLength:=0;
  fFindDialog.Execute;
end;

procedure TSearchAndReplace.FindNext;
{ Allows the search to be continued after the FindDialog is closed - in
  Windows Notepad this would be the user pressing "F3"
}
begin
  if fFindDialog.FindText>'' then
    OnFindEvent(fFindDialog);
  Memo.perform(EM_SCROLLCARET,0,0)
end;

procedure TSearchAndReplace.ReplaceDialog;
{ Shows the ReplaceDialog and starts a "Search & Replace" session
}
begin
  if fMemo.SelLength>0 then
    fReplaceDialog.FindText:=fMemo.Seltext;
  fReplaceDialog.Options:=[frDown];
  fMemo.SelLength:=0;
  fReplaceDialog.Execute;
end;

{ -- Register ---------------------------------------------------------------- }

procedure Register;
begin
  RegisterComponents('Samples', [TSearchAndReplace]);
end;

end.

(*
{ Search for textstring in a memo - may be faster than
  SearchMemo, but searches only forwards and cannot search
  for "whole word only"...
}
function SearchForward(Memo:TMemo;Find:TFindDialog):Boolean;
var
  pc   : pChar;
  fc   : pChar;
begin
  // Match Case
  With Find do if (frMatchcase in options) then begin
    pC :=pChar(memo.text);
    fc:=StrPos(@pC[memo.selstart+memo.sellength],pChar(findtext));
  end else begin
    pC :=pChar(AnsiLowercase(memo.text));
    fc:=StrPos(@pC[memo.selstart+memo.sellength],
               pChar(AnsiLowercase(findtext)));
  end;
  // Search
  if fc<>nil then with Find do begin
    memo.selstart:=fc-pc;
    memo.sellength:=length(findtext);
    memo.perform(EM_SCROLLCARET,0,0);
    result:=TRUE;
  end else
    result:=FALSE;
end;

*)

}
