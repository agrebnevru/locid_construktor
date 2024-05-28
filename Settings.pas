unit Settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, inifiles, Shellapi, ComCtrls,
  ToolWin;

type
  TFormSettings = class(TForm)
    RadioGroupPerehod: TRadioGroup;
    RadioGroupImgView: TRadioGroup;
    PanelCopy: TPanel;
    LabelCopyright: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    EditSaveMidletTo: TEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure BitBtnOkClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
    procedure SettingsLoad;
    procedure SettingsSave;
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;
  inifile: tinifile;

implementation

uses Main, Opening;

{$R *.dfm}

procedure TFormSettings.SettingsLoad;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'/Config.ini');
RadioGroupPerehod.ItemIndex:= inifile.ReadInteger('General Config', 'ActionOfChose', 2);
RadioGroupImgView.ItemIndex:= inifile.ReadInteger('General Config', 'ViewImages', 2);
EditSaveMidletTo.Text:= inifile.ReadString('General Config', 'SaveMidletTo', Copy(extractfilepath(application.ExeName), 1, 3));
inifile.Free;
end;

procedure TFormSettings.SettingsSave;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'/Config.ini');
inifile.WriteInteger('General Config', 'ActionOfChose', RadioGroupPerehod.ItemIndex);
inifile.WriteInteger('General Config', 'ViewImages', RadioGroupImgView.ItemIndex);
inifile.WriteString('General Config', 'SaveMidletTo', EditSaveMidletTo.Text);
inifile.Free;
end;

procedure TFormSettings.FormShow(Sender: TObject);
begin
SettingsLoad;
end;

procedure TFormSettings.BitBtnOkClick(Sender: TObject);
begin
SettingsSave;
Close;
end;

procedure TFormSettings.BitBtnCancelClick(Sender: TObject);
begin
Close;
end;

procedure TFormSettings.Label2Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://loc-id.ru/'), nil, nil, SW_SHOW);
end;

procedure TFormSettings.ToolButton1Click(Sender: TObject);
begin
FormDialog.ShowModal;
end;

procedure TFormSettings.ToolButton2Click(Sender: TObject);
begin
Close;
end;

procedure TFormSettings.ToolButton3Click(Sender: TObject);
begin
SettingsSave;
Close;
end;

end.
