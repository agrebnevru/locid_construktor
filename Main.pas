unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, Buttons, ImgList, ComCtrls,
  ToolWin, XPMan, Shellapi;

type
  TMainForm = class(TForm)
    ImageLogo: TImage;
    ToolBarButtonExit: TToolBar;
    ToolButton2: TToolButton;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    LocIDFormOpen: TToolButton;
    XPManifest1: TXPManifest;
    ToolBarButtonSettings: TToolBar;
    ToolButton1: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    procedure LocIDFormOpenClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  UChose, UChoseB: Array of integer;
  WhoChose, JarName: string;

implementation

uses Settings, LocID, Opening;

{$R *.dfm}

procedure TMainForm.LocIDFormOpenClick(Sender: TObject);
begin
FormLocID.Show;
WhoChose:= 'locid';
JarName:= 'LocID';
end;

procedure TMainForm.ToolButton1Click(Sender: TObject);
begin
FormSettings.ShowModal;
end;

procedure TMainForm.ToolButton2Click(Sender: TObject);
begin
Close;
end;

procedure TMainForm.Label2Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://loc-id.ru/'), nil, nil, SW_SHOW);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
//DellFolder('D:\22', false);
//CopyFolder(extractfilepath(application.ExeName)+'db\locid\a1', 'D:\22');
end;

end.
