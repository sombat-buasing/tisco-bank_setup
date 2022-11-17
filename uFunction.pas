unit uFunction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, Buttons, ToolWin, DateUtils,
  strutils, Math ;

  function Decrypt( sMessage : string ) : string;
  function Encrypt( sMessage : string ) : string;

implementation

function Decrypt( sMessage : string ) : string;
//var
//  i : integer;
//  sOutput, sDec, sTemp : string;
//  rCode : real;
begin
  result := sMessage ;
//  sOutput := '';
//  sDec := '';
//
//  sMessage := Trim(sMessage) + ' ';
//
//  for i := 1  to Length(sMessage) do
//  begin
//    if sMessage[i] <> ' ' then
//    begin
//      sDec := sDec + sMessage[i] ;
//    end
//    else
//    begin
//      rCode := sqrt( strtoInt(sDec) ) ;
//      sTemp := FloatToStr( rCode ) ;
//      sOutput := sOutput + chr(StrToInt(sTemp));
//      sDec := '';
//    end;
//
//  end;
//  result := sOutput;
end;

function encrypt( sMessage : string ) : string;
//var
//  i : integer;
//  sOutput : string;
//  rCode : real;
begin
//  sOutput := '';
//  for i := 1 to length(sMessage) do
//  begin
//    rCode := power( ord(sMessage[i]),2);
//
//    sOutput := sOutput + FloatToStr(rCode) + ' ' ;
//
//  end;
//  result := sOutput ;
  result := sMessage;
end;


end.
