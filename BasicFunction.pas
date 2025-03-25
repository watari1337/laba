unit BasicFunction;

interface

function ReadInt(min, max: integer): integer;

implementation

uses System.SysUtils;

type SArr = array of string;

const //splitSimbol: string = ' ,;.';
      rusLetters: string = 'ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ';
      engLettersAndNum: string = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM0123456789';

//from big to little
procedure shake_sort(var arr: array of integer; long: integer);
var left, right, i, temp, lastSwap :integer;
begin
   left := 0;  //dinamic
   right := long-1; //dinamic
   lastSwap := 0;
   while (right > left) do begin
     for i := left to right-1 do begin
       if (arr[i] < arr[i+1]) then begin //change < on > to make from little to big
          temp := arr[i];
          arr[i] := arr[i+1];
          arr[i+1] := temp;
          lastSwap := i;
       end;
     end;
     right := lastSwap;
     for i := right downto left + 1 do begin
       if (arr[i] > arr[i-1]) then begin //change < on > to make from little to big
          temp := arr[i];
          arr[i] := arr[i-1];
          arr[i-1] := temp;
          lastSwap := i;
       end;
     end;
     left := lastSwap;
   end;
end;

function ReadInt(min, max: integer): integer;
var
    num: integer;
begin
  num:= min-1;
  while (num < min) or (num > max) do begin
    try
      read(num);
      if (num < min) or (num > max) then begin
        writeln('число должно быть больше ', min, ' и меньше ', max, ', повторите ввод');
      end;
    except
      num:= min-1;
      writeln('принимается только ввод чисел, повторите ввод');
    end;
  end;
  result:= num
end;

procedure LowerRus(var s1: String);
var
  len, i: Integer;
begin
  len := Length(s1);
  for i := 1 to len do
  begin
    if (s1[i] >= 'А') and (s1[i] <= 'Я') then
      s1[i] := Chr(Ord(s1[i])+32)
  end;
end;

function NumOfWords(str: string): integer;
begin
  insert(' ', str, 1);
  str := str + ' ';
  result := 0;
  for var i := 1 to length(str) - 1 do
  begin
    if ((not rusLetters.contains(str[i])) and rusLetters.contains(str[i+1])) then
      result := result + 1;
  end;
end;

function ListOfWords(str: string): SArr;
var
  startPos, endPos, wordNow, CountWords: integer;
  startFlag, endFlag: boolean;
  word: string;

begin
  insert(' ', str, 1);
  str := str + ' ';
  CountWords:= NumOfWords(str);
  setLength(result, CountWords);
  startFlag := False;
  endFlag := False;
  wordNow := 0;
  for var i := 1 to length(str) - 1 do
  begin
    if ((not rusLetters.contains(str[i])) and rusLetters.contains(str[i+1])) then
    begin
      startPos := i + 1;
      startFlag := True;
    end;
    if (rusLetters.contains(str[i]) and (not rusLetters.contains(str[i+1]))) then
    begin
      endPos := i;
      endFlag := True;
    end;
    if (startFlag and endFlag) then
    begin
      word:= copy(str, startPos, endPos - startPos + 1);
      LowerRus(word);
      result[wordNow] := word;
      wordNow := wordNow + 1;
      startFlag := False;
      endFlag := False;
    end;
  end;
end;

function NumOfWordsAndNum(str: string): integer;
begin
  insert(' ', str, 1);
  str := str + ' ';
  result := 0;
  for var i := 1 to length(str) - 1 do
  begin
    if ((not engLettersAndNum.contains(str[i])) and engLettersAndNum.contains(str[i+1])) then
      result := result + 1;
  end;
end;

function ListOfWordsAndNum(str: string): SArr;
var
  startPos, endPos, wordNow, CountWords: integer;
  startFlag, endFlag: boolean;
  word: string;

begin
  insert(' ', str, 1);
  str := str + ' ';
  CountWords:= NumOfWordsAndNum(str);
  setLength(result, CountWords);
  startFlag := False;
  endFlag := False;
  wordNow := 0;
  for var i := 1 to length(str) - 1 do
  begin
    if ((not engLettersAndNum.contains(str[i])) and engLettersAndNum.contains(str[i+1])) then
    begin
      startPos := i + 1;
      startFlag := True;
    end;
    if (engLettersAndNum.contains(str[i]) and (not engLettersAndNum.contains(str[i+1]))) then
    begin
      endPos := i;
      endFlag := True;
    end;
    if (startFlag and endFlag) then
    begin
      word:= copy(str, startPos, endPos - startPos + 1);
      result[wordNow] := word;
      wordNow := wordNow + 1;
      startFlag := False;
      endFlag := False;
    end;
  end;
end;

end.
