unit fraction;

interface
    uses sysutils;

    type Number = object
        public
            value: Double;
            constructor init(new_num, new_den: Int64);
            constructor init_zero();
            constructor init_int(new_num: Int64);
            function to_string(): String;
            function is_zero(): Boolean;
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

constructor Number.init_int(new_num: Int64);
begin
    self.value := new_num;
end;

constructor Number.init(new_num, new_den: Int64);
begin
    self.value := new_num / new_den;
end;

function Number.to_string(): String;
begin
    to_string := FloatToStr(self.value);
end;

function Number.is_zero(): Boolean;
begin
    is_zero := self.value = 0;
end;

function Number.invert(): Number;
begin
    invert.value := 1 / self.value;
end;

function Number.opposite(): Number;
begin
    opposite.value := -self.value;
end;

function Number.add(other: Number): Number;
begin
    add.value := self.value + other.value;
end;

function Number.substract(other: Number): Number;
begin
    substract.value := self.value - other.value;
end;

function Number.multiply(other: Number): Number;
begin
    multiply.value := self.value * other.value;
end;

function Number.divide(other: Number): Number;
begin
    divide.value := self.value / other.value;
end;

end.
