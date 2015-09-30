inherited frmConsole: TfrmConsole
  Left = 244
  Top = 227
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1086#1085#1089#1086#1083#1100
  ClientHeight = 176
  ClientWidth = 363
  FormStyle = fsStayOnTop
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object lblSystem: TLabel
    Left = 8
    Top = 150
    Width = 93
    Height = 16
    Caption = #1089#1080#1089#1090#1077#1084#1072' '#1082#1086#1084#1072#1085#1076
  end
  object memDisplay: TMemo
    Left = 8
    Top = 10
    Width = 233
    Height = 57
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Lucida Console'
    Font.Style = []
    Lines.Strings = (
      '0123456789ABCDEF'
      '0123456789ABCDEF')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object btbGetDisplay: TBitBtn
    Left = 8
    Top = 76
    Width = 233
    Height = 25
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1077' '#1076#1080#1089#1087#1083#1077#1103
    TabOrder = 18
    OnClick = btbGetDisplayClick
  end
  object btbKey1: TBitBtn
    Left = 256
    Top = 10
    Width = 32
    Height = 32
    Caption = '1'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnClick = btbKey1Click
  end
  object btbKey2: TBitBtn
    Left = 288
    Top = 10
    Width = 32
    Height = 32
    Caption = '2'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
    OnClick = btbKey2Click
  end
  object btbKey3: TBitBtn
    Left = 320
    Top = 10
    Width = 32
    Height = 32
    Caption = '3'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    OnClick = btbKey3Click
  end
  object btbKey4: TBitBtn
    Left = 256
    Top = 42
    Width = 32
    Height = 32
    Caption = '4'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 4
    OnClick = btbKey4Click
  end
  object btbKey5: TBitBtn
    Left = 288
    Top = 42
    Width = 32
    Height = 32
    Caption = '5'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 5
    OnClick = btbKey5Click
  end
  object btbKey6: TBitBtn
    Left = 320
    Top = 42
    Width = 32
    Height = 32
    Caption = '6'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 6
    OnClick = btbKey6Click
  end
  object btbKey7: TBitBtn
    Left = 256
    Top = 74
    Width = 32
    Height = 32
    Caption = '7'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 7
    OnClick = btbKey7Click
  end
  object btbkey8: TBitBtn
    Left = 288
    Top = 74
    Width = 32
    Height = 32
    Caption = '8'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 8
    OnClick = btbkey8Click
  end
  object btbKey9: TBitBtn
    Left = 320
    Top = 74
    Width = 32
    Height = 32
    Caption = '9'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 9
    OnClick = btbKey9Click
  end
  object btbKeyMinus: TBitBtn
    Left = 256
    Top = 106
    Width = 32
    Height = 32
    Caption = '-'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 10
    OnClick = btbKeyMinusClick
  end
  object btbKey0: TBitBtn
    Left = 288
    Top = 106
    Width = 32
    Height = 32
    Caption = '0'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 11
    OnClick = btbKey0Click
  end
  object btbKeyPoint: TBitBtn
    Left = 320
    Top = 106
    Width = 32
    Height = 32
    Caption = '.'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 12
    OnClick = btbKeyPointClick
  end
  object btbKeyProgram: TBitBtn
    Left = 256
    Top = 138
    Width = 32
    Height = 32
    Caption = 'P'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 13
    OnClick = btbKeyProgramClick
  end
  object btbKeyEnter: TBitBtn
    Left = 288
    Top = 138
    Width = 64
    Height = 32
    Caption = #1042#1074#1086#1076
    ParentShowHint = False
    ShowHint = False
    TabOrder = 14
    OnClick = btbKeyEnterClick
  end
  object edtConsole: TEdit
    Left = 176
    Top = 114
    Width = 47
    Height = 24
    TabOrder = 16
    Text = '500'
  end
  object updConsole: TUpDown
    Left = 223
    Top = 114
    Width = 17
    Height = 24
    Associate = edtConsole
    Min = 50
    Max = 5000
    Increment = 100
    Position = 500
    TabOrder = 17
    Thousands = False
  end
  object chbConsole: TCheckBox
    Left = 8
    Top = 118
    Width = 161
    Height = 17
    Caption = #1095#1080#1090#1072#1090#1100' '#1087#1077#1088#1080#1086#1076#1080#1095#1077#1089#1082#1080
    TabOrder = 15
  end
  object cmbSystem: TComboBox
    Left = 176
    Top = 146
    Width = 65
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 1
    TabOrder = 19
    Text = 'CRC'
    Items.Strings = (
      'Esc'
      'CRC')
  end
  object timConsole: TTimer
    Enabled = False
    OnTimer = timConsoleTimer
    Left = 192
  end
end
