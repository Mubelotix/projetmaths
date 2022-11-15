program linear_equation_solver;

uses matrix, fraction;

var a: SquareMatrix;
var b: ColumnMatrix;

begin
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
