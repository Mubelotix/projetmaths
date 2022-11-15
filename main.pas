program linear_equation_solver;

uses matrix, fraction;

var a: SquareMatrix;
var b: ColumnMatrix;

begin
    a.init(3);
    a.set_value(0, 0, 1);
    a.set_value(1, 0, 2);
    a.set_value(2, 0, 3);
    a.set_value(0, 1, 4);
    a.set_value(1, 1, 5);
    a.set_value(2, 1, 6);
    a.set_value(0, 2, 7);
    a.set_value(1, 2, 8);
    a.set_value(2, 2, 9);
    a.display();
    b.init(3);
    apply_gauss(a, b);
end.
