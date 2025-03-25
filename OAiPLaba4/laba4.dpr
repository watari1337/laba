program laba4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  BasicFunction in '..\BasicFunction.pas';

const
    N = 8;

type
    Tdesk = array[1..N] of array[1..N] of integer;
    TbaseArr = array of integer;

var
    iter: integer = 0;
    myDesk: Tdesk;

    M: integer;
    myArr: TbaseArr;

function isFree(desk: Tdesk; row, col: integer):boolean;
var 
    sum, i: integer;
begin
  result:= true;
  //проверка столбца
  sum:= 0;
  for i:= low(desk) to High(desk) do begin
    if (desk[i][col] = 1) then inc(sum);  
  end;
  if (sum > 1) then result:= false;

  //проверка диагоналей
  for i := 1 to N-1 do begin
    //up and left
    if ((row-i) >= 1) and ((col-i) >= 1) then begin
      if (desk[row-i][col-i] = 1) then result:= false;      
    end;

    //up and right
    if ((row-i) >= 1) and ((col+i) <= N) then begin
      if (desk[row-i][col+i] = 1) then result:= false;
    end; 

    //down and left
    if ((row+i) <= N) and ((col-i) >= 1) then begin
      if (desk[row+i][col-i] = 1) then result:= false;
    end;

    //down and right
    if ((row+i) <= N) and ((col+i) <= N) then begin
      if (desk[row+i][col+i] = 1) then result:= false;
    end;  
  end;  
end;

procedure queen8(var desk: Tdesk; row: integer);
var
    noPlace: boolean;
begin
  if (row > N) then begin
    writeln;
    inc(iter);
    writeln('situation ', iter);
    for var i := Low(desk) to High(desk) do begin
      for var j := Low(desk[i]) to High(desk[i]) do begin
        if (desk[i][j] = 0) then write('. ')
        else write('Q ');
      end;
      writeln;
    end;
  end
  else begin
    noPlace:= true;
    for var i := Low(desk[row]) to High(desk[row]) do begin
      desk[row][i]:= 1;
      if (isFree(desk, row, i)) then begin
        queen8(desk, row+1);
      end;
      desk[row][i]:= 0;
    end;
  end;
end;

function BinominalCoificent(N: integer): TbaseArr;
var
  preArr, newArr: TbaseArr;
begin
  if (N = 0) then begin
    SetLength(newArr, 1);
    newArr[0]:= 1;
    result:= newArr;
  end
  {else if (N = 1) then begin
    SetLength(newArr, 2);
    newArr[0]:= 1;
    newArr[1]:= 1;
    result:= newArr;
  end}
  else begin
    preArr:= BinominalCoificent(N-1);
    SetLength(newArr, length(preArr)+1);
    newArr[0]:= 1;
    newArr[length(newArr)-1]:= 1;
    for var i := 1 to length(preArr)-1 do begin
      newArr[i]:= preArr[i-1] + preArr[i];
    end;
    result:= newArr;
  end;
end;

begin
  queen8(myDesk, 1);

  writeln('Введите степень ');
  M:= BasicFunction.ReadInt(0, 33);

  myArr:= BinominalCoificent(M);
  writeln;
  for var i := Low(myArr) to High(myArr) do begin
    write(myArr[i], ' ');
  end;

  readln;
  readln;
end.
