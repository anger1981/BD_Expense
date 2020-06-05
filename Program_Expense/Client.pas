unit Client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, DBCtrls, Grids, DBGrids, Main;

type
  TForm_Client = class(TForm)
    DBG_Client: TDBGrid;
    DBNavigator1: TDBNavigator;
    ds_Client: TDataSource;
    ADOQ_Client: TADOQuery;
    ADOQ_ClientID: TAutoIncField;
    ADOQ_ClientName: TWideStringField;
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBG_ClientDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBG_ClientKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FSelectedClientID: Integer;
    FSelectedClientName: string;
    procedure SetSelectClientID(const Value: Integer);
    procedure SetSelectClientName(const Value: string);
    { Private declarations }
  public
    property SelectedClientID   : Integer read FSelectedClientID write SetSelectClientID;
    property SelectedClientName : string read FSelectedClientName write SetSelectClientName;
    { Public declarations }
  end;

var
  Form_Client: TForm_Client;

implementation

{$R *.dfm}

procedure TForm_Client.DBG_ClientDblClick(Sender: TObject);
begin
  SelectedClientID := DBG_Client.Fields[0].AsInteger;
  SelectedClientName := DBG_Client.Fields[1].AsString;
  ModalResult := mrOk;
  CloseModal;
end;

procedure TForm_Client.DBG_ClientKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case ord(Key) of
    VK_RETURN:
      DBG_ClientDblClick(nil);

    VK_INSERT:
        ADOQ_Client.Insert;

    VK_DELETE:
        ADOQ_Client.Delete;

  end;
end;

procedure TForm_Client.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  if Button in [nbInsert, nbEdit]  then
  begin
    ADOQ_Client.Fields.FieldByName('Name').ReadOnly := False;
    DBG_Client.Options := DBG_Client.Options + [dgEditing];
  end
  else
  begin
    ADOQ_Client.Fields.FieldByName('Name').ReadOnly := True;
    DBG_Client.Options := DBG_Client.Options - [dgEditing];
  end;

end;

procedure TForm_Client.FormCreate(Sender: TObject);
var
  l: DWORD;
begin

  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not(WS_MINIMIZEBOX);
  l := SetWindowLong(Self.Handle, GWL_STYLE, l);

end;

procedure TForm_Client.FormShow(Sender: TObject);
begin
  ADOQ_Client.Active := True;
end;

procedure TForm_Client.SetSelectClientID(const Value: Integer);
begin
  FSelectedClientID := Value;
end;

procedure TForm_Client.SetSelectClientName(const Value: string);
begin
  FSelectedClientName := Value;
end;

end.
