program Projeto_Testes_JSon;

uses
  Vcl.Forms,
  Teste_Json in 'Teste_Json.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
