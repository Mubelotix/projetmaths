program linear_equation_solver;

uses matrix, fraction, sysutils, crt, io;

var input_data: InputData;

begin
    input_data := read_input_data();
    ClrScr();
    apply_gauss(input_data.a, input_data.b);
end.
