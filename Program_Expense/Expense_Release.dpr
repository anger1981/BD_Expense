program Expense_Release;

uses
  Forms,
  Main in 'Main.pas' {Main_Form},
  Client in 'Client.pas' {Form_Client},
  Constants in 'Constants.pas',
  Spec in 'Spec.pas' {Form_Spec},
  Product in 'Product.pas' {Form_Product},
  Help in 'Help.pas' {Form_Help};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TForm_Client, Form_Client);
  Application.CreateForm(TForm_Spec, Form_Spec);
  Application.CreateForm(TForm_Product, Form_Product);
  Application.CreateForm(TForm_Help, Form_Help);
  Application.Run;
end.
