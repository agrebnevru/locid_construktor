unit LocID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, pngimage, inifiles, shellapi,
  VirtualTrees, JPEG, FileCtrl, ToolWin;

type
  TGradientKind = (gkHorz, gkVert);
  
  PItemNode = ^TItemNode;

  TItemNode = record
    Name, ImgSize: string;
    ImgFull, ImgPrew, ListTxt: string;
    idA, idInA: integer;
  end;

  TFormLocID = class(TForm)
    VT: TVirtualDrawTree;
    TabControlLocID: TTabControl;
    DownPanelWithButton: TPanel;
    DirectoryListBox1: TDirectoryListBox;
    PanelCopy: TPanel;
    LabelCopyright: TLabel;
    Label2: TLabel;
    VT2: TVirtualDrawTree;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    UpPanel: TPanel;
    PanelGrafica: TPanel;
    PanelPlugins: TPanel;
    ToolBar1: TToolBar;
    ButtonSbros: TToolButton;
    ButtonCreateMidlet: TToolButton;
    DownPanel1: TPanel;
    DownPanel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure VTGetHintSize(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var R: TRect);
    procedure VTDrawNode(Sender: TBaseVirtualTree;
      const PaintInfo: TVTPaintInfo);
    procedure VTDrawHint(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
      Node: PVirtualNode; R: TRect; Column: TColumnIndex);
    procedure TabControlLocIDChange(Sender: TObject);
    procedure VTClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VT2DrawNode(Sender: TBaseVirtualTree;
      const PaintInfo: TVTPaintInfo);
    procedure BitBtnResetClick(Sender: TObject);
    procedure BitBtnCreateClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure ButtonSbrosClick(Sender: TObject);
    procedure ButtonCreateMidletClick(Sender: TObject);
    procedure VTDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure NewTabCreate(TabName: string; Id: integer);
    function KolVoCatInCatA(IdA: integer): integer;
    procedure LoadDataB;
    procedure LoadData(TabId: integer);
    procedure LoadDataRight;
    //procedure LoadDataRight;
  public
    { Public declarations }
  end;

  procedure GradFill(DC: HDC; ARect: TRect; ClrTopLeft, ClrBottomRight: TColor;
    Kind: TGradientKind);

var
  FormLocID: TFormLocID;
  inifile: tinifile;
  AfterCatA: string;
  TabKolVo, ShowPrewFull, ClickAndNext, BKolVo: integer;

implementation

uses Main, Settings, Creator;

{$R *.dfm}

//------------------------------------------------------------------------------
// Рисует градиент
//------------------------------------------------------------------------------
procedure GradFill(DC: HDC; ARect: TRect; ClrTopLeft, ClrBottomRight: TColor;
  Kind: TGradientKind);
var
  GradientCache: array [0..16] of array of Cardinal;
  NextCacheIndex: Integer;

  function FindGradient(Size: Integer; CL, CR: Cardinal): Integer;
  begin
    Assert(Size > 0);
    Result := 16 - 1;
    while Result >= 0 do
    begin
      if (Length(GradientCache[Result]) = Size) and
        (GradientCache[Result][0] = CL) and
        (GradientCache[Result][Length(GradientCache[Result]) - 1] = CR) then Exit;
      Dec(Result);
    end;
  end;

  function MakeGradient(Size: Integer; CL, CR: Cardinal): Integer;
  var
    R1, G1, B1: Integer;
    R2, G2, B2: Integer;
    R, G, B: Integer;
    I: Integer;
    Bias: Integer;
  begin
    Assert(Size > 0);
    Result := NextCacheIndex;
    Inc(NextCacheIndex);
    if NextCacheIndex >= 16 then NextCacheIndex := 0;
    R1 := CL and $FF;
    G1 := CL shr 8 and $FF;
    B1 := CL shr 16 and $FF;
    R2 := Integer(CR and $FF) - R1;
    G2 := Integer(CR shr 8 and $FF) - G1;
    B2 := Integer(CR shr 16 and $FF) - B1;
    SetLength(GradientCache[Result], Size);
    Dec(Size);
    Bias := Size div 2;
    if Size > 0 then
      for I := 0 to Size do
      begin
        R := R1 + (R2 * I + Bias) div Size;
        G := G1 + (G2 * I + Bias) div Size;
        B := B1 + (B2 * I + Bias) div Size;
        GradientCache[Result][I] := R + G shl 8 + B shl 16;
      end
    else
    begin
      R := R1 + R2 div 2;
      G := G1 + G2 div 2;
      B := B1 + B2 div 2;
      GradientCache[Result][0] := R + G shl 8 + B shl 16;
    end;
  end;

  function GetGradient(Size: Integer; CL, CR: Cardinal): Integer;
  begin
    Result := FindGradient(Size, CL, CR);
    if Result < 0 then Result := MakeGradient(Size, CL, CR);
  end;

var
  Size, I, Start, Finish: Integer;
  GradIndex: Integer;
  R, CR: TRect;
  Brush: HBRUSH;
begin
  NextCacheIndex := 0;
  if not RectVisible(DC, ARect) then
    Exit;
  ClrTopLeft := ColorToRGB(ClrTopLeft);
  ClrBottomRight := ColorToRGB(ClrBottomRight);
  GetClipBox(DC, CR);
  if Kind = gkHorz then
  begin
    Size := ARect.Right - ARect.Left;
    if Size <= 0 then Exit;
    Start := 0; Finish := Size - 1;
    if CR.Left > ARect.Left then Inc(Start, CR.Left - ARect.Left);
    if CR.Right < ARect.Right then Dec(Finish, ARect.Right - CR.Right);
    R := ARect; Inc(R.Left, Start); R.Right := R.Left + 1;
  end
  else begin
    Size := ARect.Bottom - ARect.Top;
    if Size <= 0 then Exit;
    Start := 0; Finish := Size - 1;
    if CR.Top > ARect.Top then Inc(Start, CR.Top - ARect.Top);
    if CR.Bottom < ARect.Bottom then Dec(Finish, ARect.Bottom - CR.Bottom);
    R := ARect; Inc(R.Top, Start); R.Bottom := R.Top + 1;
  end;
  GradIndex := GetGradient(Size, ClrTopLeft, ClrBottomRight);
  for I := Start to Finish do
  begin
    Brush := CreateSolidBrush(GradientCache[GradIndex][I]);
    Windows.FillRect(DC, R, Brush);
    OffsetRect(R, Integer(Kind = gkHorz), Integer(Kind = gkVert));
    DeleteObject(Brush);
  end;
end;

procedure TFormLocID.NewTabCreate(TabName: string; Id: integer);
begin
TabControlLocID.Tabs.Add(TabName);
TabControlLocID.TabIndex:= Id;
end;

function TFormLocID.KolVoCatInCatA(IdA: integer): integer;
begin
DirectoryListBox1.Directory:= extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(IdA)+'/';
Result:= DirectoryListBox1.Count;
end;

//------------------------------------------------------------------------------
// Отрисовка всплывающей подсказки.
//------------------------------------------------------------------------------
procedure TFormLocID.VTDrawHint(Sender: TBaseVirtualTree; HintCanvas: TCanvas;
  Node: PVirtualNode; R: TRect; Column: TColumnIndex);
var
  NodeData: PItemNode;
  ImgRect, RealRect: TRect;
  Img: TPicture;
begin
  // Области отрисовки различных элементов
  RealRect := R;
  // Границы картинки
  ImgRect := RealRect;
  with ImgRect do
  begin
    Inc(Left, 2);
    Inc(Top, 2);
    Right := Left + 64;
    Bottom := Top + 64;
  end;
  // Рисуем фон
  with HintCanvas do
  begin
    with Brush do
    begin
      Color := clWhite;
      Style := bsSolid;
    end;
    Pen.Color := clBlack;
    Pen.Width := 1;
    // Жёлтый фон и чёрная рамка по бокам
    Rectangle(RealRect);
  end;
  // Подключаем данные и убираем стайл
  NodeData := Sender.GetNodeData(Node);
  HintCanvas.Brush.Style := bsClear;
  // Картинка
if FileExists(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgFull) then
begin
  Img := TPicture.Create;
  try
     Img.LoadFromFile(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgFull);
    HintCanvas.Draw(ImgRect.Left, ImgRect.Top, Img.Graphic);
    with HintCanvas, ImgRect do
    begin
      Pen.Width := 2;
      Pen.Color := $00B99D7F;
      Rectangle(Rect(ImgRect.Left, Top, Left + Img.Width, Top + Img.Height));
    end;
  finally
    FreeAndNil(Img);
  end;
end
else
begin
  Img := TPicture.Create;
  try
     Img.LoadFromFile(extractfilepath(application.ExeName)+'no.jpg');
    HintCanvas.Draw(ImgRect.Left, ImgRect.Top, Img.Graphic);
    with HintCanvas, ImgRect do
    begin
      Pen.Width := 2;
      Pen.Color := $00B99D7F;
      Rectangle(Rect(ImgRect.Left, Top, Left + Img.Width, Top + Img.Height));
    end;
  finally
    FreeAndNil(Img);
  end;
end;
end;

//------------------------------------------------------------------------------
// Отрисовка узла для левого дерева
//------------------------------------------------------------------------------
procedure TFormLocID.VTDrawNode(Sender: TBaseVirtualTree;
  const PaintInfo: TVTPaintInfo);
var
  NodeData: PItemNode;
  ImgRect, RealRect, NameRect, MassRect, PriceRect: TRect;
  Img: TPicture;
begin
// Области отрисовки различных элементов
RealRect := PaintInfo.CellRect;
ImgRect := RealRect;
NodeData := Sender.GetNodeData(PaintInfo.Node);
  with ImgRect do
  begin
    Inc(Left, 16);
    Inc(Top, 16);
  end;
  NameRect := RealRect;
  with NameRect do
  begin
    Inc(Left, 230);
    Inc(Top, 85);
  end;
  MassRect := RealRect;
  with MassRect do
  begin
    Inc(Left, 3);
    Inc(Top, 3);
  end;
  PriceRect := RealRect;
  with PriceRect do
  begin
    Inc(Left, 230);
    Inc(Top, 100);
  end;
  // Рисуем фон
  with PaintInfo.Canvas do
  begin
    with Brush do
    begin
      Color := clWindow;
      Style := bsSolid;
    end;
    Pen.Color := $00B99D7F;
  end;
  if PaintInfo.Node = Sender.FocusedNode then
    GradFill(PaintInfo.Canvas.Handle, RealRect, $00EAE2D9, $00D7C8B7, gkVert)
  else
    PaintInfo.Canvas.FillRect(RealRect);
  // Текст
  with PaintInfo.Canvas do
  begin
    Brush.Style := bsClear;
    Font.Color := clWindowText;
    Font.Style := [fsBold];
    TextOut(NameRect.Left, NameRect.Top, 'Название: ' + NodeData.Name);
    TextOut(PriceRect.Left, PriceRect.Top, 'Разрешение/Расширение: ' + NodeData.ImgSize);
    TextOut(MassRect.Left, MassRect.Top, IntToStr(NodeData.idInA));
  end;
  // Картинка
if FileExists(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgPrew) then
begin
  try
	 Img := TPicture.Create;
    if ShowPrewFull=0 then
	    Img.LoadFromFile(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgPrew);
    if ShowPrewFull=1 then
	    Img.LoadFromFile(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgFull);
    PaintInfo.Canvas.Draw(ImgRect.Left, ImgRect.Top, Img.Graphic);
    if PaintInfo.Node = Sender.FocusedNode then
      with PaintInfo.Canvas, ImgRect do
      begin
        Pen.Width := 2;
        Rectangle(Rect(ImgRect.Left, Top, Left + Img.Width, Top + Img.Height));
      end;
  finally
    FreeAndNil(Img);
  end;
end;
end;

//------------------------------------------------------------------------------
// Отрисовка узла для правого дерева
//------------------------------------------------------------------------------
procedure TFormLocID.VT2DrawNode(Sender: TBaseVirtualTree;
  const PaintInfo: TVTPaintInfo);
var
  NodeData: PItemNode;
  ImgRect, RealRect, RazdelRect, NameRect: TRect;
  Img: TPicture;
begin
// Области отрисовки различных элементов
RealRect := PaintInfo.CellRect;
ImgRect := RealRect;
NodeData := Sender.GetNodeData(PaintInfo.Node);
  with ImgRect do
  begin
    Inc(Left, 150);
    Inc(Top, 20);
  end;
  RazdelRect := RealRect;
  with RazdelRect do
  begin
    Inc(Left, 2);
    Inc(Top, 2);
  end;
  NameRect := RealRect;
  with NameRect do
  begin
    Inc(Left, 2);
    Dec(Top, 17);
  end;
  // Рисуем фон
  with PaintInfo.Canvas do
  begin
    with Brush do
    begin
      Color := clWindow;
      Style := bsSolid;
    end;
    Pen.Color := $00B99D7F;
  end;
  if PaintInfo.Node = Sender.FocusedNode then
    GradFill(PaintInfo.Canvas.Handle, RealRect, $00EAE2D9, $00D7C8B7, gkVert)
  else
    PaintInfo.Canvas.FillRect(RealRect);
  // Текст
  with PaintInfo.Canvas do
  begin
    Brush.Style := bsClear;
    Font.Color := clWindowText;
    Font.Style := [fsBold];
    TextOut(RazdelRect.Left, RazdelRect.Top, 'Раздел: ' + TabControlLocID.Tabs[NodeData.idA-1]);
    TextOut(NameRect.Left, NameRect.Top, 'Название: ' + NodeData.Name);
  end;
  // Картинка
if FileExists(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgPrew) then
begin
  try
	 Img := TPicture.Create;
    Img.LoadFromFile(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgPrew);
    PaintInfo.Canvas.Draw(ImgRect.Left, ImgRect.Top, Img.Graphic);
    if PaintInfo.Node = Sender.FocusedNode then
      with PaintInfo.Canvas, ImgRect do
      begin
        Pen.Width := 2;
        Rectangle(Rect(ImgRect.Left, Top, Left + Img.Width, Top + Img.Height));
      end;
  finally
    FreeAndNil(Img);
  end;
end;
end;

//------------------------------------------------------------------------------
// Загрузка b каталога
//------------------------------------------------------------------------------
procedure TFormLocID.LoadDataB;
var
  i: Integer;
  NewNode: PVirtualNode;
  NodeData: PItemNode;
  HintKey: Integer;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/b1/index.ini');
HintKey:= inifile.ReadInteger('Step config', 'NeedHint', 0);
if ShowPrewFull=1 then
VT.DefaultNodeHeight:= inifile.ReadInteger('Step config', 'NodeHeight', 120);
inifile.Free;
if HintKey=1 then
	VT.HintMode:= hmHint
else
	VT.HintMode:= hmDefault;

	 VT.Clear;
    VT.BeginUpdate;
    try
      for i := 1 to BKolVo do
      begin
        NewNode:= VT.AddChild(nil);
        NodeData:= VT.GetNodeData(NewNode);
        if Assigned(NodeData) then
        	with NodeData^ do
        	begin
         	inifile:=tinifile.Create(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/b1/'+IntToStr(i)+'/index.ini');
          	Name:= inifile.ReadString('Resource config', 'Name', '');
            ImgSize:= inifile.ReadString('Resource config', 'ImgSize', '');
            idInA:= i;
            ImgFull:= inifile.ReadString('Resource config', 'ImgFull', '');
            ImgPrew:= inifile.ReadString('Resource config', 'ImgPrew', '');
            ListTxt:= inifile.ReadString('Resource config', 'ListTxt', '');
            inifile.Free;
        	end;
      end;
    finally
      VT.EndUpdate;
    end;
end;


//------------------------------------------------------------------------------
// Загрузка нашей миниатюрной "базы данных" для левого дерева.
//------------------------------------------------------------------------------
procedure TFormLocID.LoadData(TabId: integer);
var
  i: Integer;
  NewNode: PVirtualNode;
  NodeData: PItemNode;
  HintKey: Integer;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(TabId)+'/index.ini');
HintKey:= inifile.ReadInteger('Step config', 'NeedHint', 0);
if ShowPrewFull=1 then
VT.DefaultNodeHeight:= inifile.ReadInteger('Step config', 'NodeHeight', 120);
inifile.Free;
if HintKey=1 then
	VT.HintMode:= hmHint
else
	VT.HintMode:= hmDefault;

	 VT.Clear;
    VT.BeginUpdate;
    try
      for i := 1 to KolVoCatInCatA(TabId)-7 do
      begin
        NewNode:= VT.AddChild(nil);
        NodeData:= VT.GetNodeData(NewNode);
        if Assigned(NodeData) then
        	with NodeData^ do
        	begin
         	inifile:=tinifile.Create(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(TabId)+'/'+IntToStr(i)+'/index.ini');
          	Name:= inifile.ReadString('Resource config', 'Name', '');
            ImgSize:= inifile.ReadString('Resource config', 'ImgSize', '');
            idA:= TabId;
            idInA:= i;
            ImgFull:= inifile.ReadString('Resource config', 'ImgFull', '');
            ImgPrew:= inifile.ReadString('Resource config', 'ImgPrew', '');
            inifile.Free;
        	end;
      end;
    finally
      VT.EndUpdate;
    end;
end;

//------------------------------------------------------------------------------
// Загрузка нашей миниатюрной "базы данных" для правого дерева.
//------------------------------------------------------------------------------
procedure TFormLocID.LoadDataRight;
var
  i, o: Integer;
  NewNode: PVirtualNode;
  NodeData: PItemNode;
begin
	 VT2.Clear;
    VT2.BeginUpdate;
    try
      for i := 0 to TabKolVo-1 do
      begin
        o:= UChose[i];
        		NewNode:= VT2.AddChild(nil);
        		NodeData:= VT2.GetNodeData(NewNode);
        		if Assigned(NodeData) then
        			with NodeData^ do
        			begin
         			inifile:=tinifile.Create(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(i+1)+'/'+IntToStr(o)+'/index.ini');
          			Name:= inifile.ReadString('Resource config', 'Name', '');
            		ImgSize:= inifile.ReadString('Resource config', 'ImgSize', '');
            		idA:= i+1;
            		idInA:= o;
            		ImgFull:= inifile.ReadString('Resource config', 'ImgFull', '');
            		ImgPrew:= inifile.ReadString('Resource config', 'ImgPrew', '');
            		inifile.Free;
        			end;
      end;
    finally
      VT2.EndUpdate;
    end;
end;

procedure TFormLocID.VTGetHintSize(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var R: TRect);
var
NodeData: PItemNode;
Img: TPicture;
begin
NodeData:= VT.GetNodeData(Node);
if FileExists(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgFull) then
begin
Img:= TPicture.Create;
Img.LoadFromFile(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(NodeData.idA)+'/'+IntToStr(NodeData.idInA)+'/'+NodeData.ImgFull);
  with R do
  begin
    Left:= 0;
    Top:= 0;
    Right:= Img.Width+2;
    Bottom:= Img.Height+2;
  end;
Img.Free;
end
else
begin
Img:= TPicture.Create;
Img.LoadFromFile(extractfilepath(application.ExeName)+'no.jpg');
  with R do
  begin
    Left:= 0;
    Top:= 0;
    Right:= Img.Width+2;
    Bottom:= Img.Height+2;
  end;
Img.Free;
end;
end;

procedure TFormLocID.FormCreate(Sender: TObject);
var
i: integer;
StepNm: string;
begin
////////////// загрузка настроек begin
   inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Config.ini');
   TabKolVo:= inifile.ReadInteger('Step Numb', 'LocID', 20);
	BKolVo:= inifile.ReadInteger('Step Numb', 'LocID_B', 1);
	ClickAndNext:= inifile.ReadInteger('General Config', 'ActionOfChose', 0);
   ShowPrewFull:= inifile.ReadInteger('General Config', 'ViewImages', 0);
	inifile.Free;
////////////// загрузка настроек end
AfterCatA:= 'locid';
PanelGrafica.Visible:= true;
PanelPlugins.Visible:= false;
VT.NodeDataSize := SizeOf(TItemNode);
VT2.NodeDataSize := SizeOf(TItemNode);
SetLength(UChose, TabKolVo);
for i:=0 to TabKolVo-1 do
begin
   UChose[i]:= 1;
end;
for i:=1 to TabKolVo do
	begin
   inifile:=tinifile.Create(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/a'+IntToStr(i)+'/index.ini');
	StepNm:= inifile.ReadString('Step Config', 'StepName', '');
	inifile.Free;
	NewTabCreate(StepNm, i);
   end;
//////////////////////
   inifile:=tinifile.Create(extractfilepath(application.ExeName)+'db/'+AfterCatA+'/b1/index.ini');
	StepNm:= inifile.ReadString('Step Config', 'StepName', '');
	inifile.Free;
	NewTabCreate(StepNm, i+1);
//////////////////////
if ShowPrewFull=0 then
begin
VT.DefaultNodeHeight:= 120;
VT.ShowHint:= true;
end;
if ShowPrewFull=1 then
begin
VT.DefaultNodeHeight:= 350;
VT.ShowHint:= false;
end;
TabControlLocID.TabIndex:= 0;
end;

procedure TFormLocID.TabControlLocIDChange(Sender: TObject);
begin
if TabControlLocID.TabIndex+2<TabKolVO then
	LoadData(TabControlLocID.TabIndex+1)
else
   LoadDataB;
//LoadDataRight;
end;

procedure TFormLocID.VTClick(Sender: TObject);
var
NodeData: PItemNode;
NewNode: PVirtualNode;
begin
//ShowMessage('EVENTS! Click!');
//if VT.sele then
//   ShowMessage('EVENTS! Click!');

if VT.Focused=false then
begin
showmessage('VT.Focused!');
	NodeData:= VT.GetNodeData(VT.FocusedNode);
	UChose[TabControlLocID.TabIndex]:= NodeData.idInA;
	LoadDataRight;
end;
end;

procedure TFormLocID.FormShow(Sender: TObject);
begin
LoadData(TabControlLocID.TabIndex+1);
LoadDataRight;
end;

procedure TFormLocID.BitBtnResetClick(Sender: TObject);
var
i: integer;
begin
for i:=0 to TabKolVo-1 do
begin
	UChose[i]:= 1;
end;
LoadDataRight;
end;

procedure TFormLocID.BitBtnCreateClick(Sender: TObject);
begin
FormCreator.Show;
end;

procedure TFormLocID.Label2Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://loc-id.ru/'), nil, nil, SW_SHOW);
end;

procedure TFormLocID.ButtonSbrosClick(Sender: TObject);
var
i: integer;
begin
for i:=0 to TabKolVo-1 do
begin
	UChose[i]:= 1;
end;
LoadDataRight;
end;

procedure TFormLocID.ButtonCreateMidletClick(Sender: TObject);
begin
FormCreator.Show;
Close;
end;

procedure TFormLocID.VTDblClick(Sender: TObject);
begin
ShowMessage('EVENTS! DblClick!');
end;

end.
