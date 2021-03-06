{
    This file is part of Dev-C++
    Copyright (c) 2004 Bloodshed Software

    Dev-C++ is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Dev-C++ is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dev-C++; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

{$WARN UNIT_PLATFORM OFF}
unit NewProjectFrm;

interface

uses
{$IFDEF WIN32}
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls, ImgList, Buttons, ComCtrls, Templates, Inifiles,
    devTabs, XPMenu;
{$ENDIF}
{$IFDEF LINUX}
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QImgList, QButtons, QComCtrls, Templates, Inifiles,
  devTabs;
{$ENDIF}

type
    TNewProjectForm = class(TForm)
        btnOk: TBitBtn;
        btnCancel: TBitBtn;
        ImageList: TImageList;
        TabsMain: TdevTabs;
        ProjView: TListView;
        pnlDesc: TPanel;
        lblDesc: TLabel;
        TemplateLabel: TLabel;
        btnHelp: TBitBtn;
        XPMenu: TXPMenu;
        lblPrjName: TLabel;
        Label2: TGroupBox;
        GroupBox1: TGroupBox;
        rbC: TRadioButton;
        cbDefault: TCheckBox;
        rbCpp: TRadioButton;
        edProjectName: TEdit;
        Label1: TLabel;
        procedure ProjViewChange(Sender: TObject; Item: TListItem;
            Change: TItemChange);
        procedure FormCreate(Sender: TObject);
        procedure LoadText;
        procedure FormDestroy(Sender: TObject);
        procedure TabsMainChange(Sender: TObject);
        procedure ProjViewDblClick(Sender: TObject);
        procedure btnCancelClick(Sender: TObject);
        procedure btnHelpClick(Sender: TObject);
    private
        procedure AddTemplate(FileName: string);
        procedure ReadTemplateIndex;
    private
        fTemplates: TList;
        procedure UpdateView;
    public
        function GetTemplate: TTemplate;
    end;

implementation

uses
{$IFDEF WIN32}
    FileCtrl,
{$ENDIF}
    MultiLangSupport, utils, datamod, devcfg, version, project, prjtypes, hh;
{$R *.dfm}

procedure TNewProjectForm.FormCreate(Sender: TObject);
begin
    LoadText;
    TemplateLabel.Font.Color := clNavy;
    fTemplates := TList.Create;
    ReadTemplateIndex;
    edProjectName.Text := format(Lang[ID_NEWPROJECT], [dmMain.GetNumber]);
end;

procedure TNewProjectForm.FormDestroy(Sender: TObject);
begin
    fTemplates.Free;
end;

procedure TNewProjectForm.AddTemplate(FileName: string);
var
    Template: TTemplate;
begin
    if not FileExists(FileName) then
        exit;
    Template := TTemplate.Create;
    Template.ReadTemplateFile(FileName);
    fTemplates.Add(Template);
end;

procedure TNewProjectForm.ReadTemplateIndex;
var
    i: integer;
    LTemplates: TStringList;
    sDir: string;
begin
    sDir := devDirs.Templates;
    if not CheckChangeDir(sDir) then
    begin
        MessageDlg('Could not change to the Templates directory (' +
            devDirs.Templates + ')...', mtError, [mbOk], 0);
        Exit;
    end;
    LTemplates := TStringList.Create;
    try
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;
        FilesFromWildCard(devDirs.Templates, '*' + TEMPLATE_EXT,
            LTemplates, FALSE, FALSE, TRUE);
        if LTemplates.Count > 0 then
        begin
            for i := 0 to pred(LTemplates.Count) do
                AddTemplate(LTemplates[i]);
            // EAB TODO:* All templates are loaded here.. can we load each one only when actually get's used?
            UpdateView;
        end;
    finally
        LTemplates.Free;
        Screen.Cursor := crDefault;
    end;
end;

function TNewProjectForm.GetTemplate: TTemplate;
var
    Opts: TProjectProfileList;
begin
    Opts := TProjectProfileList.Create;
    if assigned(ProjView.Selected) then
    begin
        result := TTemplate(fTemplates[integer(ProjView.Selected.Data)]);
        Opts.CopyDataFrom(result.OptionsRec);
    end
    else
    begin
        result := TTemplate.Create;
        result.Version := -1;
    end;
    result.ProjectName := edProjectName.Text;
    Opts.useGPP := rbCpp.Checked;
    result.OptionsRec.CopyDataFrom(Opts);
end;

procedure TNewProjectForm.ProjViewChange(Sender: TObject; Item: TListItem;
    Change: TItemChange);
var
    LTemplate: TTemplate;
begin
    if not assigned(ProjView.Selected) then
    begin
        TemplateLabel.Caption := '';
        btnOk.Enabled := FALSE;
    end
    else
    begin
        btnOk.Enabled := TRUE;
        LTemplate := TTemplate(fTemplates[integer(ProjView.Selected.Data)]);
        if not assigned(LTemplate) then
            exit;
        TemplateLabel.Caption := LTemplate.Description;

        if LTemplate.OptionsRec.useGPP then
        begin
            rbC.Enabled := FALSE;
            rbCpp.Checked := TRUE;
        end
        else
            rbC.Enabled := TRUE;
    end;
end;

procedure TNewProjectForm.LoadText;
begin
    DesktopFont := TRUE;
    XPMenu.Active := devData.XPTheme;
    Caption := Lang[ID_NP];
    lblDesc.Caption := Lang[ID_NP_DESC];
    lblPrjName.Caption := Lang[ID_NP_PRJNAME];
    rbC.Caption := Lang[ID_NP_DEFAULTC];
    rbCpp.Caption := Lang[ID_NP_DEFAULTCPP];
    cbDefault.Caption := Lang[ID_NP_MAKEDEFAULT];
    Label2.Caption := Lang[ID_NP_PRJOPTIONS];

    btnOk.Caption := Lang[ID_BTN_OK];
    btnCancel.Caption := Lang[ID_BTN_CANCEL];
    btnHelp.Caption := Lang[ID_BTN_HELP];
end;

procedure TNewProjectForm.UpdateView;
    function HasPage(const value: string): boolean;
    var
        idx: integer;
    begin
        result := TRUE;
        for idx := 0 to pred(TabsMain.Tabs.Count) do
            if AnsiCompareText(TabsMain.Tabs[idx], Value) = 0 then
                exit;
        result := FALSE;
    end;
var
    idx: integer;
    LTemplate: TTemplate;
    Item: TListItem;
    LIcon: TIcon;
    fName: string;
begin
    for idx := 0 to pred(fTemplates.Count) do
    begin
        LTemplate := TTemplate(fTemplates[idx]);
        if not HasPage(LTemplate.Catagory) then
            TabsMain.Tabs.Append(LTemplate.Catagory);
    end;

    ProjView.Items.Clear;
    for idx := pred(ImageList.Count) downto 6 do
        ImageList.Delete(idx);

    for idx := 0 to pred(fTemplates.Count) do
    begin
        LTemplate := TTemplate(fTemplates[idx]);
        if LTemplate.Catagory = '' then
            LTemplate.Catagory := Lang[ID_NP_PRJSHEET];
        if AnsiCompareText(LTemplate.Catagory,
            TabsMain.Tabs[TabsMain.TabIndex]) = 0 then
        begin
            Item := ProjView.Items.Add;
            Item.Caption := LTemplate.Name;
            Item.Data := pointer(idx);
            fName := ValidateFile(LTemplate.OptionsRec[0].Icon,
                ExtractFilePath(LTemplate.FileName));
            if fName <> '' then
            begin
                LIcon := TIcon.Create;
                try
                    LIcon.LoadFromFile(ExpandFileto(fName,
                        ExtractFilePath(LTemplate.FileName)));
                    Item.ImageIndex := ImageList.AddIcon(LIcon);
                    if Item.ImageIndex = -1 then
                        Item.ImageIndex := 0;
                finally
                    LIcon.Free;
                end;
            end
            else
                Item.ImageIndex := LTemplate.IconIndex;
        end;
    end;
end;

procedure TNewProjectForm.TabsMainChange(Sender: TObject);
begin
    UpdateView;
end;

procedure TNewProjectForm.ProjViewDblClick(Sender: TObject);
begin
    if assigned(ProjView.Selected) then
    begin
        ModalResult := mrOk;
    end;
end;

procedure TNewProjectForm.btnCancelClick(Sender: TObject);
begin
    Dec(dmMain.fProjectCount);
end;

procedure TNewProjectForm.btnHelpClick(Sender: TObject);
begin
    HelpFile := devDirs.Help + DEV_MAINHELP_FILE;
    HtmlHelp(self.handle, pchar(HelpFile), HH_DISPLAY_TOPIC,
        DWORD(pchar('html\creating_project.html')));
    //Application.HelpJump('ID_CREATEPROJECT');
end;

end.
