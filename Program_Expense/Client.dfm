object Form_Client: TForm_Client
  Left = 0
  Top = 0
  Caption = #1050#1083#1080#1077#1085#1090#1099
  ClientHeight = 427
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    464
    427)
  PixelsPerInch = 96
  TextHeight = 13
  object DBG_Client: TDBGrid
    Left = 8
    Top = 8
    Width = 446
    Height = 345
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds_Client
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBG_ClientDblClick
    OnKeyDown = DBG_ClientKeyDown
  end
  object DBNavigator1: TDBNavigator
    Left = 88
    Top = 376
    Width = 280
    Height = 25
    DataSource = ds_Client
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    OnClick = DBNavigator1Click
  end
  object ds_Client: TDataSource
    DataSet = ADOQ_Client
    Left = 48
    Top = 368
  end
  object ADOQ_Client: TADOQuery
    Active = True
    Connection = Main_Form.ADOCon_Herson_Saldo_2020
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Client')
    Left = 16
    Top = 368
    object ADOQ_ClientID: TAutoIncField
      DisplayLabel = #1050#1086#1076
      FieldName = 'ID'
      ReadOnly = True
    end
    object ADOQ_ClientName: TWideStringField
      DisplayLabel = #1048#1084#1103
      FieldName = 'Name'
      ReadOnly = True
      Size = 50
    end
  end
end
