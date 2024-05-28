unit Creator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, inifiles, Shellapi, FileCtrl, VCLUnZip,
  VCLZip, ComCtrls, ToolWin;

type
  TFormCreator = class(TForm)
    PanelCopy: TPanel;
    LabelCopyright: TLabel;
    Label2: TLabel;
    FileCatBox: TListBox;
    FileForArchivation: TFileListBox;
    CatForArchivation: TDirectoryListBox;
    FileSee: TButton;
    CatSee: TButton;
    Zip: TVCLZip;
    InvisiblePanel: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    PathToMidlet: TLabel;
    ToolBar1: TToolBar;
    ButtonFolderOpen: TToolButton;
    ToolBar2: TToolBar;
    ButtonToCloseApplication: TToolButton;
    ToolBar3: TToolBar;
    ButtonGoMainForm: TToolButton;
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FileSeeClick(Sender: TObject);
    procedure CatSeeClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonFolderOpenClick(Sender: TObject);
    procedure ButtonToCloseApplicationClick(Sender: TObject);
    procedure ButtonGoMainFormClick(Sender: TObject);
  private
    { Private declarations }
    procedure DellFolder(Folder: string; FolderDel: boolean);
    procedure CopyFolder(FolderFrom, FolderTo: string);
    procedure CreatArchive;
    procedure AddToArchive;
  public
    { Public declarations }
  end;

var
  FormCreator: TFormCreator;
  inifile: tinifile;
  SaveMidletTo: string;

implementation

uses Main;

{$R *.dfm}

//////////////////////// универсальные функции begin ///////////////////////////
procedure TFormCreator.DellFolder(Folder: string; FolderDel: boolean);
var
Found: integer;
SearchRec: TSearchRec;
begin
if DirectoryExists(Folder+'\')<>True then
	exit;
Found:= FindFirst(Folder+'\*.*', faAnyFile, SearchRec);
while Found = 0 do
begin
  if (SearchRec.name <> '.') and (SearchRec.name <> '..') then
    if (SearchRec.Attr and faDirectory) <> 0 then
    begin
    	if RemoveDir(Folder+'\'+SearchRec.name) then continue
      else
      begin
      DellFolder(Folder+'\'+SearchRec.name, true);
      end;
    end
    else
    begin
    	DeleteFile(Folder+'\'+SearchRec.name);
    end;
Found:= FindNext(SearchRec);
end;
FindClose(SearchRec);
if FolderDel=true then
	RemoveDir(Folder);
end;

procedure TFormCreator.CopyFolder(FolderFrom, FolderTo: string);
var
Found: integer;
SearchRec: TSearchRec;
begin
if DirectoryExists(FolderFrom+'\')<>True then
	exit;
if DirectoryExists(FolderTo+'\')<>True then
	CreateDir(FolderTo+'\');
Found:= FindFirst(FolderFrom+'\*.*', faAnyFile, SearchRec);
while Found = 0 do
begin
  if (SearchRec.name <> '.') and (SearchRec.name <> '..') then
    if (SearchRec.Attr and faDirectory) <> 0 then
    begin
      CopyFolder(FolderFrom+'\'+SearchRec.name, FolderTo+'\'+SearchRec.name);
    end
    else
    begin
      CopyFile(PChar(FolderFrom+'\'+SearchRec.name), PChar(FolderTo+'\'+SearchRec.name), false);
    end;
Found:= FindNext(SearchRec);
end;
FindClose(SearchRec);
end;

procedure TFormCreator.CreatArchive;
var
i: integer;
begin
Zip.FilesList.Clear;
Zip.Recurse:= false;
Zip.StorePaths:= false;
for i:=0 to FileForArchivation.Count-1 do
	Zip.FilesList.Add(extractfilepath(application.ExeName)+'db\'+WhoChose+'\build\'+FileForArchivation.Items[i]);
Zip.ZipName:='D:\promegutochnii.jar';
Zip.Zip;
end;

procedure TFormCreator.AddToArchive;
var
i: integer;
begin
Zip.FilesList.Clear;
Zip.Recurse:= true;
Zip.StorePaths:= true;
Zip.FixZip('D:\promegutochnii.jar', SaveMidletTo+JarName+'.jar');
for i:=0 to FileCatBox.Count-1 do
	Zip.FilesList.Add(Copy(extractfilepath(application.ExeName), 1, 3)+FileCatBox.Items.Strings[i]+'\*.*');
Zip.Zip;
PathToMidlet.Caption:= Copy(SaveMidletTo+JarName+'.jar', 0, 35);
PathToMidlet.Hint:= SaveMidletTo+JarName+'.jar';
end;
//////////////////////// универсальные функции end /////////////////////////////

procedure TFormCreator.Label2Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://loc-id.ru/'), nil, nil, SW_SHOW);
end;

procedure TFormCreator.FormShow(Sender: TObject);
var
i: integer;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'/Config.ini');
SaveMidletTo:= inifile.ReadString('General Config', 'SaveMidletTo', Copy(extractfilepath(application.ExeName), 1, 3));
inifile.Free;
///////////////////////////////
if fileexists(Copy(extractfilepath(application.ExeName), 1, 3)+'promegutochnii.jar') then
	DeleteFile(Copy(extractfilepath(application.ExeName), 1, 3)+'promegutochnii.jar');
if fileexists(Copy(extractfilepath(application.ExeName), 1, 3)+JarName+'.jar') then
   DeleteFile(Copy(extractfilepath(application.ExeName), 1, 3)+JarName+'.jar');
for i:=0 to Length(UChose)-1 do
	begin
	FileCatBox.Items.Add('db\'+WhoChose+'\a'+IntToStr(i+1)+'\'+IntToStr(UChose[i])+'\resource\');
   CopyFolder(extractfilepath(application.ExeName)+'db\'+WhoChose+'\a'+IntToStr(i+1)+'\'+IntToStr(UChose[i])+'\resource', extractfilepath(application.ExeName)+'db\'+WhoChose+'\build');
	end;
CatForArchivation.Directory:= extractfilepath(application.ExeName)+'db\'+WhoChose+'\build';
FileForArchivation.Directory:= extractfilepath(application.ExeName)+'db\'+WhoChose+'\build';
CreatArchive;
CatSeeClick(self);
AddToArchive;
DeleteFile('D:\promegutochnii.jar');
for i:=0 to FileCatBox.Count-1 do
	DellFolder(Copy(extractfilepath(application.ExeName), 1, 3)+FileCatBox.Items.Strings[i], true);
end;

procedure TFormCreator.FileSeeClick(Sender: TObject);
var
i: integer;
begin
FileCatBox.Items.Clear;
for i:=0 to FileForArchivation.Count-1 do
	begin
	FileCatBox.Items.Add(extractfilepath(application.ExeName)+'db\'+WhoChose+'\build\'+FileForArchivation.Items[i]);
	end;
end;

procedure TFormCreator.CatSeeClick(Sender: TObject);
var
i: integer;
KeyBuildsIsset: boolean;
begin
KeyBuildsIsset:= false;
FileCatBox.Items.Clear;
for i:=0 to CatForArchivation.Count-1 do
	begin
	if KeyBuildsIsset=true then
   	FileCatBox.Items.Add(CatForArchivation.Items.Strings[i]);
   if CatForArchivation.Items.Strings[i]='build' then
   	KeyBuildsIsset:= true;
   end;
for i:=0 to FileCatBox.Count-1 do
	CopyFolder(extractfilepath(application.ExeName)+'db\'+WhoChose+'\build\'+FileCatBox.Items.Strings[i], Copy(extractfilepath(application.ExeName), 1, 3)+FileCatBox.Items.Strings[i]);
end;

procedure TFormCreator.FormHide(Sender: TObject);
begin
DellFolder(extractfilepath(application.ExeName)+'db\'+WhoChose+'\build', false);
end;

procedure TFormCreator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
DellFolder(extractfilepath(application.ExeName)+'db\'+WhoChose+'\build', false);
end;

procedure TFormCreator.ButtonFolderOpenClick(Sender: TObject);
begin
ShellExecute(Handle, 'open', 'explorer.exe', PChar('/select, '+JarName+'.jar'), PChar(SaveMidletTo), SW_SHOWNORMAL);
end;

procedure TFormCreator.ButtonToCloseApplicationClick(Sender: TObject);
begin
MainForm.Close;
end;

procedure TFormCreator.ButtonGoMainFormClick(Sender: TObject);
begin
Close;
end;

end.
