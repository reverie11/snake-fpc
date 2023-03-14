program snake;
uses crt, Sysutils, unix;


const
        xx=80;
        yy=25;

var
        x,y,n,laenge,x1,y1,m, tt                                        : Integer;
        eingabe,k,appleskin,fenceskin,restart, choice,choice2           : char;
        gameover, newgame                                               : boolean;
        xy                                                              : Array[1..xx,1..yy] of char;
        xmerk, ymerk                                                    : Array[0..1200] of Integer;

procedure feld;
begin
        for y:=1 to yy do
                for x:=1 to xx do
                begin
                        xy[x,y]:=' ';
                        write(xy[x,y]);
                        gotoxy(x,y);
                        textbackground(black);
                end;

        for x:=1 to xx do
        begin
                gotoxy(x,1);
                write(fenceskin);
                gotoxy(x,yy);
                write(fenceskin);
        end;

        for y:=2 to yy-1 do
        begin
                gotoxy(1,y);
                write(fenceskin);
                gotoxy(xx,y);
                write(fenceskin);
        end;
end;

procedure scoretable;
begin
        gotoxy(xx+5,5);
        write('Snake by Frederick F. 0.');
        gotoxy(xx+5,7);
        write('Length = ', laenge);
        if tt<=100 then
        begin
                gotoxy(xx+5, 9);
                write('speed (MAX) = ',305-tt);
        end
        else
        begin
        gotoxy(xx+5, 9);
        write('speed = ', 305-tt);
end;
end;


procedure ausdemfeld;
begin
        if (x<=1) or (x>=xx) or (y<=1) or (y>=yy) then gameover:=true;
end;


procedure erase;
begin
        gotoxy(xmerk[0],ymerk[0]);
        xy[xmerk[0],ymerk[0]]:=' ';
        write(xy[xmerk[0],ymerk[0]]);
end;

procedure apple;
var
        i,j,color,z,q   :Integer;
begin
        q:=0;
        repeat
        q:=q+1;
        z:=2;
        i:=random(xx-2)+2;
        j:=random(yy-2)+2;
        if xy[i,j]=' ' then
        begin
                xy[i,j]:=appleskin;
                gotoxy(i,j);
                color:=random(4);
                textcolor(9+color);
                write(xy[i,j]);
        end;
        textcolor(white);
        until q=z;
end;

procedure eat;
begin
        if xy[x,y]=appleskin then
        begin
                if tt>=200 then tt:=tt-10
                else if (tt>100) and (tt<200) then tt:=tt-5
                else if tt<=100 then tt:=tt;
                laenge:=laenge+1;
                apple;
                scoretable;
        end;

end;

procedure cannibal;
begin
        if (xy[x,y]='>') or (xy[x,y]='<') or (xy[x,y]='V') or (xy[x,y]='^') then gameover:=true;
end;

procedure move;
begin
        eat;
        cannibal;
        xy[x,y]:=k;
        gotoxy(x,y);
        write(xy[x,y]);
        sleep(tt);

end;

procedure gamemenu;
var     j, i    :integer;
        custom  :char;
begin
        appleskin:='O';
        fenceskin:='X';
        j:=4;
        i:=6;
        repeat
        clrscr;
        textcolor(11);
        feld;
        textcolor(14);
        gotoxy(i,j-1);
        writeln('SNAKE by Frederick F. O.');
        gotoxy(i,j+1);
        textcolor(13);
        writeln('MAIN MENU');
        textcolor(12);
        gotoxy(i, j+2);
        writeln('1. Play Game');
        gotoxy(i, j+3);
        writeln('2. Change the Style of the Apple, current Style: ', appleskin);
        gotoxy(i,j+4);
        writeln('3. Change the Style of the Fence, current Style: ', fenceskin);
        gotoxy(i, j+5);
        writeln('0. Exit Game');
        gotoxy(i, j+6);
        writeln('Enter <Number> to choose');
        gotoxy(i, j+7);
        readln(choice);

        case choice of
        '1': begin
                gotoxy(i,j+9);
                writeln('Press <ENTER> to start the game');
                gotoxy(i,j+10);
                readln;
                end;
        '2': begin
                gotoxy(i,j+9);
                writeln('Choose the Style of the Apple');
                gotoxy(i,j+10);
                writeln('1. O');
                gotoxy(i,j+11);
                writeln('2. @');
                gotoxy(i,j+12);
                writeln('3. $');
                gotoxy(i,j+13);
                writeln('4. Q');
                gotoxy(i,j+14);
                writeln('5. Custom skin ');
                gotoxy(i,j+15);
                readln(choice2);
                        case choice2 of
                        '1': appleskin:='O';
                        '2': appleskin:='@';
                        '3': appleskin:='$';
                        '4': appleskin:='Q';
                        '5': begin
                                gotoxy(i+10,j+14);
                                writeln('>> Enter Any Char');
                                gotoxy(i+10,j+15);
                                writeln('ACHTUNG!!! [verboten:"V","^","<",">"]');
                                gotoxy(i+10,j+16);
                                write(' = ');
                                readln(custom);
                                appleskin:=custom;
                                end;
                        end;

                end;
        '3': begin
                gotoxy(i,j+9);
                writeln('Choose the Style of the Fence');
                gotoxy(i,j+10);
                writeln('1. X');
                gotoxy(i,j+11);
                writeln('2. #');
                gotoxy(i,j+12);
                writeln('3. =');
                gotoxy(i,j+13);
                writeln('4. +');
                gotoxy(i,j+14);
                writeln('5. Custom skin');
                gotoxy(i,j+15);
                readln(choice2);
                        case choice2 of
                        '1': fenceskin:='X';
                        '2': fenceskin:='#';
                        '3': fenceskin:='=';
                        '4': fenceskin:='+';
                        '5': begin
                                gotoxy(i+10,j+14);
                                writeln('>> Enter Any Char');
                                gotoxy(i+10,j+15);
                                write(' = ');
                                readln(custom);
                                fenceskin:=custom;
                                end;
                        end;
                end;
        '0': begin
                gameover:=true;
                newgame:=false;
                end;
        end;
        {writeln('input = ',choice);
        readln;}
        textcolor(11);
        until ((choice='0') or (choice='1'))=true;
        clrscr;
end;

procedure endgame;
var i,j,q,z,color       : integer;
begin

q:=0;
        repeat
        delay(1);
        q:=q+1;
        z:=3000;
        i:=random(xx-2)+2;
        j:=random(yy-2)+2;
                xy[i,j]:=appleskin;
                gotoxy(i,j);
                color:=random(4);
                textcolor(9+color);
                write(xy[i,j]);
        textcolor(white);
        until q=z;

end;


begin
newgame:=true;
if newgame=true then
repeat
begin

        gameover:=false;
        gamemenu;
        fpsystem('tput civis');
        tt:=300;
        laenge:=4;
        feld;
        scoretable;
        apple;
        x:= (xx div 2)-(laenge);
        y:= yy div 2;
        gotoxy(x,y);
        n:=0;
        repeat
                xmerk[n]:=x;
                ymerk[n]:=y;
                xy[x,y]:='>';
                write(xy[x,y]);
                x:=x+1;
                gotoxy(x,y);
                n:=n+1;
        until n=laenge;
        if gameover=false then
        repeat
                eingabe:=readkey;
                if eingabe = 'w' then
                begin
                        k:='^';
                        y1:=-1;
                        x1:=0;
                end;
                if eingabe = 'a' then
                begin
                        k:='<';
                        y1:=0;
                        x1:=-1;
                end;
                if eingabe = 's' then
                begin
                        k:='V';
                        y1:=1;
                        x1:=0;
                end;
                if eingabe = 'd' then
                begin
                        k:='>';
                        y1:=0;
                        x1:=1;
                end;
                repeat
                        erase;
                        y:=y+y1;
                        x:=x+x1;
                        move;
                        xmerk[n]:=x;
                        ymerk[n]:=y;
                        n:=laenge;
                        for m:=0 to n do
                        begin
                        xmerk[m]:=xmerk[m+1];
                        ymerk[m]:=ymerk[m+1];
                        end;
                        ausdemfeld;
                until keypressed or (gameover=true);
                if eingabe = 'x' then gameover:= true;

        until gameover=true;
        textcolor(11);
        textbackground(black);
        fpsystem('tput cnorm');
        if newgame=true then
        begin

                endgame;
                delay(200);
                gotoxy(1, yy div 2);
                writeln('                                        ');
                writeln('       SNAKE by Frederick F. O        ');
                writeln('       GAME OVER                      ');
                writeln('       SNAKEs Length = ',laenge,'              ');
                writeln('       SNAKEs Speed = ',305-tt,'               ');
                writeln('       enter "x" to quit game         ');
                writeln('       enter any button to retry      ');
                writeln('                                        ');
                gotoxy(5,yy div 2 +7);
                readln(restart);
                clrscr;
                if restart='x' then newgame:=false;
        end;
end;
until newgame=false;
clrscr;
end.
