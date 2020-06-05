object Main_Form: TMain_Form
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1093#1086#1076
  ClientHeight = 536
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    966
    536)
  PixelsPerInch = 96
  TextHeight = 13
  object DBG_Expense_Client: TDBGrid
    Left = 8
    Top = 8
    Width = 950
    Height = 425
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds_Expense_Client
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBG_Expense_ClientCellClick
    OnDrawColumnCell = DBG_Expense_ClientDrawColumnCell
    OnDblClick = DBG_Expense_ClientDblClick
    OnKeyDown = DBG_Expense_ClientKeyDown
  end
  object DBN_Expense_Client: TDBNavigator
    Left = 264
    Top = 476
    Width = 430
    Height = 37
    DataSource = ds_Expense_Client
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    OnClick = DBN_Expense_ClientClick
  end
  object lcb_SelectExpenseByClient: TDBLookupComboBox
    Left = 120
    Top = 8
    Width = 177
    Height = 21
    Hint = 
      #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1088#1072#1089#1093#1086#1076#1099' '#1076#1083#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1082#1083#1080#1077#1085#1090#1072' ('#1085#1072#1078#1072#1090#1100' Enter), '#1086#1090#1086#1073#1088#1072 +
      #1079#1080#1090#1100' '#1076#1083#1103' '#1074#1089#1077#1093' ('#1085#1072#1078#1072#1090#1100' Esc):'
    KeyField = 'ID'
    ListField = 'Name'
    ListSource = Form_Client.ds_Client
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Visible = False
    OnCloseUp = lcb_SelectExpenseByClientCloseUp
    OnKeyPress = lcb_SelectExpenseByClientKeyPress
  end
  object cb_Spended: TComboBox
    Left = 720
    Top = 8
    Width = 57
    Height = 21
    Hint = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1085#1099#1077'/'#1085#1077#1087#1088#1086#1074#1077#1076#1077#1085#1085#1099#1077' '#1088#1072#1089#1093#1086#1076#1099' ('#1085#1072#1078#1072#1090#1100' Esc):'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Visible = False
    OnCloseUp = cb_SpendedCloseUp
    OnKeyPress = cb_SpendedKeyPress
    Items.Strings = (
      '[  ]'
      '[v]')
  end
  object ADOCon_Herson_Saldo_2020: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 472
  end
  object ADOQ_Expense_Client: TADOQuery
    Connection = ADOCon_Herson_Saldo_2020
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT ex.ID, (select top 1 Name from Client cl where cl.ID = ex' +
        '.Client_ID) as Name, ex.Client_ID, ex.Date, ex.Time_Create, ex.T' +
        'otal_Sum, ex.Spended, ex.Time_Spend'
      '  FROM Expense ex')
    Left = 80
    Top = 472
    object ADOQ_Expense_ClientID: TAutoIncField
      DisplayLabel = #1050#1086#1076' '#1056#1072#1089#1093#1086#1076#1072
      DisplayWidth = 15
      FieldName = 'ID'
      ReadOnly = True
    end
    object ADOQ_Expense_ClientName: TWideStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      DisplayWidth = 29
      FieldName = 'Name'
      ReadOnly = True
      Size = 50
    end
    object ADOQ_Expense_ClientDate: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072
      DisplayWidth = 22
      FieldName = 'Date'
      ReadOnly = True
    end
    object ADOQ_Expense_ClientTotal_Sum: TBCDField
      DisplayLabel = #1054#1073#1097#1072#1103' '#1089#1091#1084#1084#1072
      DisplayWidth = 24
      FieldName = 'Total_Sum'
      ReadOnly = True
      Precision = 19
    end
    object ADOQ_Expense_ClientTime_Create: TDateTimeField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1089#1086#1079#1076#1072#1085#1080#1103
      DisplayWidth = 22
      FieldName = 'Time_Create'
      ReadOnly = True
    end
    object ADOQ_Expense_ClientSpended: TBooleanField
      Alignment = taCenter
      DisplayLabel = #1055#1088#1086#1074#1077#1076#1077#1085
      DisplayWidth = 9
      FieldName = 'Spended'
    end
    object ADOQ_Expense_ClientTime_Spend: TDateTimeField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103
      DisplayWidth = 22
      FieldName = 'Time_Spend'
      ReadOnly = True
    end
    object ADOQ_Expense_ClientClient_ID: TIntegerField
      FieldName = 'Client_ID'
      Visible = False
    end
  end
  object ds_Expense_Client: TDataSource
    DataSet = ADOQ_Expense_Client
    Left = 128
    Top = 472
  end
  object ActionList: TActionList
    Left = 208
    Top = 472
    object ConnectDatabase: TAction
      Category = 'File'
      Caption = 'Connect&Database'
      OnExecute = ConnectDatabaseExecute
    end
    object Close: TAction
      Category = 'File'
      Caption = 'Clo&se'
      OnExecute = CloseExecute
    end
    object ByClient: TAction
      Category = 'Search'
      Caption = 'ByClient'
      ShortCut = 16451
      SecondaryShortCuts.Strings = (
        'Ctrl + F + C')
      OnExecute = ByClientExecute
    end
    object BySpended: TAction
      Category = 'Search'
      Caption = 'BySpended'
      ShortCut = 16467
      OnExecute = BySpendedExecute
    end
    object ExportToExcel: TAction
      Category = 'Report'
      Caption = 'ExportToE&xcel'
      OnExecute = ExportToExcelExecute
    end
    object HelpSimple: TAction
      Category = 'Help'
      Caption = 'Help'
      OnExecute = HelpSimpleExecute
    end
  end
  object MainMenu: TMainMenu
    Left = 248
    Top = 472
    object File1: TMenuItem
      Caption = 'File'
      object ConnectDatabase1: TMenuItem
        Action = ConnectDatabase
      end
      object Close1: TMenuItem
        Action = Close
      end
    end
    object Search1: TMenuItem
      Caption = 'Search'
      object ByClient1: TMenuItem
        Action = ByClient
      end
      object BySpended1: TMenuItem
        Action = BySpended
      end
    end
    object Report1: TMenuItem
      Caption = 'Report'
      object ExportToExcel1: TMenuItem
        Action = ExportToExcel
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Help2: TMenuItem
        Action = HelpSimple
      end
    end
  end
end
