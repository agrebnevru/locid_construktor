object FormLocID: TFormLocID
  Left = 370
  Top = 124
  Width = 904
  Height = 733
  Caption = #1050#1086#1085#1089#1090#1088#1091#1082#1090#1086#1088' LocID'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000040040000000000000000000000000000000000000000
    0000000000009F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF00000000000000000000
    00009F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF000000FF9F9E2DFF000000FF000000FF000000009F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF000000FF000000FF000000FF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF000000FF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF000000FF666666FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF000000FF9F9E2DFF9F9E2DFF000000FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF000000FF010202FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF000000FF666666FF000000FF9F9E2DFF9F9E2DFF9F9E2DFF666666FF6666
    66FF000000FF000000FF010202FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF000000FF000000FF000000FF000000FF000000FF000000FF0000
    00FF000000FF000000FF000000FF000000FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF666666FF000000FF000000FF000000FF000000FF0000
    00FF000000FF010202FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF666666FF000000FF000000FF000000FF000000FF0000
    00FF666666FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF666666FF000000FF666666FF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF666666FF000000FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF000000FF000000FF000000FF000000FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF000000FF000000FF000000FF000000FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF000000FF000000FF9F9E2DFF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF0000
    00009F9E2DFF000000FF9F9E2DFF9F9E2DFF000000FF9F9E2DFF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF000000000000
    0000000000009F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF000000FF9F9E2DFF9F9E
    2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF9F9E2DFF0000000000000000C003
    0000800100000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000080010000C0030000}
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TabControlLocID: TTabControl
    Left = 0
    Top = 0
    Width = 888
    Height = 610
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = TabControlLocIDChange
    object PanelPlugins: TPanel
      Left = 4
      Top = 6
      Width = 880
      Height = 600
      Align = alClient
      TabOrder = 0
      Visible = False
    end
    object PanelGrafica: TPanel
      Left = 4
      Top = 6
      Width = 880
      Height = 600
      Align = alClient
      TabOrder = 1
      object Splitter2: TSplitter
        Left = 1
        Top = 20
        Width = 878
        Height = 3
        Cursor = crVSplit
        Align = alTop
        Color = clTeal
        ParentColor = False
      end
      object Splitter1: TSplitter
        Left = 549
        Top = 23
        Height = 576
        Align = alRight
        Color = clTeal
        ParentColor = False
      end
      object UpPanel: TPanel
        Left = 1
        Top = 1
        Width = 878
        Height = 19
        Align = alTop
        TabOrder = 0
        Visible = False
      end
      object DirectoryListBox1: TDirectoryListBox
        Left = 72
        Top = 240
        Width = 105
        Height = 89
        ItemHeight = 16
        TabOrder = 1
        Visible = False
      end
      object VT2: TVirtualDrawTree
        Left = 552
        Top = 23
        Width = 327
        Height = 576
        Align = alRight
        DefaultNodeHeight = 120
        Header.AutoSizeIndex = 0
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.MainColumn = -1
        Header.Options = [hoColumnResize, hoDrag]
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowBackground, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toStaticBackground]
        TreeOptions.SelectionOptions = [toDisableDrawSelection, toFullRowSelect]
        OnDrawNode = VT2DrawNode
        Columns = <>
      end
      object VT: TVirtualDrawTree
        Left = 1
        Top = 23
        Width = 548
        Height = 576
        Align = alClient
        CheckImageKind = ckXP
        DefaultNodeHeight = 120
        Header.AutoSizeIndex = 0
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.MainColumn = -1
        Header.Options = [hoColumnResize, hoDrag]
        HintMode = hmHint
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowBackground, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toStaticBackground]
        TreeOptions.SelectionOptions = [toDisableDrawSelection, toFullRowSelect, toMultiSelect]
        OnClick = VTClick
        OnDblClick = VTDblClick
        OnDrawHint = VTDrawHint
        OnDrawNode = VTDrawNode
        OnGetHintSize = VTGetHintSize
        Columns = <>
      end
    end
  end
  object PanelCopy: TPanel
    Left = 0
    Top = 680
    Width = 888
    Height = 15
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    DesignSize = (
      888
      15)
    object LabelCopyright: TLabel
      Left = 3
      Top = 1
      Width = 99
      Height = 12
      Caption = 'Copyright 2010 (c) MyIE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 814
      Top = 0
      Width = 67
      Height = 14
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      Caption = 'http://loc-id.ru'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label2Click
    end
  end
  object DownPanelWithButton: TPanel
    Left = 0
    Top = 631
    Width = 888
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      888
      28)
    object ToolBar1: TToolBar
      Left = 544
      Top = 0
      Width = 345
      Height = 28
      Align = alNone
      Anchors = [akRight, akBottom]
      ButtonHeight = 26
      ButtonWidth = 170
      EdgeBorders = []
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Images = MainForm.ImageList1
      List = True
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      object ButtonSbros: TToolButton
        Left = 0
        Top = 0
        Caption = #1057#1073#1088#1086#1089' ('#1089' '#1085#1072#1095#1072#1083#1072')'
        ImageIndex = 7
        OnClick = ButtonSbrosClick
      end
      object ButtonCreateMidlet: TToolButton
        Left = 170
        Top = 0
        Caption = #1057#1086#1073#1088#1072#1090#1100' LocID'
        ImageIndex = 6
        OnClick = ButtonCreateMidletClick
      end
    end
  end
  object DownPanel1: TPanel
    Left = 0
    Top = 610
    Width = 888
    Height = 21
    Align = alBottom
    TabOrder = 3
    Visible = False
  end
  object DownPanel2: TPanel
    Left = 0
    Top = 659
    Width = 888
    Height = 21
    Align = alBottom
    TabOrder = 4
    Visible = False
  end
end
