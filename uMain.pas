unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  IniFiles, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, ScBridge, ScSFTPClient, ScSSHClient, ScSSHUtils,
  ScCLRClasses, ScTypes, ScUtils, ScSFTPUtils ;

type
  TfrmMain = class(TForm)
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edUnis_server: TEdit;
    edUnis_database: TEdit;
    edUnis_user: TEdit;
    edUnis_pass_1: TEdit;
    edUnis_pass_2: TEdit;
    grpFTPInfo: TGroupBox;
    ftpAddress: TLabeledEdit;
    ftpPort: TLabeledEdit;
    ftpUsername: TLabeledEdit;
    ftpPassword: TLabeledEdit;
    ftpRoot: TLabeledEdit;
    btnSaveFtpSetting: TBitBtn;
    btnLogin: TBitBtn;
    btnTestUpload: TBitBtn;
    btnLogout: TBitBtn;
    ProgressBar: TProgressBar;
    memLog: TMemo;
    FileView: TTreeView;
    localRoot: TLabeledEdit;
    Button2: TButton;
    edFilenameUpload: TLabeledEdit;
    Panel2: TPanel;
    btnSave: TBitBtn;
    BitBtn1: TBitBtn;
    ScSSHClient: TScSSHClient;
    OpenDialog: TOpenDialog;
    ScSFTPClient: TScSFTPClient;
    ScFileStorage: TScFileStorage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveFtpSettingClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnTestUploadClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure ScSSHClientAfterConnect(Sender: TObject);
    procedure ScSSHClientAfterDisconnect(Sender: TObject);
    procedure ScSSHClientBeforeConnect(Sender: TObject);
    procedure ScSSHClientAuthenticationPrompt(Sender: TObject; const Name,
      Instruction: string; const Prompts: TArray<System.string>;
      var Responses: TArray<System.string>);
    procedure ScSSHClientServerKeyValidate(Sender: TObject;
      NewServerKey: TScKey; var Accept: Boolean);
    procedure FileViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure FileViewDblClick(Sender: TObject);
    procedure ScSFTPClientCreateLocalFile(Sender: TObject; const LocalFileName,
      RemoteFileName: string; Attrs: TScSFTPFileAttributes;
      var Handle: NativeUInt);
    procedure ScSFTPClientDirectoryList(Sender: TObject; const Path: string;
      const Handle: TArray<System.Byte>; FileInfo: TScSFTPFileInfo;
      EOF: Boolean);
  private
    { Private declarations }
    function  GetSelectedNode: TTreeNode;
    procedure btViewFile;
  public
    { Public declarations }
    procedure UpdateStatuses(lFlag : boolean);
    procedure OpenDir(const Path: string; const SelectedName: string = '');
    function GetRootDir : string;
    procedure DoServerKeyValidate(FileStorage: TScFileStorage;
              const HostKeyName: string; NewServerKey: TScKey; var Accept: Boolean);
    procedure ListDir(Path:String; List:TListBox);
    function  SFTP_Upload( myFile, destFile : string): boolean ;
    procedure UpdateLog( txText : string ) ;
  end;

var
  frmMain: TfrmMain;
  cFullFile : string;
  iniConfig : TIniFile;
  unisUser, unisServer, unisDatabase, unisPassword : string;
const
  SNoFilesSelected = 'No files selected!';

implementation

{$R *.dfm}

uses uData, uFunction, PromptForm, FileViewForm;



function TfrmMain.SFTP_Upload( myFile, destFile : string): boolean ;
var
  n : integer;
  lPass, lActive, ftpStatus : boolean;
  cDest : string;

begin
  cDest := destFile;
  Progressbar.Visible := True;

  lActive := ScSSHClient.Connected ;

  if (lActive = False) then
  begin
    n := 0;
    lPass := False;
    while (n < 3) and (lPass = False) do
    begin

      try
        ScSSHClient.Connect;
        lPass := True;
      except
//        on E: Exception do   .
        begin
          lPass := False;
          UpdateLog('ไม่สามารถติดต่อกับ SFP ได้ ครั้งที่ : ' + inttostr(n+1));
        ////////
        end;
      end;
      n := n + 1;
    end;
  end;




  if lPass = True then
  begin

    if cDest = Emptystr then
      cDest := myFile;

    try
//      ScSFTPClient.Initialize;
//      ScSFTPClient.SSHClient := ScSSHClient;
//      ScSFTPClient.Timeout := 5000 ;

      ScSFTPClient.UploadFile(myFile, GetRootDir + ExtractFileName(cDest), True);


      ftpStatus := True;
    Except
      UpdateLog( '[ ERROR SFTP ] : ' + FormatDateTime('DD/MM/YYYY', date) + ' ' +
                                       FormatDateTime('HH:MM:SS', time) );
      ftpStatus := False;
    end;

    if ScSSHClient.Connected then
       ScSSHClient.Disconnect;



    btnLoginClick(self);

    btnLogoutClick(self);
    btnLogin.Enabled := False;


    if ftpStatus = True then
    begin
      UpdateLog('ส่ง TextFile. ( ' + myFile +' ) สำเร็จ ');
      result := True;
    end
    else
    begin
      UpdateLog('ไม่สามารถส่ง TextFile. ( ' + myFile +'  ) ');
      result := False;
    end;




  end;

  ProgressBar.Visible := False;
end;


procedure TfrmMain.UpdateLog( txText : string ) ;
begin
  Showmessage( txText ) ;
//  qryEvent.Connection := dmlData.TimeConnection;
//
//  qryEvent.SQL.Clear;
//  qryEvent.SQL.Add('insert into log_event ' +
//    '( lg_logtime , lg_event ) Values ( :logtime, :event ) ' );
//  qryEvent.ParamByName('logtime').AsString := FormatDateTime('YYYY-MM-DD HH:MM:SS.zzz',now) ;
//  qryEvent.ParamByName('event'  ).AsString   := txText ;
//  qryEvent.ExecSQL;
end;



procedure TfrmMain.ListDir(Path:String; List:TListBox);
{Path : string that contains start path for listing filenames and directories
 List : List box in which found filenames are going to be stored }
var
  cFilenameUpload : string;
  SearchRec: TsearchRec;
  Result: integer;
  S: string; { Used to hold current directory, GetDir(0,s) }
begin
  cFilenameUpload := edFilenameUpload.Text;
     try {Exception handler }
        ChDir(Path);
     except on EInOutError do
            begin
                 MessageDlg('Error occurred by trying to change directory',mtWarning,[mbOK],0);
                 Exit;
            end;
     end;
     if length(path)<> 3 then path:=path+'\';   { Checking if path is root, if not add }
     FindFirst(path+'*.*',faAnyFile,SearchRec); { '\' at the end of the string         }
                                                { and then add '*.*' for all file     }
     Repeat
           if (SearchRec.Attr=faDirectory)  then   { if directory then }
           begin
                if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') and
                   (Lowercase(SearchRec.Name) <> 'backup')  then { Ignore '.' and '..' }
                begin
                     GetDir(0,s); { Get current dir of default drive }
                     if length(s)<>3 then s:=s+'\'; { Checking if root }
//                     List.Items.Add(s+SearchRec.Name); { Adding to list }
                     ListDir(s+SearchRec.Name,List); { ListDir found directory }
                end;
           end
           else { if not directory }
           begin
                GetDir(0,s); { Get current dir of default drive }
                if (length(s)<>3) and
                   (searchRec.Name = cFilenameUpload) then List.items.add(s+'\'+SearchRec.Name) { Checking if root }
                   else
                   begin
                     if SearchRec.Name = edFilenameUpload.Text then
                        List.items.add(s+SearchRec.Name); { Adding to list }
                   end;
           end;
           Result:=FindNext(SearchRec);
           Application.ProcessMessages;
     until result<>0; { Found all files, go out }
     GetDir(0,s);
     if length(s)<>3 then ChDir('..'); { if not root then go back one level }
end;


procedure TfrmMain.DoServerKeyValidate(FileStorage: TScFileStorage;
  const HostKeyName: string; NewServerKey: TScKey; var Accept: Boolean);
var
  Key: TScKey;
  fp, msg: string;
begin
  Key := FileStorage.Keys.FindKey(HostKeyName);
  if (Key = nil) or not Key.Ready then begin
    NewServerKey.GetFingerPrint(haMD5, fp);
    msg := 'The authenticity of server can not be verified.'#13#10 +
           'Fingerprint for the key received from server: ' + fp + '.'#13#10 +
           'Key length: ' + IntToStr(NewServerKey.BitCount) + ' bits.'#13#10 +
           'Are you sure you want to continue connecting?';

//    if MessageDlg(msg, mtConfirmation, [mbOk, mbCancel], 0) = mrOk then
    begin
      Key := TScKey.Create(nil);
      try
        Key.Assign(NewServerKey);
        Key.KeyName := HostKeyName;
        FileStorage.Keys.Add(Key);
      except
        Key.Free;
        raise;
      end;

      Accept := True;
    end;
  end;
end;


procedure TfrmMain.UpdateStatuses( lFlag : boolean);
begin
//  btnLogin.Enabled  := not lFlag;
//  btnLogout.Enabled := lFlag;
//  btnTestUpload.Enabled := lFlag ;
end;


function TfrmMain.GetRootDir: string;
begin
  Result := ftpRoot.Text;
  if IsDelimiter('/', Result, Length(Result)) and (Result[Length(Result)] = '/') then
    Exit;
  if IsDelimiter('\', Result, Length(Result)) and (Result[Length(Result)] = '\') then
    Exit;

  Result := Result + '/';
end;


procedure TfrmMain.BitBtn1Click(Sender: TObject);
var
  lDm : TdmData;
  lConnect : Boolean;
begin
  if edUnis_pass_1.Text <> edUnis_pass_2.Text then
  begin
    MessageDlg('รหัสผ่านไม่ถูกต้อง',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbCancel],0);
    edUnis_pass_1.SetFocus;
  end
  else
  begin
    lDm := TdmData.Create(self);
    try
      with lDm do
      begin
        tiscoConnection.Server    := edUnis_server.Text   ;
        tiscoConnection.Database  := edUnis_database.Text ;
        tiscoConnection.Username  := edUnis_user.Text     ;
        tiscoConnection.Password  := edUnis_pass_1.Text ;
        tiscoConnection.Connected := True ;
      end;
      lConnect := True;
    except
      lConnect := False;
    end;

    if lConnect = True then
    begin
      MessageDlg('Connect OK.',TMsgDlgType.mtInformation,[mbOK],0);
    end
    else
    begin
      MessageDlg('Not connect.',TMsgDlgType.mtWarning,[mbCancel],0);
    end;

  end;
end;

procedure TfrmMain.OpenDir(const Path: string; const SelectedName: string = '');
var
  OldCursor: TCursor;
  Handle: TScSFTPFileHandle;
  RootDir: string;
  i: Integer;
begin
  OldCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;

    RootDir := ScSFTPClient.RetrieveAbsolutePath(Trim(Path));
    Handle  := ScSFTPClient.OpenDirectory(RootDir);
    ftpRoot.Text := RootDir;

    try
      FileView.Items.Clear;
      while not ScSFTPClient.EOF(Handle) do
        ScSFTPClient.ReadDirectory(Handle);
    finally
      ScSFTPClient.CloseHandle(Handle);
    end;

    if SelectedName <> '' then begin
      for i := 0 to FileView.Items.Count - 1 do
        if LowerCase(FileView.Items[i].Text) = LowerCase(SelectedName) then begin
          FileView.Selected := FileView.Items[i];
          Exit;
        end;
    end;
  finally
    Screen.Cursor := OldCursor;
  end;
end;


procedure TfrmMain.ScSFTPClientCreateLocalFile(Sender: TObject;
  const LocalFileName, RemoteFileName: string; Attrs: TScSFTPFileAttributes;
  var Handle: NativeUInt);
var
  dwFlags: DWORD;
begin
  if aAttrs in Attrs.ValidAttributes then begin
    dwFlags := 0;
    if faReadonly in Attrs.Attrs then
      dwFlags := dwFlags or FILE_ATTRIBUTE_READONLY;
    if faSystem in Attrs.Attrs then
      dwFlags := dwFlags or FILE_ATTRIBUTE_SYSTEM;
    if faHidden in Attrs.Attrs then
      dwFlags := dwFlags or FILE_ATTRIBUTE_HIDDEN;
    if faArchive in Attrs.Attrs then
      dwFlags := dwFlags or FILE_ATTRIBUTE_ARCHIVE;
    if faCompressed in Attrs.Attrs then
      dwFlags := dwFlags or FILE_ATTRIBUTE_COMPRESSED;
  end
  else
    dwFlags := FILE_ATTRIBUTE_NORMAL;

  Handle := CreateFile(PChar(LocalFileName),
    GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_NEW, dwFlags, 0);
end;

procedure TfrmMain.ScSFTPClientDirectoryList(Sender: TObject;
  const Path: string; const Handle: TArray<System.Byte>;
  FileInfo: TScSFTPFileInfo; EOF: Boolean);
var
  Node: TTreeNode;
begin
  if (FileInfo = nil) or (FileInfo.Filename = '.') then
    Exit;

  Node := FileView.Items.Add(nil, '');
  if FileInfo.Filename = '..' then begin
    Node.ImageIndex := 2;
    Node.SelectedIndex := 2;
  end
  else if (Length(FileInfo.Longname) > 0) and (FileInfo.Longname[1] = 'd') then begin
    Node.ImageIndex := 1;
    Node.SelectedIndex := 1;
  end;

  Node.Text := FileInfo.Filename; // for sorting

end;

procedure TfrmMain.ScSSHClientAfterConnect(Sender: TObject);
begin
  UpdateStatuses( ScSSHClient.Connected) ;
end;

procedure TfrmMain.ScSSHClientAfterDisconnect(Sender: TObject);
begin
  UpdateStatuses( ScSSHClient.Connected );
end;

procedure TfrmMain.ScSSHClientAuthenticationPrompt(Sender: TObject; const Name,
  Instruction: string; const Prompts: TArray<System.string>;
  var Responses: TArray<System.string>);
begin
  if (Name = '') and (Length(Prompts) = 0) then
    Exit;

  fmPrompt.InitForm(Name, Instruction, Prompts);
  fmPrompt.ShowModal;
  fmPrompt.GetResponse(Responses);

end;

procedure TfrmMain.ScSSHClientBeforeConnect(Sender: TObject);
begin
  ScSSHClient.HostName := ftpAddress.Text;
  ScSSHClient.Port := StrToIntDef( ftpPort.Text, 22);
  ScSSHClient.User := ftpUserName.Text;

  ScSSHClient.Authentication := atPassword;
  ScSSHClient.Password := ftpPassword.Text;
end;

procedure TfrmMain.ScSSHClientServerKeyValidate(Sender: TObject;
  NewServerKey: TScKey; var Accept: Boolean);
var
  CurHostKeyName: string;
begin
   if ScSSHClient.HostKeyName = '' then
    CurHostKeyName := ScSSHClient.HostName
  else
    CurHostKeyName := ScSSHClient.HostKeyName;

  DoServerKeyValidate(ScFileStorage, CurHostKeyName, NewServerKey, Accept);
end;

procedure TfrmMain.btnLoginClick(Sender: TObject);
var
  lFlag : boolean;
begin
  memLog.Lines.Clear;

  if ScSSHClient.Connected then
  begin
    MessageDlg('You are already connected. Please click Logout to disconnect.',mtInformation,[mbOK],0);
    Exit;
  end;

  ScSSHClient.Connect;

  ScSFTPClient.Initialize;
//  ShowSFTPButtons(True);
  OpenDir(ftpRoot.Text);
end;

procedure TfrmMain.btnLogoutClick(Sender: TObject);
begin
  FileView.Items.Clear;
  ScSSHClient.Disconnect;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  if edUnis_pass_1.Text <> edUnis_pass_2.Text then
  begin
    MessageDlg('รหัสผ่านไม่ถูกต้อง',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbCancel],0);
    edUnis_pass_1.SetFocus;
  end
  else if edUnis_pass_1.text = Emptystr then
  begin
    MessageDlg('รหัสผ่านต้องไม่เป็นช่องว่าง',TMsgDlgType.mtWarning,[TMsgDlgBtn.mbCancel],0);
    edUnis_pass_1.SetFocus;
  end
  else
  begin

    unisServer   := edUnis_server.Text;
    unisDatabase := edUnis_database.Text;
    unisUser     := edUnis_user.Text;
    unisPassword := edUnis_pass_1.Text;

    iniConfig := TIniFile.Create(cFullFile);
    iniConfig.WriteString('Server','ServerName'  ,Encrypt(unisServer));
    iniConfig.WriteString('Server','DatabaseName',Encrypt(unisDatabase));
    iniConfig.WriteString('Server','Username'    ,Encrypt(unisUser));
    iniConfig.WriteString('Server','Password'    ,Encrypt(unisPassword));
    iniConfig.Free;

    with dmData do
    begin
      tiscoConnection.Server    := edUnis_server.Text   ;
      tiscoConnection.Database  := edUnis_database.Text ;
      tiscoConnection.Username  := edUnis_user.Text     ;
      tiscoConnection.Password  := edUnis_pass_1.Text ;
//      logConnection.Connected := True ;
    end;

    MessageDlg('บันทึกข้อมูลเรียบร้อย.',TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbOK],0);
  end;
end;

procedure TfrmMain.btnSaveFtpSettingClick(Sender: TObject);
var cDir,  cResult, cIniName : string ;
    iniConfig : TIniFile ;
begin
  cDir := ExtractFilePath(Application.ExeName) ;

  cIniName := 'config.ini' ;

  iniConfig := TIniFile.Create(cDir + cIniName );

  iniConfig.WriteString('FTP','Address' ,Encrypt(ftpAddress.Text));
  iniConfig.WriteString('FTP','Port'    ,Encrypt(ftpPort.Text));
  iniConfig.WriteString('FTP','Username',Encrypt(ftpUsername.Text));
  iniConfig.WriteString('FTP','Password',Encrypt(ftpPassword.Text));
  iniConfig.WriteString('FTP','Root'    ,ftpRoot.Text);
  iniConfig.WriteString('FTP','Local'   ,localRoot.Text);
  iniConfig.WriteString('FTP','Filename',edFilenameUpload.Text);

  iniConfig.Free;

  MessageDlg('Save SFTP Setting.' + #13 +
             'Complete.',mtInformation,[mbOK],0);
end;

procedure TfrmMain.btnTestUploadClick(Sender: TObject);
var
  myFile : TextFile;
  cDir : string;

  position, fileExistsResult: Integer;
  stream: TStream;
  fileName, fullName: string;
begin
  Progressbar.Visible := True;

  cDir := ExtractFilePath(Application.ExeName);

  Fullname := cDir + 'File_upload_test.txt';

  AssignFile(myFile,Fullname);
  FileMode := fmOpenReadWrite;
  Rewrite(myFile);
  WriteLn(myFile,'UPLOAD FILE Test') ;
  WriteLn(myFile,'Date : ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', now) ) ;
  CloseFile(myFile);

  OpenDialog.Title := 'Upload file';
  OpenDialog.Filter := 'All files (*.*)|*.*';
  if OpenDialog.Execute then
  begin
    ScSFTPClient.UploadFile(OpenDialog.FileName, GetRootDir + ExtractFileName(OpenDialog.FileName), True);
    OpenDir(ftpRoot.Text, ExtractFileName(OpenDialog.FileName));
  end;

  //ShowMessage(Format('Upload %s complete.!!!',[filename]));

  ProgressBar.Visible := False;
end;

procedure TfrmMain.FileViewCompare(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
begin
  Compare := Node2.ImageIndex - Node1.ImageIndex;
  if Compare = 0 then
    if LowerCase(Node1.Text) >= LowerCase(Node2.Text) then
      Compare := 1
    else
      Compare := -1;
end;

procedure TfrmMain.FileViewDblClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := GetSelectedNode;
  if Node = nil then
    Exit;

  case Node.ImageIndex of
    0:
      btViewFile;
    1:
      OpenDir(GetRootDir + Node.Text, '..');
    2:
      OpenDir(GetRootDir + Node.Text, ExtractFileName(StringReplace(ftpRoot.Text, '/', PathDelim, [rfReplaceAll])));
  end;
end;

function TfrmMain.GetSelectedNode: TTreeNode;
begin
  Result := nil;
  if FileView.Items.Count = 0 then
    Exit;

  Result := FileView.Selected;
  if Result = nil then
    Result := FileView.Items[0];
end;


procedure TfrmMain.btViewFile ;
var
  Node: TTreeNode;
  Handle: TScSFTPFileHandle;
  FileOffset: Int64;
  Buffer: TBytes;
  Count: Integer;
begin
  SetLength(Handle, 0);
  Node := GetSelectedNode;
  if (Node = nil) or (Node.ImageIndex <> 0) then begin
    MessageDlg(SNoFilesSelected, mtConfirmation, [mbOk], 0);
    Exit;
  end;

  fmFileView.Caption := Node.Text;
  fmFileView.Memo.Clear;

  Handle := ScSFTPClient.OpenFile(GetRootDir + Node.Text, [foRead]);
  try
    SetLength(Buffer, 32768);
    FileOffset := 0;
    while not ScSFTPClient.EOF(Handle) do begin
      Count := ScSFTPClient.ReadFile(Handle, FileOffset, Buffer, 0, Length(Buffer));
      if Count > 0 then
        fmFileView.Memo.Lines.Text := fmFileView.Memo.Lines.Text + string(Encoding.ASCII.GetString(Buffer, 0, Count));
      FileOffset := FileOffset + Count;
    end;
  finally
    ScSFTPClient.CloseHandle(Handle);
  end;

  fmFileView.ShowModal;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
//var
//  appIni, sysIni : TIniFile ;
//  txFile : TextFile ;
//  cText, cSystem, cDepart  : string ;
//  cDirectory : string;
begin

//  cDirectory := IncludeTrailingBackslash( ExtractFilePath(Application.ExeName));
//
//  with dmData do
//  begin
//    appIni := TIniFile.Create(cDirectory + 'Config.ini');
//    tiscoConnection.Connected := False ;
//    tiscoConnection.Server    := Decrypt( appIni.ReadString('Server','ServerName'  ,Encrypt('Server'))) ;
//    tiscoConnection.Username  := Decrypt( appIni.ReadString('Server','Username'    ,Encrypt('Username'))) ;
//    tiscoConnection.Password  := Decrypt( appIni.ReadString('Server','Password'    ,Encrypt('Password'))) ;
//    tiscoConnection.Database  := Decrypt( appIni.ReadString('Server','DatabaseName',Encrypt('Database'))) ;
//    appIni.Free;
//
//
//  qryFind.Sql.Clear;
//  qryFind.Sql.Add('Select * From tUser ' ) ;
//  qryFind.Active := True;
//
//  end;

end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  cDir : string;
  iniFilename : string;
begin
  cDir    := IncludeTrailingBackslash( ExtractFilePath(Application.ExeName)) ;
  iniFilename := 'Config.ini';

  cFullFile := cDir + iniFileName;
  if not FileExists( cFullFile ) then
  begin
    iniConfig := TIniFile.Create(cFullFile);
    iniConfig.WriteString('Server','ServerName'  ,Encrypt( '192.168.100.7'));
    iniConfig.WriteString('Server','DatabaseName',Encrypt('UMS_UNIS'));
    iniConfig.WriteString('Server','Username'    ,Encrypt('unisuser'));
    iniConfig.WriteString('Server','Password',Encrypt('unisamho'));
    iniConfig.Free;
  end;

  iniConfig := TIniFile.Create(cFullFile);
  edUnis_server.Text   := Decrypt(iniConfig.ReadString('Server','ServerName'  ,Encrypt(unisServer))) ;
  edUnis_database.Text := Decrypt(iniConfig.ReadString('Server','DatabaseName',Encrypt(unisDatabase))) ;
  edUnis_user.Text     := Decrypt(iniConfig.ReadString('Server','Username'    ,Encrypt(unisUser))) ;
  edUnis_pass_1.Text   := ''; //Decrypt(iniConfig.ReadString('Server','Password',Encrypt(unisPassword))) ;
  edUnis_pass_2.Text   := ''; //Decrypt(iniConfig.ReadString('Server','Password',Encrypt(unisPassword))) ;


  ftpAddress.Text   := Decrypt( iniConfig.ReadString('FTP','Address' ,Encrypt('192.168.100.6')));
  ftpPort.Text      := Decrypt( iniConfig.ReadString('FTP','Port'    ,Encrypt('22')));
  ftpUsername.Text  := Decrypt( iniConfig.ReadString('FTP','Username',Encrypt('Administrator')));
  ftpPassword.Text  := Decrypt( iniConfig.ReadString('FTP','Password',Encrypt('UmsBac@126')));
  ftpRoot.Text      := iniConfig.ReadString('FTP','Root','/');
  localRoot.Text    := iniConfig.ReadString('FTP','Local','C:\');
  edFilenameUpload.Text    := iniConfig.ReadString('FTP','Filename','Badghis.csv');



  iniConfig.Free;
end;

end.
