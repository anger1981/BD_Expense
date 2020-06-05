object Form_Spec: TForm_Spec
  Left = 0
  Top = 0
  Caption = #1057#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1088#1072#1089#1093#1086#1076#1072
  ClientHeight = 406
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    852
    406)
  PixelsPerInch = 96
  TextHeight = 13
  object DBN_Expense_Spec_Prod: TDBNavigator
    Left = 184
    Top = 351
    Width = 370
    Height = 26
    DataSource = ds_Expense_Spec_Prod
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 0
    OnClick = DBN_Expense_Spec_ProdClick
  end
  object DBG_Expense_Spec_Prod: TDBGrid
    Left = 8
    Top = 8
    Width = 836
    Height = 321
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds_Expense_Spec_Prod
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBG_Expense_Spec_ProdCellClick
    OnColEnter = DBG_Expense_Spec_ProdColEnter
    OnKeyDown = DBG_Expense_Spec_ProdKeyDown
    OnKeyPress = DBG_Expense_Spec_ProdKeyPress
  end
  object ADOQ_Expense_Spec_Prod: TADOQuery
    Connection = Main_Form.ADOCon_Herson_Saldo_2020
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT es.ID, (select top 1 Name from Product p where p.ID = es.' +
        'Product_ID) as ProdName, es.Product_ID, es.Expense_ID, es.Price,' +
        ' es.Count, es.Summa '
      '  FROM Expense_Spec es')
    Left = 24
    Top = 352
    object ADOQ_Expense_Spec_ProdID: TAutoIncField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 12
      FieldName = 'ID'
      ReadOnly = True
    end
    object ADOQ_Expense_Spec_ProdProdName: TWideStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
      DisplayWidth = 50
      FieldName = 'ProdName'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object ADOQ_Expense_Spec_ProdProduct_ID: TIntegerField
      FieldName = 'Product_ID'
      Visible = False
    end
    object ADOQ_Expense_Spec_ProdExpense_ID: TIntegerField
      FieldName = 'Expense_ID'
      Visible = False
    end
    object ADOQ_Expense_Spec_ProdPrice: TBCDField
      DisplayLabel = #1062#1077#1085#1072
      DisplayWidth = 20
      FieldName = 'Price'
      Precision = 19
    end
    object ADOQ_Expense_Spec_ProdCount: TIntegerField
      DisplayLabel = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      DisplayWidth = 20
      FieldName = 'Count'
    end
    object ADOQ_Expense_Spec_ProdSumma: TBCDField
      DisplayLabel = #1057#1091#1084#1084#1072
      DisplayWidth = 20
      FieldName = 'Summa'
      ReadOnly = True
      Precision = 19
    end
  end
  object ds_Expense_Spec_Prod: TDataSource
    DataSet = ADOQ_Expense_Spec_Prod
    Left = 80
    Top = 352
  end
  object ActionList1: TActionList
    Left = 128
    Top = 352
  end
end
