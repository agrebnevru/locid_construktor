object FormCreator: TFormCreator
  Left = 1277
  Top = 120
  BorderStyle = bsSingle
  Caption = #1057#1073#1086#1088#1082#1072' '#1084#1080#1076#1083#1077#1090#1072
  ClientHeight = 135
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000040040000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000499B67FF6D9B4FFF3F904BFF00000000458F
    55FF4F985AFF4D9D60FF00000000000000000000000000000000000000000000
    00000000000000000000419B77FF57D18BFF3ADD64FF30ED6CFF50985CFF65F3
    A8FF35CF6AFF31CC61FF479457FF000000000000000000000000000000000000
    000000000000000000004B9466FF90FEC4FF45FF9AFF2FEF6CFF449742FF92FE
    C9FF62FFABFF3AF37FFF3E974DFF000000000000000000000000000000000000
    0000798F77FF568F52FF55965EFFD2FFE8FF75F6BBFF5BEA8EFF739858FFC1FC
    E7FF8CF6C1FF47CD7BFF56A359FF548A55FF5C8C70FF00000000000000004396
    58FF28BD63FF2AD85CFF17C053FF42965FFF88F9B6FF3EEB89FF4D9451FF86FF
    CEFF7AF2B2FF2CB760FF48D568FF3BD860FF40C45FFF469454FF000000003DA0
    4AFF66EF94FF1CE770FF47D166FF35C46DFF55A34BFF35C05FFF289B69FF74F3
    A8FF31AD61FF59EE96FF46E77BFF28DE61FF29C951FF40A549FF000000004D95
    61FF61E0B9FF53E4B7FF70FFC5FF62F5B1FF2ECC72FF5E9966FF24FAEFFF588F
    68FF85ECBFFF68FBC7FF77F9C2FF4BDB9AFF35C37EFF4E9B5EFF000000000000
    000045845AFF5CA168FF518C52FF55925AFF469465FF32FCE5FF26EAFFFF2CFF
    DEFF4F8F65FF709164FF588951FF4BA758FF468857FF00000000000000005D8D
    5DFF37CD7AFF1CAE50FF22BC5DFF51B75FFF16AC52FF2AA874FF3EFFEAFF5A8F
    68FF3DAA5EFF13B85DFF33BF64FF1AAD3DFF27AB51FF5A8D61FF000000005490
    50FF4BD67BFF12C75EFF35C461FF2CC054FF7CA849FF24B259FF3B8C5FFF1CB8
    6BFF42A849FF33DA73FF2FC561FF2AC14DFF34B24EFF5D8D45FF00000000559A
    68FF80F7B2FF63E098FF2DD485FF409344FF3DB550FF379F47FF4C985EFF3FD3
    7FFF339F3CFF349F48FF4DDE8FFF39DF82FF359E55FF519C5EFF000000000000
    000051926BFF458D63FF4A946AFF31CA7FFF29B557FF2B9F46FF519659FF3EE4
    85FF45B44CFF1EA14AFF61885AFF658C5FFF3E8F68FF00000000000000000000
    000000000000000000003F8C67FF3CDA93FF37CF6FFF09993AFF6E8E53FF44F0
    8AFF2ADD64FF0DA649FF489262FF000000000000000000000000000000000000
    0000000000000000000039896CFF84F3BBFF4BFB9EFF2EB05DFF648D5AFF75FF
    B8FF45DE77FF1CD078FF5B8A69FF000000000000000000000000000000000000
    0000000000000000000000000000498966FF50985CFF45955AFF000000004A8C
    63FF5B9757FF499460FF0000000000000000000000000000000000000000FFFF
    0000F11F0000E00F0000E00F0000800300000001000000010000000100008003
    000000010000000100000001000080030000E00F0000E00F0000F11F0000}
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelCopy: TPanel
    Left = 0
    Top = 120
    Width = 377
    Height = 15
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 0
    DesignSize = (
      377
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
      Left = 303
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
  object InvisiblePanel: TPanel
    Left = -344
    Top = 8
    Width = 369
    Height = 65
    TabOrder = 1
    Visible = False
    object FileSee: TButton
      Left = 232
      Top = 8
      Width = 49
      Height = 49
      Caption = #1060'. '#1087#1086#1082'.'
      TabOrder = 0
      OnClick = FileSeeClick
    end
    object FileCatBox: TListBox
      Left = 120
      Top = 8
      Width = 49
      Height = 49
      ItemHeight = 13
      TabOrder = 1
    end
    object FileForArchivation: TFileListBox
      Left = 8
      Top = 8
      Width = 49
      Height = 49
      ItemHeight = 13
      TabOrder = 2
    end
    object CatForArchivation: TDirectoryListBox
      Left = 64
      Top = 8
      Width = 49
      Height = 49
      ItemHeight = 16
      TabOrder = 3
    end
    object CatSee: TButton
      Left = 176
      Top = 8
      Width = 49
      Height = 49
      Caption = #1050#1072#1090'. '#1087#1086#1082'.'
      TabOrder = 4
      OnClick = CatSeeClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 361
    Height = 113
    Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1084#1080#1076#1083#1077#1090#1072' '#1079#1072#1074#1077#1088#1096#1077#1085#1086
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 134
      Height = 13
      Caption = #1060#1072#1081#1083' '#1089#1086#1093#1088#1072#1085#1077#1085' '#1074' '#1082#1072#1090#1072#1083#1086#1075':'
    end
    object PathToMidlet: TLabel
      Left = 8
      Top = 32
      Width = 88
      Height = 13
      Caption = 'D:\MyMidlet.jar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ToolBar1: TToolBar
      Left = 248
      Top = 30
      Width = 113
      Height = 22
      Align = alNone
      ButtonWidth = 103
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = MainForm.ImageList1
      List = True
      ShowCaptions = True
      TabOrder = 0
      object ButtonFolderOpen: TToolButton
        Left = 0
        Top = 0
        Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091
        ImageIndex = 4
        Wrap = True
        OnClick = ButtonFolderOpenClick
      end
    end
    object ToolBar2: TToolBar
      Left = 214
      Top = 82
      Width = 145
      Height = 22
      Align = alNone
      ButtonWidth = 137
      Caption = 'ToolBar2'
      EdgeBorders = []
      Flat = True
      Images = MainForm.ImageList1
      List = True
      ShowCaptions = True
      TabOrder = 1
      object ButtonToCloseApplication: TToolButton
        Left = 0
        Top = 0
        Caption = #1047#1072#1082#1088#1099#1090#1100' '#1082#1086#1085#1089#1090#1088#1091#1082#1090#1086#1088
        ImageIndex = 0
        OnClick = ButtonToCloseApplicationClick
      end
    end
    object ToolBar3: TToolBar
      Left = 9
      Top = 82
      Width = 127
      Height = 22
      Align = alNone
      ButtonWidth = 111
      Caption = 'ToolBar3'
      EdgeBorders = []
      Flat = True
      Images = MainForm.ImageList1
      List = True
      ShowCaptions = True
      TabOrder = 2
      object ButtonGoMainForm: TToolButton
        Left = 0
        Top = 0
        Caption = #1050' '#1075#1083#1072#1074#1085#1086#1084#1091' '#1086#1082#1085#1091
        ImageIndex = 5
        OnClick = ButtonGoMainFormClick
      end
    end
  end
  object Zip: TVCLZip
    Left = 352
  end
end
