unit matrix;


interface

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

end.

