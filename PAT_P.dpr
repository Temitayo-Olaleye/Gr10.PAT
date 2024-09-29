program PAT_P;

uses
  Vcl.Forms,
  PAT_U in 'PAT_U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
