unit matrix;


interface

    uses crt, fraction, strutils, termio;

    // Largeur maximale d'une matrice. Elle peut donc contenir un minimum de MAX_WIDTH*MAX_WIDTH éléments.
    const MAX_WIDTH = 10;

    // Structure qui représente une matrice carrée.
    type SquareMatrix = object
        private
            // Largeur et hauteur de la matrice.
            size: integer;
            // Valeurs de la matrice indexées par x puis y, de 0 à size-1.
            data: array[0..MAX_WIDTH-1, 0..MAX_WIDTH-1] of Number;

        public
            constructor init(demanded_size: integer);
            function get_size(): Integer;
            procedure set_fraction(x, y: Integer; frac: Number);
            function get_fraction(x, y: Integer): Number;
            procedure set_value(x, y: Integer; value: Integer);
            procedure display();
    end;

    type ColumnMatrix = object
        private
            // Hauteur de la matrice colonne.
            size: integer;
            // Valeurs de la matrice indexées par y, de 0 à size-1.
            data: array[0..MAX_WIDTH-1] of Number;

        public
            constructor init(demanded_size: integer);
            function get_size(): Integer;
            procedure set_fraction(y: Integer; frac: Number);
            function get_fraction(y: Integer): Number;
            procedure set_value(y: Integer; value: Integer);
            procedure display();
    end;

    procedure apply_gauss(var a: SquareMatrix; var b: ColumnMatrix);

implementation
    // Initialise une matrice carrée de largeur et hauteur demanded_size.
    // Arrête le programme si la taille est invalide (inférieure à 1 ou supérieure à MAX_WIDTH).
    constructor SquareMatrix.init(demanded_size: integer);
    var x, y: Integer;
    begin
        // Check size
        if demanded_size > MAX_WIDTH then begin
            writeln('Error: the size of the matrix is too big.');
            halt;
        end;
        if demanded_size < 1 then begin
            writeln('Error: the size of the matrix is too small.');
            halt;
        end;
        
        // Init values
        size := demanded_size;
        for x := 0 to size-1 do
            for y := 0 to size-1 do begin
                data[x][y].num := 0;
                data[x][y].den := 1;
            end;
    end;
    constructor ColumnMatrix.init(demanded_size: integer);
    var y: Integer;
    begin
        // Check size
        if demanded_size > MAX_WIDTH then begin
            writeln('Error: the size of the matrix is too big.');
            halt;
        end;
        if demanded_size < 1 then begin
            writeln('Error: the size of the matrix is too small.');
            halt;
        end;
        
        // Init values
        size := demanded_size;
        for y := 0 to size-1 do begin
            data[y].num := 0;
            data[y].den := 1;
        end;
    end;

    // Retourne la taille
    function SquareMatrix.get_size(): Integer;
    begin
        get_size := size;
    end;
    function ColumnMatrix.get_size(): Integer;
    begin
        get_size := size;
    end;

    // Modifie la valeur d'une case de la matrice.
    procedure SquareMatrix.set_fraction(x, y: Integer; frac: Number);
    begin
        if (x < 0) or (x >= size) or (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[x][y] := frac;
    end;
    procedure ColumnMatrix.set_fraction(y: Integer; frac: Number);
    begin
        if (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[y] := frac;
    end;

    // Retourne la valeur d'une case de la matrice.
    function SquareMatrix.get_fraction(x, y: Integer): Number;
    begin
        if (x < 0) or (x >= size) or (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        get_fraction := data[x][y];
    end;
    function ColumnMatrix.get_fraction(y: Integer): Number;
    begin
        if (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        get_fraction := data[y];
    end;

    // Modifie la valeur d'une case de la matrice.
    procedure SquareMatrix.set_value(x, y: Integer; value: Integer);
    begin
        if (x < 0) or (x >= size) or (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[x][y].init_int(value);
    end;
    procedure ColumnMatrix.set_value(y: Integer; value: Integer);
    begin
        if (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[y].init_int(value);
    end;
	
    // Affiche la matrice sur la sortie standard.
    procedure SquareMatrix.display();
    var x, y: Integer;
    begin
        write('┌');
        for x := 0 to size-1 do
            write('    ');
        writeln('  ┐');
        for y := 0 to size-1 do begin
            write('│');
            for x := 0 to size-1 do begin
                write(padleft(data[x][y].to_string(), 3), ' ');
            end;
            writeln('  │');
        end;
        write('└');
        for x := 0 to size-1 do
            write('    ');
        writeln('  ┘');
    end;
    procedure ColumnMatrix.display();
    var y: Integer;
    begin
        writeln('┌      ┐');
        for y := 0 to size-1 do
            writeln('│', padleft(data[y].to_string(), 3), '   │');
        writeln('└      ┘');
    end;

    // Applique l'algorithme du pivot de Gauss à la matrice.
    procedure apply_gauss(var a: SquareMatrix; var b: ColumnMatrix);
    var step, y, x: Integer;
    var n: Number;
    var char_pos: Integer;
    begin
        for step := 0 to a.size-2 do begin
            // Log si dans le terminal
            if isatty(output)=1 then begin
                writeln('Step ', step, ' :');
                b.display();
                a.display();
                char_pos := WhereY();
            end;

            for y := step+1 to a.size-1 do begin
                // On veut obtenir `data[step][y] = 0` en ajoutant `n` multiples de la ligne `step`
                // On doit donc résoudre `data[step][y] + n * data[step][step] = 0`
                if a.data[step][step].num = 0 then begin
                    writeln('FATAL: the matrix is not invertible.');
                    halt;
                end;
                n := a.data[step][y].divide(a.data[step][step]);

                // Log si dans le terminal
                if isatty(output)=1 then GotoXY(7+4*a.size, char_pos - a.size - 1 + y);
                if isatty(output)=1 then write('L', y+1, ' ← L', y+1, ' - ', n.to_string(), ' * L', step+1);

                // Application
                for x := step to a.size-1 do
                    a.data[x][y] := a.data[x][y].substract(n.multiply(a.data[x][step]));
                b.data[y] := b.data[y].substract(n.multiply(b.data[step]));
            end;
            if isatty(output)=1 then GotoXY(1, char_pos);
        end;
    end;
end.

