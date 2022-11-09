program linear_equation_solver;

uses matrix;

var mat: SquareMatrix;

begin
    mat.init(3);
    mat.set_value(0, 0, 1);
    mat.set_value(1, 0, 2);
    mat.set_value(2, 0, 2);
    mat.set_value(0, 1, 1);
    mat.set_value(1, 1, 3);
    mat.set_value(2, 1, -2);
    mat.set_value(0, 2, 3);
    mat.set_value(1, 2, 5);
    mat.set_value(2, 2, 8);
    mat.display();
    mat.apply_gauss();
end.
