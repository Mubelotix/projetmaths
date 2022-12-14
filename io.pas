unit io;

interface

uses num, matrix, sysutils;

// Ce qui est lu en entrée du programme
type InputData = record
    a: SquareMatrix;
    b: ColumnMatrix;
end;

// Fonction qui lit les données d'entrée
function read_input_data(): InputData;

/// Procédure qui écrit les données de sortie
procedure output_data(data: InputData);

implementation

function read_integer(line: String; var cursor: Integer): Int64;
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
var num, den: Int64;
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
    cursor: Integer;
    x, y: Integer;
begin
    readln(size);
    read_input_data.a.init(size);
    read_input_data.b.init(size);

    for y := 0 to size - 1 do begin
        readln(line);
        cursor := 1;
        for x := 0 to size - 1 do
            read_input_data.a.set_value(x, y, read_number(line, cursor));
    end;

    for y := 0 to size - 1 do begin
        readln(line);
        cursor := 1;
        read_input_data.b.set_value(y, read_number(line, cursor));
    end;
end;

procedure output_data(data: InputData);
var size, x, y: Integer;
begin
    size := data.a.get_size();
    writeln(size);
    for y := 0 to size - 1 do begin
        for x := 0 to size - 1 do
            write(data.a.get_value(x, y).to_string(), ' ');
        writeln();
    end;
    for y := 0 to size - 1 do
        writeln(data.b.get_value(y).to_string());
end;

end.
