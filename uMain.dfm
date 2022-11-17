object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Tisco setup'
  ClientHeight = 390
  ClientWidth = 1034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 529
    Height = 390
    Align = alLeft
    Caption = 'Database'
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 525
      Height = 215
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object GroupBox1: TGroupBox
        Left = 24
        Top = 16
        Width = 489
        Height = 193
        TabOrder = 0
        object Label1: TLabel
          Left = 64
          Top = 28
          Width = 39
          Height = 13
          Caption = 'Server :'
        end
        object Label2: TLabel
          Left = 50
          Top = 59
          Width = 53
          Height = 13
          Caption = 'Database :'
        end
        object Label3: TLabel
          Left = 74
          Top = 90
          Width = 29
          Height = 13
          Caption = 'User :'
        end
        object Label4: TLabel
          Left = 50
          Top = 122
          Width = 53
          Height = 13
          Caption = 'Password :'
        end
        object Label5: TLabel
          Left = 45
          Top = 149
          Width = 58
          Height = 13
          Caption = 'Pass again :'
        end
        object edUnis_server: TEdit
          Left = 109
          Top = 25
          Width = 276
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object edUnis_database: TEdit
          Left = 109
          Top = 56
          Width = 276
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object edUnis_user: TEdit
          Left = 109
          Top = 87
          Width = 228
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object edUnis_pass_1: TEdit
          Left = 109
          Top = 119
          Width = 228
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 3
        end
        object edUnis_pass_2: TEdit
          Left = 109
          Top = 146
          Width = 228
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 4
        end
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 230
      Width = 525
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object btnSave: TBitBtn
        Left = 400
        Top = 2
        Width = 113
        Height = 25
        Caption = #3610#3633#3609#3607#3638#3585
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object BitBtn1: TBitBtn
        Left = 24
        Top = 3
        Width = 113
        Height = 25
        Caption = 'Test connection'
        TabOrder = 1
        OnClick = BitBtn1Click
      end
    end
  end
  object grpFTPInfo: TGroupBox
    Left = 529
    Top = 0
    Width = 488
    Height = 390
    Align = alLeft
    Caption = 'SFTP Info.'
    TabOrder = 1
    object ftpAddress: TLabeledEdit
      Left = 71
      Top = 21
      Width = 354
      Height = 21
      AutoSize = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'IP / Host : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      TabOrder = 0
    end
    object ftpPort: TLabeledEdit
      Left = 71
      Top = 48
      Width = 106
      Height = 21
      AutoSize = False
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Port : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      TabOrder = 1
    end
    object ftpUsername: TLabeledEdit
      Left = 71
      Top = 75
      Width = 219
      Height = 21
      AutoSize = False
      EditLabel.Width = 58
      EditLabel.Height = 13
      EditLabel.Caption = 'Username : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      TabOrder = 2
    end
    object ftpPassword: TLabeledEdit
      Left = 71
      Top = 102
      Width = 219
      Height = 21
      AutoSize = False
      EditLabel.Width = 56
      EditLabel.Height = 13
      EditLabel.Caption = 'Password : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object ftpRoot: TLabeledEdit
      Left = 71
      Top = 129
      Width = 354
      Height = 21
      AutoSize = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'SFTP Path : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      TabOrder = 4
    end
    object btnSaveFtpSetting: TBitBtn
      Left = 69
      Top = 205
      Width = 356
      Height = 25
      Caption = 'Save ftp setting.'
      TabOrder = 5
      OnClick = btnSaveFtpSettingClick
    end
    object btnLogin: TBitBtn
      Left = 69
      Top = 246
      Width = 68
      Height = 25
      Caption = 'Login'
      TabOrder = 6
      OnClick = btnLoginClick
    end
    object btnTestUpload: TBitBtn
      Left = 143
      Top = 246
      Width = 207
      Height = 25
      Caption = 'Test Upload.'
      TabOrder = 7
      OnClick = btnTestUploadClick
    end
    object btnLogout: TBitBtn
      Left = 356
      Top = 246
      Width = 68
      Height = 25
      Caption = 'Logout'
      TabOrder = 8
      OnClick = btnLogoutClick
    end
    object ProgressBar: TProgressBar
      Left = 69
      Top = 232
      Width = 356
      Height = 8
      TabOrder = 9
      Visible = False
    end
    object memLog: TMemo
      Left = 16
      Top = 408
      Width = 273
      Height = 43
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 10
    end
    object FileView: TTreeView
      Left = 16
      Top = 288
      Width = 469
      Height = 90
      BorderWidth = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HideSelection = False
      Indent = 19
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      ShowButtons = False
      ShowLines = False
      ShowRoot = False
      SortType = stText
      TabOrder = 11
      OnCompare = FileViewCompare
      OnDblClick = FileViewDblClick
    end
    object localRoot: TLabeledEdit
      Left = 71
      Top = 156
      Width = 322
      Height = 21
      AutoSize = False
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'Local Path : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      TabOrder = 12
    end
    object Button2: TButton
      Left = 400
      Top = 154
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 13
    end
    object edFilenameUpload: TLabeledEdit
      Left = 71
      Top = 181
      Width = 322
      Height = 21
      AutoSize = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Filename : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      LabelPosition = lpLeft
      ParentFont = False
      TabOrder = 14
    end
  end
  object ScSSHClient: TScSSHClient
    HostKeyAlgorithms = <
      item
        Algorithm = aaRSA
      end
      item
        Algorithm = aaDSA
      end>
    HostName = 'localhost'
    User = 'test'
    KeyStorage = ScFileStorage
    AfterConnect = ScSSHClientAfterConnect
    BeforeConnect = ScSSHClientBeforeConnect
    AfterDisconnect = ScSSHClientAfterDisconnect
    OnServerKeyValidate = ScSSHClientServerKeyValidate
    OnAuthenticationPrompt = ScSSHClientAuthenticationPrompt
    Left = 724
    Top = 296
  end
  object OpenDialog: TOpenDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 794
    Top = 300
  end
  object ScSFTPClient: TScSFTPClient
    SSHClient = ScSSHClient
    OnDirectoryList = ScSFTPClientDirectoryList
    OnCreateLocalFile = ScSFTPClientCreateLocalFile
    Left = 728
    Top = 362
  end
  object ScFileStorage: TScFileStorage
    Left = 808
    Top = 362
  end
end
