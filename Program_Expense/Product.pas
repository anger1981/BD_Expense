unit Product;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Main, DB, ADODB, ExtCtrls, DBCtrls, Grids, DBGrids;

type
  TForm_Product = class(TForm)
    DBG_Product: TDBGrid;
    DBN_Product: TDBNavigator;
    ADOQ_Product: TADOQuery;
    ds_Product: TDataSource;
    ADOQ_ProductID: TAutoIncField;
    ADOQ_ProductName: TWideStringField;
    procedure DBG_ProductDblClick(Sender: TObject);
    procedure DBN_ProductClick(Sender: TObject; Button: TNavigateBtn);
    procedure FormCreate(Sender: TObject);
    procedure DBG_ProductKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FSelectedProductID: Integer;
    FSelectedProductName: string;
    procedure SetSelectedProductID(const Value: Integer);
    procedure SetSelectedProductName(const Value: string);
    { Private declarations }
  public
    property SelectedProductID   : Integer read FSelectedProductID write SetSelectedProductID;
    property SelectedProductName : string read FSelectedProductName write SetSelectedProductName;
    { Public declarations }
  end;

var
  Form_Product: TForm_Product;

implementation

{$R *.dfm}

{ TForm_Product }

procedure TForm_Product.DBG_ProductDblClick(Sender: TObject);
begin
  SelectedProductID   := DBG_Product.Fields[0].AsInteger;
  SelectedProductName := DBG_Product.Fields[1].AsString;
  ModalResult := mrOk;
  CloseModal;
end;

procedure TForm_Product.DBG_ProductKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case ord(Key) of
    VK_RETURN:
      DBG_ProductDblClick(nil);

    VK_INSERT:
        ADOQ_Product.Insert;

    VK_DELETE:
        ADOQ_Product.Delete;

  end;
end;

procedure TForm_Product.DBN_ProductClick(Sender: TObject; Button: TNavigateBtn);
begin
  if Button in [nbInsert, nbEdit]  then
  begin
    ADOQ_Product.Fields.FieldByName('Name').ReadOnly := False;
    DBG_Product.Options := DBG_Product.Options + [dgEditing];
  end
  else
  begin
    ADOQ_Product.Fields.FieldByName('Name').ReadOnly := True;
    DBG_Product.Options := DBG_Product.Options - [dgEditing];
  end;
end;

procedure TForm_Product.FormCreate(Sender: TObject);
var
  l: DWORD;
begin

  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MINIMIZEBOX);
  l := SetWindowLong(Self.Handle, GWL_STYLE, l);

end;

procedure TForm_Product.FormShow(Sender: TObject);
begin
  ADOQ_Product.Active := True;
end;

procedure TForm_Product.SetSelectedProductID(const Value: Integer);
begin
  FSelectedProductID := Value;
end;

procedure TForm_Product.SetSelectedProductName(const Value: string);
begin
  FSelectedProductName := Value;
end;

end.
