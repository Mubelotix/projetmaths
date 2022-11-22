program linear_equation_solver;

uses matrix, fraction, sysutils;

var a: SquareMatrix;
var b: ColumnMatrix;

type InputData = record
    a: SquareMatrix;
    b: ColumnMatrix;
end;

function read_integer(line: String; var cursor: Integer): Integer;
var start, len: Integer;
    str: String;
begin
    // Ignore tous les espaces
    while (cursor <= length(line)) and (line[cursor] = ' ') do
        cursor := cursor + 1;
    // Vérifie qu'on ne manque pas de caractères
    if cursor > length(line) then begin
        writeln('Nombre manquant');
        exit;
    end;
    // On lit désormais le numérateur, collectons tous les caractères qui composent le numérateur (jusqu'au prochain espace ou barre de division)
    start := cursor;
    while (cursor <= length(line)) and (line[cursor] <> ' ') and (line[cursor] <> '/') do
        cursor := cursor + 1;
    len := cursor - start;
    // On vérifie que le numérateur contient quelquechose
    if len = 0 then begin
        writeln('Nombre vide');
        exit;
    end;
    // On parse le numérateur en nombre
    str := copy(line, start, len);
    read_integer := StrToInt(str);
    // Ignore tous les espaces
    while (cursor <= length(line)) and (line[cursor] = ' ') do
        cursor := cursor + 1;
end;

function read_number(line: String; var cursor: Integer): Number;
var num, den: Integer;
begin
    // Lit le numérateur
    num := read_integer(line, cursor);

    // Termine si le dénominateur n'est pas présent ou sinon passe le /
    if (cursor > length(line)) or (line[cursor] <> '/') then begin
        read_number.init_int(num);
        exit;
    end else
        cursor := cursor + 1;

    // Lit le dénominateur
    den := read_integer(line, cursor);
    read_number.init(num, den);
end;

function read_input_data(): InputData;
var line: String;
    size: Integer;
    cursor, start, len: Integer;
    x, y: Integer;
    str: String;
    num, den: Integer;
    fraction: Number;
begin
    readln(size);
    read_input_data.a.init(size);
    read_input_data.b.init(size);

    for y := 0 to size - 1 do begin
        readln(line);
        cursor := 1;
        for x := 0 to size - 1 do
            read_input_data.a.set_fraction(x, y, read_number(line, cursor));
    end;

    read_input_data.a.display();
end;

begin
    read_input_data();
    exit;

    a.init(3);
    a.set_value(0, 0, 1);
    a.set_value(1, 0, 2);
    a.set_value(2, 0, 2);
    a.set_value(0, 1, 1);
    a.set_value(1, 1, 3);
    a.set_value(2, 1, -2);
    a.set_value(0, 2, 3);
    a.set_value(1, 2, 5);
    a.set_value(2, 2, 8);
    a.display();

    b.init(3);
    b.set_value(0, 2);
    b.set_value(1, -1);
    b.set_value(2, 8);
    b.display();
    
    apply_gauss(a, b);
end.
