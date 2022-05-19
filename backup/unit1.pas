unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Clipbrd;

type

  { TForm1 }

  TForm1 = class(TForm)
    AlwaysOnTop: TCheckBox;
    copy_answer: TCheckBox;
    Main_Display: TEdit;
    Calculation: TStaticText;
    procedure AlwaysOnTopClick(Sender: TObject);
    procedure copy_answerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Main_DisplayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Main_DisplayKeyPress(Sender: TObject; var Key: char);


  private

  public

  end;

var
  Form1: TForm1;
  oper: char = 'n';  // +, -, *, /, n (nothing)
  answer: real = 0;
  number: real = 0;
  mode: char = 't';   //t = typing mode   a=answer mode
  typed: boolean = false;
  calculated: boolean = false;
implementation

{$R *.lfm}

{ TForm1 }


procedure ModeToT;
begin
  mode := 't';
  Form1.Main_Display.text := '0'
end;
procedure initialize;
begin
  Form1.Main_Display.text := '0';
  answer := 0;
  number := 0;
  Form1.Calculation.caption := '';
  Form1.Calculation.caption := '';
  calculated := false;
end;
procedure error(s: string);
begin
  initialize;
  Form1.Calculation.caption := 'Error: ' + s;
end;

procedure calculate;
begin
  if typed = true then number := StrToFloat(Form1.Main_Display.text);
  if not calculated then answer := StrToFloat(Form1.Main_Display.text)
  else
    begin
      Form1.Calculation.caption := FloatToStr(answer) + ' ' + oper;
      if oper = '+' then answer := answer + number;
      if oper = '-' then answer := answer - number;
      if oper = '*' then answer := answer * number;
      if ((oper = '/') and (number <> 0)) then answer := answer / number;
      if ((oper = '/') and (number = 0)) then
        begin
          error('Divition by zero');
          exit
        end;
      Form1.Calculation.caption := Form1.Calculation.caption + ' ' + FloatToStr(number) + ' =';
    end;
  Form1.Main_Display.text := FloatToStr(answer);
  mode := 'a';
  typed := false;
  calculated := true;
end;

procedure TForm1.Main_DisplayKeyPress(Sender: TObject; var Key: char);
begin
  if Key in ['0'..'9'] then
     begin
     if mode = 'a' then ModeToT;
     if Main_Display.text = '0' then Main_Display.text := Key
     else Main_Display.text := Main_Display.text + Key;
     typed := true;     //Clear operator after typing numbers
     end;

  if Key = '.' then
     begin
     if mode = 'a' then ModeToT;
     if pos('.',Main_Display.text) = 0 then Main_Display.text := Main_Display.text + Key;
     end;
  Main_Display.SelStart:=Length(Main_Display.text);    //Move cursor to the end of display
end;

procedure TForm1.Main_DisplayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s: string;
begin
  if Key = 46 then    //Delete key
     begin
       initialize;
     end;
  if Key = 8 then     //Backspace key

     begin
       if mode = 'a' then ModeToT;
       s := Main_Display.text;
       if Length(s) = 1 then s := '0'
       else Delete(s,Length(s),1);
       Main_Display.text := s
     end;
  if Key = 13 then    //Enter key
     begin
        calculate;
        if copy_answer.State = cbChecked then Clipboard.AsText := Main_Display.text;
        Main_Display.SelStart:=Length(Main_Display.text);   //move cursor to end of display
     end;
  if Key = 107 then   //Add (+) key
     begin
       if typed = true then
         begin
           calculate;
           oper := '+';
         end;
       Calculation.caption := FloatToStr(answer) + ' +';
       number := 0;
       oper := '+'
     end;
  if Key = 109 then    //Minus (-) key
    begin
      if typed = true then
        begin
          calculate;
          oper := '-';
        end;
      Calculation.caption := FloatToStr(answer) + ' -';
      number := 0;
      oper := '-'
    end;
  if Key = 106 then    //Multiply (*) key
    begin
      if typed = true then
        begin
          calculate;
          oper := '*';
        end;
      Calculation.caption := FloatToStr(answer) + ' *';
      number := 0;
      oper := '*';
    end;
  if Key = 111 then    //Divide (/) key
    begin
      if typed = true then
        begin
          calculate;
          oper := '/';
        end;
      Calculation.caption := FloatToStr(answer) + ' /';
      number := 0;
      oper := '/';
    end;
  if Key = 220 then    //Negative (\) key
    begin
      if typed = true then
        begin
          if Main_Display.text <> '-' then Main_Display.text := FloatToStr(StrToFloat(Main_Display.text) * -1)
        end
      else Main_Display.text := '-';
      typed := true;
      mode := 't';
    end;
  if Key = then      //ESC key
    begin
      Form1.Close;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Main_Display.SelStart:=Length(Main_Display.text);   //move cursor to end of display
  DecimalSeparator:='.';
end;

procedure TForm1.AlwaysOnTopClick(Sender: TObject);
begin
  if AlwaysOnTop.checked then Form1.FormStyle := fsSystemStayOnTop
  else Form1.FormStyle := fsNormal;
  Main_Display.SetFocus;
end;

procedure TForm1.copy_answerClick(Sender: TObject);
begin
  Main_Display.SetFocus;
end;



end.

