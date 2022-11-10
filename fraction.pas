unit fraction;

interface
    uses sysutils;

    type Number = object
        public
            num: Integer;
            den: Integer;
            constructor init(new_num, new_den: Integer);
            constructor init_zero();
            constructor init_int(new_num: Integer);
            procedure beautify();
            function to_string(): String;
            function invert(): Number;
            function opposite(): Number;
            function add(other: Number): Number;
            function substract(other: Number): Number;
            function multiply(other: Number): Number;
            function divide(other: Number): Number;
    end;
implementation

constructor Number.init_zero();
begin
    self.init_int(0);
end;

constructor Number.init_int(new_num: Integer);
begin
    self.init(new_num, 1);
end;

constructor Number.init(new_num, new_den: Integer);
begin
    self.num := new_num;
    self.den := new_den;
end;

procedure Number.beautify();
begin
    if self.num = 0 then
        self.den := 1;
    if self.den < 0 then begin
        self.num := -self.num;
        self.den := -self.den;
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
