unit Opening;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ShellCtrls, StdCtrls, ExtCtrls, Shellapi;

type
  TFormDialog = class(TForm)
    GroupBox1: TGroupBox;
    FileList: TShellTreeView;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    PanelCopy: TPanel;
    LabelCopyright: TLabel;
    Label2: TLabel;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDialog: TFormDialog;

implementation

uses Main, Settings;

{$R *.dfm}

procedure TFormDialog.ToolButton1Click(Sender: TObject);
begin
Close;
end;

procedure TFormDialog.ToolButton2Click(Sender: TObject);
var
i: integer;
begin
for i:=0 to  FileList.Items.Count-1 do
	if  FileList.Items[i].Selected then
		FormSettings.EditSaveMidletTo.Text:= FileList.Folders[i].PathName+'\';
Close;
end;

procedure TFormDialog.Label2Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://loc-id.ru/'), nil, nil, SW_SHOW);
end;

end.
