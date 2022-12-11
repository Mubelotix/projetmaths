unit matrix;


interface

    uses crt, num, strutils, termio;

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
            procedure set_value(x, y: Integer; value: Number);
            function get_value(x, y: Integer): Number;
            procedure set_value_int(x, y: Integer; value: Integer);
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
            procedure set_value(y: Integer; value: Number);
            function get_value(y: Integer): Number;
            procedure set_value_int(y: Integer; value: Integer);
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
            for y := 0 to size-1 do
                data[x][y].init_zero();
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
        for y := 0 to size-1 do
            data[y].init_zero();
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
    procedure SquareMatrix.set_value(x, y: Integer; value: Number);
    begin
        if (x < 0) or (x >= size) or (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[x][y] := value;
    end;
    procedure ColumnMatrix.set_value(y: Integer; value: Number);
    begin
        if (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[y] := value;
    end;

    // Retourne la valeur d'une case de la matrice.
    function SquareMatrix.get_value(x, y: Integer): Number;
    begin
        if (x < 0) or (x >= size) or (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        get_value := data[x][y];
    end;
    function ColumnMatrix.get_value(y: Integer): Number;
    begin
        if (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        get_value := data[y];
    end;

    // Modifie la valeur d'une case de la matrice.
    procedure SquareMatrix.set_value_int(x, y: Integer; value: Integer);
    begin
        if (x < 0) or (x >= size) or (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[x][y].init_int(value);
    end;
    procedure ColumnMatrix.set_value_int(y: Integer; value: Integer);
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
            write('      ');
        writeln('  ┐');
        for y := 0 to size-1 do begin
            write('│');
            for x := 0 to size-1 do begin
                write(padleft(data[x][y].to_string(), 5), ' ');
            end;
            writeln('  │');
        end;
        write('└');
        for x := 0 to size-1 do
            write('      ');
        writeln('  ┘');
    end;
    procedure ColumnMatrix.display();
    var y: Integer;
    begin
        writeln('┌        ┐');
        for y := 0 to size-1 do
            writeln('│', padleft(data[y].to_string(), 5), '   │');
        writeln('└        ┘');
    end;

    // Applique l'algorithme du pivot de Gauss à la matrice.
    procedure apply_gauss(var a: SquareMatrix; var b: ColumnMatrix);
    var step, y, x, y2: Integer;
    var pivot: Number;
    var n: Number;
    var char_pos: Integer;
    var non_zero_line: Integer;
    begin
        step := 0;
        while step <= a.size-2 do begin
            // Log si dans le terminal
            if isatty(output)=1 then begin
                writeln('Step ', step, ' :');
                b.display();
                a.display();
                char_pos := WhereY();
            end;

            // Vérifions que le pivot n'est pas nul
            pivot := a.data[step][step];
            if pivot.is_zero() then begin
                // Trouvons une ligne au pivot non nul pour remplacer celle-ci
                non_zero_line := -1;
                for y2 := step+1 to a.size-1 do
                    if not a.data[step][y2].is_zero() then
                        non_zero_line := y2;

                // Si aucune n'est trouvée, on peut juste continuer
                if non_zero_line = -1 then begin
                    step := step + 1;
                    continue;
                end;
                
                // Sinon on permute les lignes step et non_zero_line
                if isatty(output)=1 then begin
                    GotoXY(7+6*a.size, char_pos - a.size - 1 + step);
                    write('L', step + 1, ' ↔ L', non_zero_line + 1);
                end;
                for x := 0 to a.size-1 do begin
                    n := a.data[x][step];
                    a.data[x][step] := a.data[x][non_zero_line];
                    a.data[x][non_zero_line] := n;
                end;
                n := b.data[step];
                b.data[step] := b.data[non_zero_line];
                b.data[non_zero_line] := n;

                // On recommence l'étape step mais le pivot ne sera plus nul
                continue;
            end;

            for y := step+1 to a.size-1 do begin
                // On veut obtenir `data[step][y] = 0` en ajoutant `n` multiples de la ligne `step`
                // On doit donc résoudre `data[step][y] + n * data[step][step] = 0`
                n := a.data[step][y].divide(pivot);

                // Log si dans le terminal
                if isatty(output)=1 then begin
                    GotoXY(7+6*a.size, char_pos - a.size - 1 + y);
                    write('L', y+1, ' ← L', y+1, ' - ', n.to_string(), ' * L', step+1);
                end else
                    n.to_string(); // Utile car déclenche une simplification avec PGCD sur les rationnels ce qui réduit le risque de dépassement de capacité

                // Application
                for x := step to a.size-1 do
                    a.data[x][y] := a.data[x][y].substract(n.multiply(a.data[x][step]));
                b.data[y] := b.data[y].substract(n.multiply(b.data[step]));
            end;
            if isatty(output)=1 then GotoXY(1, char_pos);
            
            step := step + 1;
        end;
    end;
end.

