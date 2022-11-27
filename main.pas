program linear_equation_solver;

uses matrix, fraction, sysutils, crt, termio, io;

var input_data: InputData;

begin
    input_data := read_input_data();
    ClrScr();
    apply_gauss(input_data.a, input_data.b);

    // Affiche les résultats ou les retourne dans le fichier
    if isatty(output)=1 then begin
        writeln('Terminé!');
        input_data.a.display();
        input_data.b.display();
    end else
        output_data(input_data);
end.
