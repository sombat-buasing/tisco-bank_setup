program tisco_setup;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uData in 'uData.pas' {dmData: TDataModule},
  uFunction in 'uFunction.pas',
  FileViewForm in 'FileViewForm.pas' {fmFileView},
  PromptForm in 'PromptForm.pas' {fmPrompt};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfmFileView, fmFileView);
  Application.CreateForm(TfmPrompt, fmPrompt);
  Application.Run;
end.
