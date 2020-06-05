unit Spec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Main, ExtCtrls, DBCtrls, DB, ADODB, Grids, DBGrids, Constants,
  Product, ActnList;

type
  TForm_Spec = class(TForm)
    DBN_Expense_Spec_Prod: TDBNavigator;
    ds_Expense_Spec_Prod: TDataSource;
    DBG_Expense_Spec_Prod: TDBGrid;
    ADOQ_Expense_Spec_Prod: TADOQuery;
    ADOQ_Expense_Spec_ProdID: TAutoIncField;
    ADOQ_Expense_Spec_ProdProdName: TWideStringField;
    ADOQ_Expense_Spec_ProdProduct_ID: TIntegerField;
    ADOQ_Expense_Spec_ProdExpense_ID: TIntegerField;
    ADOQ_Expense_Spec_ProdPrice: TBCDField;
    ADOQ_Expense_Spec_ProdCount: TIntegerField;
    ADOQ_Expense_Spec_ProdSumma: TBCDField;
    ActionList1: TActionList;
    procedure FormShow(Sender: TObject);
    procedure DBG_Expense_Spec_ProdCellClick(Column: TColumn);
    procedure DBN_Expense_Spec_ProdClick(Sender: TObject; Button: TNavigateBtn);
    procedure DBG_Expense_Spec_ProdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBG_Expense_Spec_ProdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBG_Expense_Spec_ProdColEnter(Sender: TObject);
  private
    FExpense_ID: Integer;
    procedure SetExpense_ID(const Value: Integer);
    procedure RefreshADOQ_Expense_Spec_Prod;
    procedure DBG_Expense_Spec_ProdFocusCell(const fieldName : string);
    procedure SetProduct;
    procedure CreateNewExpenseSpec;
    procedure EditCurrentExpenseSpecSingl;
    procedure PriceCountUpd;
    { Private declarations }
  public
    property Expense_ID: Integer read FExpense_ID write SetExpense_ID;
    { Public declarations }
  end;

var
  Form_Spec: TForm_Spec;

implementation

{$R *.dfm}

procedure TForm_Spec.CreateNewExpenseSpec;
begin
  ADOQ_Expense_Spec_Prod.Insert;
  ADOQ_Expense_Spec_Prod.Fields.FieldByName('Expense_ID').ReadOnly := False;
  DBG_Expense_Spec_Prod.DataSource.DataSet.FieldByName('Expense_ID').Value := Expense_ID;
  ADOQ_Expense_Spec_Prod.Fields.FieldByName('Expense_ID').ReadOnly := True;
  SetProduct;
  ADOQ_Expense_Spec_Prod.Post;
  RefreshADOQ_Expense_Spec_Prod;
  DBG_Expense_Spec_ProdFocusCell('Price');
  DBG_Expense_Spec_Prod.Options := DBG_Expense_Spec_Prod.Options + [dgEditing];

end;

procedure TForm_Spec.DBG_Expense_Spec_ProdCellClick(Column: TColumn);
begin
if ADOQ_Expense_Spec_Prod.State in [dsEdit, dsInsert] then
  if DBG_Expense_Spec_Prod.SelectedField.Name = ADOQ_Expense_Spec_ProdProdName.Name then
    SetProduct;

if ADOQ_Expense_Spec_Prod.State in [dsInsert] then
  DBG_Expense_Spec_Prod.DataSource.DataSet.FieldByName('Expense_ID').Value := Expense_ID;

end;

procedure TForm_Spec.DBG_Expense_Spec_ProdColEnter(Sender: TObject);
begin
  if (DBG_Expense_Spec_Prod.SelectedField.Name <> ADOQ_Expense_Spec_ProdPrice.Name) and
     (DBG_Expense_Spec_Prod.SelectedField.Name <> ADOQ_Expense_Spec_ProdCount.Name) then
    DBG_Expense_Spec_Prod.Options := DBG_Expense_Spec_Prod.Options - [dgEditing]
  else
    DBG_Expense_Spec_Prod.Options := DBG_Expense_Spec_Prod.Options + [dgEditing];

end;

procedure TForm_Spec.DBG_Expense_Spec_ProdFocusCell(const fieldName: string);
var
   column : integer;
   idx : integer;
begin
   column := 0;
   for idx:= 0 to DBG_Expense_Spec_Prod.Columns.Count - 1 do
   begin
     if DBG_Expense_Spec_Prod.Columns[idx].FieldName = fieldName then
     begin
       column := idx;
       Break;
     end;
   end;

   DBG_Expense_Spec_Prod.SelectedIndex := column;
end;

procedure TForm_Spec.SetProduct;
begin
  // 'ADOQ_Expense_ClientName' then
  if Form_Product.ShowModal = mrOK then
  begin
    ADOQ_Expense_Spec_Prod.Fields.FieldByName('ProdName').ReadOnly := False;
    DBG_Expense_Spec_Prod.DataSource.DataSet.FieldByName('Product_ID').Value := Form_Product.SelectedProductID;
    DBG_Expense_Spec_Prod.DataSource.DataSet.FieldByName('ProdName').Value := Form_Product.SelectedProductName;
    ADOQ_Expense_Spec_Prod.Fields.FieldByName('ProdName').ReadOnly := True;
  end;
end;

procedure TForm_Spec.DBG_Expense_Spec_ProdKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case ord(Key) of

    VK_INSERT:
      begin
        CreateNewExpenseSpec;
        PostMessage(DBG_Expense_Spec_Prod.handle, WM_KEYDOWN, VK_DOWN, 0);
      end;

    VK_DELETE:
      if MessageBox(Main_Form.Handle, 'Удалить выбранный документ расход?','Удаление документа расхлда', MB_YESNO + MB_ICONQUESTION ) = mrYes  then
        begin
          ADOQ_Expense_Spec_Prod.Delete;
          DBG_Expense_Spec_Prod.SetFocus;
          RefreshADOQ_Expense_Spec_Prod;
        end
      else
        DBG_Expense_Spec_Prod.SetFocus;

    VK_ESCAPE:
      Form_Spec.Close;

    VK_RETURN:
      if Shift = [ssShift] then
        EditCurrentExpenseSpecSingl
      else
        PriceCountUpd;

  end;
end;

procedure TForm_Spec.DBG_Expense_Spec_ProdKeyPress(Sender: TObject;
  var Key: Char);
begin
//
//if ord(Key) = VK_RETURN then
//  if ADOQ_Expense_Spec_Prod.State in [dsEdit, dsInsert] then
//    if (DBG_Expense_Spec_Prod.SelectedField.Name = ADOQ_Expense_Spec_ProdProdName.Name) or
//       (DBG_Expense_Spec_Prod.SelectedField.Name = ADOQ_Expense_Spec_ProdPrice.Name)    or
//       (DBG_Expense_Spec_Prod.SelectedField.Name = ADOQ_Expense_Spec_ProdCount.Name)    then
//    begin
//      ADOQ_Expense_Spec_Prod.Post;
//      RefreshADOQ_Expense_Spec_Prod;
//    end;
//
//if ord(Key) = VK_LEFT then
//  DBG_Expense_Spec_Prod.SelectedIndex := DBG_Expense_Spec_Prod.SelectedIndex + 1;
//
//if ord(Key) = VK_RIGHT then
//  DBG_Expense_Spec_Prod.SelectedIndex := DBG_Expense_Spec_Prod.SelectedIndex - 1;

end;

procedure TForm_Spec.DBN_Expense_Spec_ProdClick(Sender: TObject;
  Button: TNavigateBtn);
begin

  ADOQ_Expense_Spec_Prod.Fields.FieldByName('ProdName').ReadOnly := False;

  if Button = nbInsert  then
    CreateNewExpenseSpec;

  if Button = nbEdit  then
    EditCurrentExpenseSpecSingl;

  if not(Button in [nbInsert, nbEdit]) then
    ADOQ_Expense_Spec_Prod.Fields.FieldByName('ProdName').ReadOnly := True;

  if Button in [nbPost, nbRefresh] then
    RefreshADOQ_Expense_Spec_Prod;
end;

procedure TForm_Spec.EditCurrentExpenseSpecSingl;
begin
  ADOQ_Expense_Spec_Prod.Edit;
  SetProduct;
  ADOQ_Expense_Spec_Prod.Post;
  RefreshADOQ_Expense_Spec_Prod;
  DBG_Expense_Spec_ProdFocusCell('Price');
  DBG_Expense_Spec_Prod.Options := DBG_Expense_Spec_Prod.Options + [dgEditing];
end;

procedure TForm_Spec.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Main_Form.RefreshADOQ_Expense_Client;
end;

procedure TForm_Spec.FormCreate(Sender: TObject);
var
  l: DWORD;
begin
//  ADOQ_Expense_Spec_Prod.Active := False;
//  ADOQ_Expense_Spec_Prod.SQL.Clear;
//  ADOQ_Expense_Spec_Prod.SQL.Add(ArrExpenseSpecProdSQLQueryText[sqAll]);
//  ADOQ_Expense_Spec_Prod.Active := True;

  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MINIMIZEBOX);
  l := SetWindowLong(Self.Handle, GWL_STYLE, l);

end;

procedure TForm_Spec.FormShow(Sender: TObject);
begin
  ADOQ_Expense_Spec_Prod.Active := False;
  ADOQ_Expense_Spec_Prod.SQL.Clear;
  ADOQ_Expense_Spec_Prod.SQL.Add(ArrExpenseSpecProdSQLQueryText[sqExpense_ID]);
  ADOQ_Expense_Spec_Prod.Parameters.ParamByName(ArrExpenseSpecProdParamNames[sqExpense_ID]).Value := Expense_ID;
  ADOQ_Expense_Spec_Prod.Active := True;
end;

procedure TForm_Spec.PriceCountUpd;
begin
  if DBG_Expense_Spec_Prod.SelectedField.Name = ADOQ_Expense_Spec_ProdPrice.Name then
  begin
    ADOQ_Expense_Spec_Prod.Post;
    RefreshADOQ_Expense_Spec_Prod;
    DBG_Expense_Spec_ProdFocusCell('Count');
  end
  else if DBG_Expense_Spec_Prod.SelectedField.Name = ADOQ_Expense_Spec_ProdCount.Name then
    begin
      ADOQ_Expense_Spec_Prod.Post;
      RefreshADOQ_Expense_Spec_Prod;
      DBG_Expense_Spec_ProdFocusCell('ID');
      DBG_Expense_Spec_Prod.Options := DBG_Expense_Spec_Prod.Options - [dgEditing];
    end;
end;

procedure TForm_Spec.RefreshADOQ_Expense_Spec_Prod;
var
  Bookmark : TBookmark;
begin
  Bookmark := DBG_Expense_Spec_Prod.DataSource.DataSet.GetBookmark;
  ADOQ_Expense_Spec_Prod.Active := False;
  ADOQ_Expense_Spec_Prod.Active := True;

  try
    DBG_Expense_Spec_Prod.DataSource.DataSet.GotoBookmark(Bookmark);
  except
    ShowMessage('Проверьте строку ввода');
  end;

end;

procedure TForm_Spec.SetExpense_ID(const Value: Integer);
begin
  FExpense_ID := Value;
end;

end.
