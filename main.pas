program linear_equation_solver;

uses matrix, fraction;

var mat: SquareMatrix;

begin
    mat.init(3);
    mat.set_value(0, 0, 1);
    mat.set_value(1, 0, 2);
    mat.set_value(2, 0, 3);
    mat.set_value(0, 1, 4);
    mat.set_value(1, 1, 5);
    mat.set_value(2, 1, 6);
    mat.set_value(0, 2, 7);
    mat.set_value(1, 2, 8);
    mat.set_value(2, 2, 9);
    mat.display();
    mat.apply_gauss();
end.
