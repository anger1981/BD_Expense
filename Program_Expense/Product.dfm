object Form_Product: TForm_Product
  Left = 0
  Top = 0
  Caption = #1058#1086#1074#1072#1088
  ClientHeight = 381
  ClientWidth = 499
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
    499
    381)
  PixelsPerInch = 96
  TextHeight = 13
  object DBG_Product: TDBGrid
    Left = 8
    Top = 8
    Width = 483
    Height = 313
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds_Product
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBG_ProductDblClick
    OnKeyDown = DBG_ProductKeyDown
  end
  object DBN_Product: TDBNavigator
    Left = 120
    Top = 336
    Width = 240
    Height = 25
    DataSource = ds_Product
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    OnClick = DBN_ProductClick
  end
  object ADOQ_Product: TADOQuery
    Active = True
    Connection = Main_Form.ADOCon_Herson_Saldo_2020
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * From Product')
    Left = 16
    Top = 328
    object ADOQ_ProductID: TAutoIncField
      DisplayLabel = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
      FieldName = 'ID'
      ReadOnly = True
    end
    object ADOQ_ProductName: TWideStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
      DisplayWidth = 50
      FieldName = 'Name'
      FixedChar = True
      Size = 10
    end
  end
  object ds_Product: TDataSource
    DataSet = ADOQ_Product
    Left = 64
    Top = 328
  end
end
