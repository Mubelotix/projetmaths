// Ce fichier contient l'implémentation de l'abstraction Number utilisant des nombres rationnels.
// Pour que cette implémentation soit utilisée, veuillez créer un lien symbolique nommé "num.pas" vers ce fichier :
//
// rm num.pas && ln -s num_rat.pas num.pas
// 
// Le programme devra être recompilé.

unit num;

interface
    uses sysutils;

    type Number = object
        public
            num: Int64;
            den: Int64;
            constructor init(new_num, new_den: Int64);
            constructor init_zero();
            constructor init_int(new_num: Int64);
            procedure beautify();
            function to_string(): String;
            function is_zero(): Boolean;
            function invert(): Number;
            function opposite(): Number;
            function add(other: Number): Number;
            function substract(other: Number): Number;
            function multiply(other: Number): Number;
            function divide(other: Number): Number;
    end;

    function greatestCommonDivisor(a, b: Int64): Int64;
implementation

constructor Number.init_zero();
begin
    self.init_int(0);
end;

constructor Number.init_int(new_num: Int64);
begin
    self.init(new_num, 1);
end;

constructor Number.init(new_num, new_den: Int64);
begin
    self.num := new_num;
    self.den := new_den;
end;

// Took from https://wiki.freepascal.org/Greatest_common_divisor
function greatestCommonDivisor(a, b: Int64): Int64;
begin
    // only works with positive integers
    if (a < 0) then a := -a;
    if (b < 0) then b := -b;
    // don't enter loop, since subtracting zero won't break condition
    if (a = 0) then exit(b);
    if (b = 0) then exit(a);
    while not (a = b) do begin
        if (a > b) then
            a := a - b
        else
            b := b - a;
    end;
    greatestCommonDivisor := a;
end;

procedure Number.beautify();
var gcd: Int64;
begin
    if self.num = 0 then
        self.den := 1;
    if self.den < 0 then begin
        self.num := -self.num;
        self.den := -self.den;
    end;
    gcd := greatestCommonDivisor(self.num, self.den);
    if gcd <> 1 then begin
        self.num := self.num div gcd;
        self.den := self.den div gcd;
    end;
end;

function Number.to_string(): String;
begin
    self.beautify();
    to_string := IntToStr(self.num);
    if (self.den <> 1) AND (self.num <> 0) then begin
        to_string := to_string + '/';
        to_string := to_string + IntToStr(self.den);
    end;
end;

function Number.is_zero(): Boolean;
begin
    is_zero := self.num = 0;
end;

function Number.invert(): Number;
begin
    invert.num := self.den;
    invert.den := self.num;
end;

function Number.opposite(): Number;
begin
    opposite.num := -self.num;
    opposite.den := self.den;
end;

function Number.add(other: Number): Number;
begin
    if self.den = other.den then begin
        add.num := self.num + other.num;
        add.den := self.den;
    end else begin
        add.num := self.num * other.den + other.num * self.den;
        add.den := self.den * other.den;
    end;
end;

function Number.substract(other: Number): Number;
begin
    other.num := -other.num;
    substract := self.add(other);
end;

function Number.multiply(other: Number): Number;
begin
    multiply.num := self.num * other.num;
    multiply.den := self.den * other.den;
end;

function Number.divide(other: Number): Number;
begin
    divide := self.multiply(other.invert());
end;

end.
