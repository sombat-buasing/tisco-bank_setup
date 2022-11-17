unit uData;

interface

uses
  System.SysUtils, System.Classes, UniProvider, SQLServerUniProvider, Data.DB,
  DBAccess, Uni, MemDS;

type
  TdmData = class(TDataModule)
    tiscoConnection: TUniConnection;
    qryFind: TUniQuery;
    dsFind: TUniDataSource;
    SQLServerUniProvider1: TSQLServerUniProvider;
    qryData: TUniQuery;
    dsData: TUniDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmData: TdmData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
