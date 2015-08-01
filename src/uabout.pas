{
    Copyright (C) 2010 João Marcelo S. Vaz

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

unit uAbout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    lbCopyright: TLabel;
    lbHomePage: TLabel;
    mmHistory: TMemo;
    mmInfo: TMemo;
    mmCredits: TMemo;
    mmLicense: TMemo;
    mmAbout: TMemo;
    PageControl: TPageControl;
    ProgramIcon: TImage;
    lbProgramVersion: TLabel;
    lbProgramTitle: TLabel;
    tsHistory: TTabSheet;
    tsInfo: TTabSheet;
    tsLicense: TTabSheet;
    tsCredits: TTabSheet;
    tsAbout: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure lbHomePageClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    class procedure ShowMe;
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.lfm}

uses  LCLIntf;

{ TAboutBox }

procedure TAboutBox.FormShow(Sender: TObject);
begin
  PageControl.ActivePage:= tsAbout;

  ProgramIcon.Picture.Icon:= Application.Icon;
end;

procedure TAboutBox.lbHomePageClick(Sender: TObject);
begin
  OpenURL(lbHomePage.Caption);
end;


class procedure TAboutBox.ShowMe;
begin
  AboutBox:= TAboutBox.Create(nil) ;
  try
    AboutBox.ShowModal;
  finally
    AboutBox.Release;
  end;
end;

end.

