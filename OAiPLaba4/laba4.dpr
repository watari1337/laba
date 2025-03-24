program laba4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
    N = 8;

type
    Tdesk = array[1..N] of array[1..N] of integer;

var
    iter: integer = 0;
    myDesk: Tdesk;    

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

procedure BinominalCoificent();
begin

end;

begin
  queen8(myDesk, 1);

  readln;
  readln;
end.
