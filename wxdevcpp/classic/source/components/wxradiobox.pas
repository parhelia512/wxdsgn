 { ****************************************************************** }
 {                                                                    }
 {                                                                    }
 {   VCL component TWxRadioBox                                       }
 {                                                                    }
{                                                                    }
{   Copyright � 2003-2007 by Guru Kathiresan                         }
{                                                                    }
{License :                                                           }
{=========                                                           }
{The wx-devC++ Components, Form Designer, Utils classes              }
{are exclusive properties of Guru Kathiresan.                        }
{The code is available in dual Licenses:                             }
{                               1)GPL Compatible  License            }
{                               2)Commercial License                 }
{                                                                    }
{1)GPL License :                                                     }
{ Code can be used in any project as long as the project's sourcecode}
{ is published under GPL license.                                    }
{                                                                    }
{2)Commercial License:                                               }
{Use of code in this file or the one that bear this license text     }
{can be used in Non-GPL projects as long as you get the permission   }
{from the Author - Guru Kathiresan.                                  }
{Use of the Code in any non-gpl projects without the permission of   }
{the author is illegal.                                              }
{Contact gururamnath@yahoo.com for details                           }
{ ****************************************************************** }


unit WxRadioBox;

interface

uses WinTypes, WinProcs, Messages, SysUtils, Classes, Controls, MultiLangSupport,
  Forms, Graphics, StdCtrls, Wxutils, ExtCtrls, WxSizerPanel, WxToolBar, Dialogs, Math, CustomWXDRadioGroup;

type
  TWxRadioBox = class(TWXDRadioGroup, IWxComponentInterface,IWxVariableAssignmentInterface)
  private
    { Private fields of TWxRadioBox }
    FEVT_RADIOBOX: string;
    FEVT_UPDATE_UI: string;
    FWx_BGColor: TColor;
    FWx_Border: integer;

    FWx_Class: string;
    FWx_ControlOrientation: TWxControlOrientation;
    FWx_Enabled: boolean;
    FWx_FGColor: TColor;
    FWx_GeneralStyle: TWxStdStyleSet;
    FWx_HelpText: string;
    FWx_Hidden: boolean;
    FWx_IDName: string;
    FWx_IDValue: longint;

    FWx_RadioBoxStyle: TWxrbxStyleItem;
    FWx_ProxyBGColorString: TWxColorString;
    FWx_ProxyFGColorString: TWxColorString;
    FWx_StretchFactor: integer;
    FWx_ToolTip: string;
    FWx_Validator: string;
    FWx_EventList: TStringList;
    FWx_PropertyList: TStringList;
    FInvisibleBGColorString: string;
    FInvisibleFGColorString: string;
    FWx_Comments: TStrings;
    FWx_Selection: integer;
    FWx_LHSValue : String;
    FWx_RHSValue : String;

    FWx_Alignment: TWxSizerAlignmentSet;
    FWx_BorderAlignment: TWxBorderAlignment;

    { Private methods of TWxRadioBox }
    procedure AutoInitialize;
    procedure AutoDestroy;

  protected
    { Protected fields of TWxRadioBox }

    { Protected methods of TWxRadioBox }
    procedure Click; override;
    procedure KeyPress(var Key: char); override;
    procedure Loaded; override;
    procedure Paint; override;

  public
    { Public fields and properties of TWxRadioBox }
    defaultBGColor: TColor;
    defaultFGColor: TColor;
    { Public methods of TWxRadioBox }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GenerateControlIDs: string;
    function GenerateEnumControlIDs: string;
    function GenerateEventTableEntries(CurrClassName: string): string;
    function GenerateGUIControlCreation: string;
    function GenerateXRCControlCreation(IndentString: string): TStringList;
    function GenerateGUIControlDeclaration: string;
    function GenerateHeaderInclude: string;
    function GenerateImageInclude: string;
    function GetEventList: TStringList;
    function GetIDName: string;
    function GetIDValue: longint;
    function GetParameterFromEventName(EventName: string): string;
    function GetPropertyList: TStringList;
    function GetTypeFromEventName(EventName: string): string;
    function GetWxClassName: string;
    procedure SaveControlOrientation(ControlOrientation: TWxControlOrientation);
    procedure SetIDName(IDName: string);
    procedure SetIDValue(IDValue: longint);
    procedure SetWxClassName(wxClassName: string);

    function GetFGColor: string;
    procedure SetFGColor(strValue: string);
    function GetBGColor: string;
    procedure SetBGColor(strValue: string);

    function GetGenericColor(strVariableName:String): string;
    procedure SetGenericColor(strVariableName,strValue: string);

    procedure SetProxyFGColorString(Value: string);
    procedure SetProxyBGColorString(Value: string);
    function GetRadioboxOrientation(Wx_RadioBoxStyle: TWxrbxStyleItem) : string;
    function GetLHSVariableAssignment:String;
    function GetRHSVariableAssignment:String;

    function GetBorderAlignment: TWxBorderAlignment;
    procedure SetBorderAlignment(border: TWxBorderAlignment);
    function GetBorderWidth: integer;
    procedure SetBorderWidth(width: integer);
    function GetStretchFactor: integer;
    procedure SetStretchFactor(intValue: integer);
        
  published
    { Published properties of TWxRadioBox }
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property EVT_RADIOBOX: string Read FEVT_RADIOBOX Write FEVT_RADIOBOX;
    property EVT_UPDATE_UI: string Read FEVT_UPDATE_UI Write FEVT_UPDATE_UI;
    property Wx_BGColor: TColor Read FWx_BGColor Write FWx_BGColor;
    property Wx_Class: string Read FWx_Class Write FWx_Class;
    property Wx_ControlOrientation: TWxControlOrientation
      Read FWx_ControlOrientation Write FWx_ControlOrientation;
    property Wx_Enabled: boolean Read FWx_Enabled Write FWx_Enabled default True;
    property Wx_EventList: TStringList Read FWx_EventList Write FWx_EventList;
    property Wx_FGColor: TColor Read FWx_FGColor Write FWx_FGColor;
    property Wx_GeneralStyle: TWxStdStyleSet
      Read FWx_GeneralStyle Write FWx_GeneralStyle;
    property Wx_HelpText: string Read FWx_HelpText Write FWx_HelpText;
    property Wx_Hidden: boolean Read FWx_Hidden Write FWx_Hidden default False;
    property Wx_IDName: string Read FWx_IDName Write FWx_IDName;
    property Wx_IDValue: longint Read FWx_IDValue Write FWx_IDValue;
    property Wx_RadioBoxStyle: TWxrbxStyleItem Read FWx_RadioBoxStyle Write FWx_RadioBoxStyle;
    property Wx_ToolTip: string Read FWx_ToolTip Write FWx_ToolTip;
    property Wx_Validator: string Read FWx_Validator Write FWx_Validator;
    property Wx_Selection: integer Read FWx_Selection Write FWx_Selection default 1;

    property Wx_Border: integer Read GetBorderWidth Write SetBorderWidth default 5;
    property Wx_BorderAlignment: TWxBorderAlignment Read GetBorderAlignment Write SetBorderAlignment default [wxALL];
    property Wx_Alignment: TWxSizerAlignmentSet Read FWx_Alignment Write FWx_Alignment default [wxALIGN_CENTER];
    property Wx_StretchFactor: integer Read GetStretchFactor Write SetStretchFactor default 0;
    
    property Wx_ProxyBGColorString: TWxColorString Read FWx_ProxyBGColorString Write FWx_ProxyBGColorString;
    property Wx_ProxyFGColorString: TWxColorString Read FWx_ProxyFGColorString Write FWx_ProxyFGColorString;
    property InvisibleBGColorString: string Read FInvisibleBGColorString Write FInvisibleBGColorString;
    property InvisibleFGColorString: string Read FInvisibleFGColorString Write FInvisibleFGColorString;

    property Wx_Comments: TStrings Read FWx_Comments Write FWx_Comments;
    property Wx_LHSValue: string Read FWx_LHSValue Write FWx_LHSValue;
    property Wx_RHSValue: string Read FWx_RHSValue Write FWx_RHSValue;
  end;

procedure Register;

implementation


procedure Register;
begin
     { Register TWxRadioBox with wxWidgets as its
       default page on the Delphi component palette }
  RegisterComponents('wxWidgets', [TWxRadioBox]);
end;

{ Method to set variable and property values and create objects }
procedure TWxRadioBox.AutoInitialize;
begin
  FWx_PropertyList       := TStringList.Create;
  FWx_Comments           := TStringList.Create;
  FWx_EventList          := TStringList.Create;
  FWx_Border             := 5;
  FWx_Class              := 'wxRadioBox';
  FWx_Enabled            := True;
  FWx_Hidden             := False;
  FWx_BorderAlignment    := [wxAll];
  FWx_Alignment          := [wxALIGN_CENTER];
  FWx_StretchFactor      := 0;
  FWx_ProxyBGColorString := TWxColorString.Create;
  FWx_ProxyFGColorString := TWxColorString.Create;
  defaultBGColor         := clBtnFace;
  defaultFGColor         := self.font.color;

end; { of AutoInitialize }

{ Method to free any objects created by AutoInitialize }
procedure TWxRadioBox.AutoDestroy;
begin
  FWx_PropertyList.Destroy;
  FWx_EventList.Destroy;
  FWx_Comments.Destroy;
  FWx_ProxyFGColorString.Destroy;
  FWx_ProxyBGColorString.Destroy;
end; { of AutoDestroy }

{ Override OnClick handler from TRadioGroup,IWxComponentInterface }
procedure TWxRadioBox.Click;
begin
     { Code to execute before activating click
       behavior of component's parent class }

  { Activate click behavior of parent }
  inherited Click;

     { Code to execute after click behavior
       of parent }

end;

{ Override OnKeyPress handler from TRadioGroup,IWxComponentInterface }
procedure TWxRadioBox.KeyPress(var Key: char);
const
  TabKey   = char(VK_TAB);
  EnterKey = char(VK_RETURN);
begin
     { Key contains the character produced by the keypress.
       It can be tested or assigned a new value before the
       call to the inherited KeyPress method.  Setting Key
       to #0 before call to the inherited KeyPress method
       terminates any further processing of the character. }

  { Activate KeyPress behavior of parent }
  inherited KeyPress(Key);

  { Code to execute after KeyPress behavior of parent }

end;

constructor TWxRadioBox.Create(AOwner: TComponent);
begin
  { Call the Create method of the container's parent class       }
  inherited Create(AOwner);

  { AutoInitialize sets the initial values of variables          }
  { (including subcomponent variables) and properties;           }
  { also, it creates objects for properties of standard          }
  { Delphi object types (e.g., TFont, TTimer, TPicture)          }
  { and for any variables marked as objects.                     }
  { AutoInitialize method is generated by Component Create.      }
  AutoInitialize;

  { Code to perform other tasks when the component is created }
  PopulateGenericProperties(FWx_PropertyList);

  FWx_PropertyList.add('Items:Items');
  FWx_PropertyList.add('Caption:Caption');
  FWx_PropertyList.add('MajorDimension:Major Dimension');
  FWx_PropertyList.add('Wx_Selection:Selected Button');

  FWx_PropertyList.add('Wx_RadioboxOrientation:Orientation');
  FWx_PropertyList.add('Wx_RadioBoxStyle:Radiobox Style');
  FWx_PropertyList.add('wxRA_SPECIFY_COLS:wxRA_SPECIFY_COLS');
  FWx_PropertyList.add('wxRA_SPECIFY_ROWS:wxRA_SPECIFY_ROWS');

  FWx_PropertyList.add('Wx_LHSValue   : LHS Variable');
  FWx_PropertyList.add('Wx_RHSValue   : RHS Variable');

  FWx_EventList.add('EVT_RADIOBOX:OnClick');
  FWx_EventList.add('EVT_UPDATE_UI:OnUpdateUI');

end;

destructor TWxRadioBox.Destroy;
begin
  { AutoDestroy, which is generated by Component Create, frees any   }
  { objects created by AutoInitialize.                               }
  AutoDestroy;

  { Here, free any other dynamic objects that the component methods  }
  { created but have not yet freed.  Also perform any other clean-up }
  { operations needed before the component is destroyed.             }

  { Last, free the component by calling the Destroy method of the    }
  { parent class.                                                    }
  inherited Destroy;
end;

function TWxRadioBox.GenerateEnumControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('%s = %d, ', [Wx_IDName, Wx_IDValue]);
end;

function TWxRadioBox.GenerateControlIDs: string;
begin
  Result := '';
  if (Wx_IDValue > 0) and (trim(Wx_IDName) <> '') then
    Result := Format('#define %s %d ', [Wx_IDName, Wx_IDValue]);
end;

function TWxRadioBox.GenerateEventTableEntries(CurrClassName: string): string;
begin
  Result := '';
  if trim(EVT_RADIOBOX) <> '' then
    Result := Format('EVT_RADIOBOX(%s,%s::%s)', [WX_IDName, CurrClassName,
      EVT_RADIOBOX]) + '';

  if trim(EVT_UPDATE_UI) <> '' then
    Result := Result + #13 + Format('EVT_UPDATE_UI(%s,%s::%s)',
      [WX_IDName, CurrClassName, EVT_UPDATE_UI]) + '';

end;

function TWxRadioBox.GenerateXRCControlCreation(IndentString: string): TStringList;
var
  i: integer;
begin

  Result := TStringList.Create;

  try
    Result.Add(IndentString + Format('<object class="%s" name="%s">',
      [self.Wx_Class, self.Name]));
    Result.Add(IndentString + Format('  <IDident>%s</IDident>', [self.Wx_IDName]));
    Result.Add(IndentString + Format('  <ID>%d</ID>', [self.Wx_IDValue]));
    Result.Add(IndentString + Format('  <size>%d,%d</size>', [self.Width, self.Height]));
    Result.Add(IndentString + Format('  <pos>%d,%d</pos>', [self.Left, self.Top]));

    Result.Add(IndentString + Format('  <style>%s</style>',
      [GetRadioboxOrientation(Wx_RadioBoxStyle)]));
    Result.Add('  <content>');
    for i := 0 to self.Items.Count - 1 do
      Result.Add(IndentString + '    <item checked="0">' + self.Items[i] + '</item>');

    Result.Add('  </content>');
    Result.Add(IndentString + '</object>');


  except
    Result.Free;
    raise;
  end;

end;

function TWxRadioBox.GenerateGUIControlCreation: string;
var
  strColorStr: string;
  i: integer;
  strStyle, parentName, strAlignment: string;
begin
  Result := '';

  parentName := GetWxWidgetParent(self);
  strStyle   := GetRadioboxOrientation(Wx_RadioBoxStyle);

  if trim(strStyle) <> '' then
    strStyle := ', ' + strStyle;
  Result := GetCommentString(self.FWx_Comments.Text) +
    'wxArrayString arrayStringFor_' + self.Name + ';';

  for i := 0 to self.Items.Count - 1 do
    Result := Result + #13 + Format(
      '%s.Add(%s);', ['arrayStringFor_' + self.Name, GetCppString(self.Items[i])]);

  //Last comma is removed because it depends on the user selection of the properties.
  if trim(self.FWx_Validator) <> '' then
  begin
    if trim(strStyle) <> '' then
      strStyle := strStyle + ', ' + self.Wx_Validator
    else
      strStyle := ', 0, ' + self.Wx_Validator;

    strStyle := strStyle + ', ' + GetCppString(Name);

  end
  else if trim(strStyle) <> '' then
    strStyle := strStyle + ', wxDefaultValidator, ' + GetCppString(Name)
  else
    strStyle := ', 0, wxDefaultValidator, ' + GetCppString(Name);

  Result := Result + #13 + Format(
    '%s = new %s(%s, %s, %s, wxPoint(%d,%d), wxSize(%d,%d), %s, %d%s);',
    [self.Name, self.Wx_Class, ParentName, GetWxIDString(self.Wx_IDName,
    self.Wx_IDValue),
    GetCppString(self.Caption), self.Left, self.Top, self.Width, self.Height,
    'arrayStringFor_' + self.Name, self.MajorDimension, strStyle]);

  if trim(self.Wx_ToolTip) <> '' then
    Result := Result + #13 + Format('%s->SetToolTip(%s);',
      [self.Name, GetCppString(self.Wx_ToolTip)]);

  if self.Wx_Hidden then
    Result := Result + #13 + Format('%s->Show(false);', [self.Name]);

  if not Wx_Enabled then
    Result := Result + #13 + Format('%s->Enable(false);', [self.Name]);

  if Wx_Selection > self.Items.Count - 1 then
        Wx_Selection := 0;
  Result := Result + #13 + Format('%s->SetSelection(%d);', [self.Name, Wx_Selection]);

  if trim(self.Wx_HelpText) <> '' then
    Result := Result + #13 + Format('%s->SetHelpText(%s);',
      [self.Name, GetCppString(self.Wx_HelpText)]);

  strColorStr := trim(GetwxColorFromString(InvisibleFGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetForegroundColour(%s);',
      [self.Name, strColorStr]);

  strColorStr := trim(GetwxColorFromString(InvisibleBGColorString));
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetBackgroundColour(%s);',
      [self.Name, strColorStr]);


  strColorStr := GetWxFontDeclaration(self.Font);
  if strColorStr <> '' then
    Result := Result + #13 + Format('%s->SetFont(%s);', [self.Name, strColorStr]);

  if (self.Parent is TWxSizerPanel) then
  begin
    strAlignment := SizerAlignmentToStr(Wx_Alignment) + ' | ' + BorderAlignmentToStr(Wx_BorderAlignment);
    Result := Result + #13 + Format('%s->Add(%s,%d,%s,%d);',
      [self.Parent.Name, self.Name, self.Wx_StretchFactor, strAlignment,
      self.Wx_Border]);
  end;

end;

function TWxRadioBox.GenerateGUIControlDeclaration: string;
begin
  Result := '';
  Result := Format('%s *%s;', [trim(Self.Wx_Class), trim(Self.Name)]);
end;

function TWxRadioBox.GenerateHeaderInclude: string;
begin
  Result := '';
  Result := '#include <wx/radiobox.h>';
end;

function TWxRadioBox.GenerateImageInclude: string;
begin

end;

function TWxRadioBox.GetEventList: TStringList;
begin
  Result := Wx_EventList;
end;

function TWxRadioBox.GetIDName: string;
begin
  Result := wx_IDName;
end;

function TWxRadioBox.GetIDValue: longint;
begin
  Result := wx_IDValue;
end;

function TWxRadioBox.GetParameterFromEventName(EventName: string): string;
begin

  if EventName = 'EVT_RADIOBOX' then
  begin
    Result := 'wxCommandEvent& event';
    exit;
  end;
  if EventName = 'EVT_UPDATE_UI' then
  begin
    Result := 'wxUpdateUIEvent& event';
    exit;
  end;
end;

function TWxRadioBox.GetPropertyList: TStringList;
begin
  Result := FWx_PropertyList;
end;

function TWxRadioBox.GetStretchFactor: integer;
begin
  Result := FWx_StretchFactor;
end;

function TWxRadioBox.GetTypeFromEventName(EventName: string): string;
begin

end;

function TWxRadioBox.GetBorderAlignment: TWxBorderAlignment;
begin
  Result := FWx_BorderAlignment;
end;

procedure TWxRadioBox.SetBorderAlignment(border: TWxBorderAlignment);
begin
  FWx_BorderAlignment := border;
end;

function TWxRadioBox.GetBorderWidth: integer;
begin
  Result := FWx_Border;
end;

procedure TWxRadioBox.SetBorderWidth(width: integer);
begin
  FWx_Border := width;
end;

function TWxRadioBox.GetWxClassName: string;
begin
  if trim(wx_Class) = '' then
    wx_Class := 'wxRadioBox';
  Result := wx_Class;
end;

procedure TWxRadioBox.Loaded;
begin
  inherited Loaded;

     { Perform any component setup that depends on the property
       values having been set }

end;

procedure TWxRadioBox.Paint;
begin
     { Make this component look like its parent component by calling
       its parent's Paint method. }
  inherited Paint;

     { To change the appearance of the component, use the methods
       supplied by the component's Canvas property (which is of
       type TCanvas).  For example, }

  { Canvas.Rectangle(0, 0, Width, Height); }
end;

procedure TWxRadioBox.SaveControlOrientation(ControlOrientation: TWxControlOrientation);
begin
  wx_ControlOrientation := ControlOrientation;
end;

procedure TWxRadioBox.SetIDName(IDName: string);
begin
  wx_IDName := IDName;
end;

procedure TWxRadioBox.SetIDValue(IDValue: longint);
begin
  Wx_IDValue := IDVAlue;
end;

procedure TWxRadioBox.SetStretchFactor(intValue: integer);
begin
  FWx_StretchFactor := intValue;
end;

procedure TWxRadioBox.SetWxClassName(wxClassName: string);
begin
  wx_Class := wxClassName;
end;

function TWxRadioBox.GetGenericColor(strVariableName:String): string;
begin

end;
procedure TWxRadioBox.SetGenericColor(strVariableName,strValue: string);
begin

end;

function TWxRadioBox.GetFGColor: string;
begin
  Result := FInvisibleFGColorString;
end;

procedure TWxRadioBox.SetFGColor(strValue: string);
begin
  FInvisibleFGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Font.Color := defaultFGColor
  else
    self.Font.Color := GetColorFromString(strValue);
end;

function TWxRadioBox.GetBGColor: string;
begin
  Result := FInvisibleBGColorString;
end;

procedure TWxRadioBox.SetBGColor(strValue: string);
begin
  FInvisibleBGColorString := strValue;
  if IsDefaultColorStr(strValue) then
    self.Color := defaultBGColor
  else
    self.Color := GetColorFromString(strValue);
end;

procedure TWxRadioBox.SetProxyFGColorString(Value: string);
begin
  FInvisibleFGColorString := Value;
  self.Color := GetColorFromString(Value);
end;

procedure TWxRadioBox.SetProxyBGColorString(Value: string);
begin
  FInvisibleBGColorString := Value;
  self.Font.Color := GetColorFromString(Value);
end;

function TWxRadioBox.GetRadioboxOrientation(Wx_RadioBoxStyle: TWxrbxStyleItem): string;
begin
  Result := '';
  if Wx_RadioBoxStyle = wxRA_SPECIFY_COLS then
  begin
    Result := 'wxRA_SPECIFY_COLS';
    self.Orientation := wxdVertical;

  end
  else
  begin
    Result := 'wxRA_SPECIFY_ROWS';
    self.Orientation := wxdHorizontal;
  end;
end;

function TWxRadioBox.GetLHSVariableAssignment:String;
begin
    Result:= '';
end;

function TWxRadioBox.GetRHSVariableAssignment:String;
begin
    Result:='';
end;


end.