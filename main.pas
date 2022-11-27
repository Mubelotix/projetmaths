program linear_equation_solver;

uses matrix, fraction, sysutils, crt, termio, io;

var data: InputData;

begin
    data := read_input_data();
    ClrScr();
    apply_gauss(data.a, data.b);

    // Affiche les résultats ou les retourne dans le fichier
    if isatty(output)=1 then begin
        writeln('Terminé!');
        data.b.display();
        data.a.display();
    end else
        output_data(data);
end.
