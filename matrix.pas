unit matrix;


interface

    uses crt;

    // Largeur maximale d'une matrice. Elle peut donc contenir un minimum de MAX_WIDTH*MAX_WIDTH éléments.
    const MAX_WIDTH = 10;

    // Structure qui représente une matrice carrée.
    type SquareMatrix = object
        private
            // Largeur et hauteur de la matrice.
            size: integer;
            // Valeurs de la matrice indexées par x puis y, de 0 à size-1.
            data: array[0..MAX_WIDTH-1, 0..MAX_WIDTH-1] of Integer;

        public
            constructor init(demanded_size: integer);
            procedure set_value(x, y: Integer; value: Integer);
            procedure display();
            procedure apply_gauss();
    end;

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
                data[x, y] := 0;
    end;

    // Modifie la valeur d'une case de la matrice.
    procedure SquareMatrix.set_value(x, y: Integer; value: Integer);
    begin
        if (x < 0) or (x >= size) or (y < 0) or (y >= size) then begin
            writeln('Error: the coordinates are out of the matrix.');
            halt;
        end;
        data[x, y] := value;
    end;
	
    // Affiche la matrice sur la sortie standard.
    procedure SquareMatrix.display();
    var x, y: Integer;
    begin
        write('┌');
        for x := 0 to size-1 do
            write('   ');
        writeln('  ┐');
        for y := 0 to size-1 do begin
            write('│');
            for x := 0 to size-1 do begin
                write(data[x, y]:3);
            end;
            writeln('  │');
        end;
        write('└');
        for x := 0 to size-1 do
            write('   ');
        writeln('  ┘');
    end;

    // Applique l'algorithme du pivot de Gauss à la matrice.
    procedure SquareMatrix.apply_gauss();
    var step, y, n, x: Integer;
    var char_pos: Integer;
    begin
        for step := 0 to size-2 do begin
            writeln('Step ', step, ' :');
            self.display();
            char_pos := WhereY();

            for y := step+1 to size-1 do begin
                // On veut obtenir `data[step][y] = 0` en ajoutant `n` multiples de la ligne `step`
                // On doit donc résoudre `data[step][y] + n * data[step][step] = 0`
                if data[step, step] = 0 then begin
                    writeln('FATAL: the matrix is not invertible.');
                    halt;
                end;
                n := -data[step, y] div data[step, step];

                // Log
                GotoXY(7+3*size, char_pos - size - 1 + y);
                write('L', y, ' ← L', y, ' + ', n, ' * L', step);

                // Application
                for x := step to size-1 do
                    data[x, y] := data[x, y] + n * data[x, step];
            end;
            GotoXY(1, char_pos);
        end;
        writeln('Fini:');
        self.display();
    end;
end.

