unit Help;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_Help = class(TForm)
    MemoHelp: TMemo;
    Ok: TButton;
    procedure OkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Help: TForm_Help;

implementation

{$R *.dfm}

procedure TForm_Help.OkClick(Sender: TObject);
begin
  CloseModal;
end;

end.
