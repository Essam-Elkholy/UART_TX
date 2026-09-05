`timescale 1ns/1ps

module UART_TX_tb;

reg  [7:0] P_DATA;
reg        DATA_VALID;
reg        PAR_EN;
reg        PAR_TYP;
reg        CLK;
reg        RST;

wire TX_OUT;
wire Busy;

UART_TX DUT (
    .P_DATA     (P_DATA),
    .DATA_VALID (DATA_VALID),
    .PAR_EN     (PAR_EN),
    .PAR_TYP    (PAR_TYP),
    .CLK        (CLK),
    .RST        (RST),
    .TX_OUT     (TX_OUT),
    .Busy       (Busy)
);

always #2.5 CLK = ~CLK;

initial begin
    $monitor(
        "Time=%0t | RST=%b | P_DATA=%h | VALID=%b | PAR_EN=%b | PAR_TYP=%b | Busy=%b | TX_OUT=%b",
        $time,
        RST,
        P_DATA,
        DATA_VALID,
        PAR_EN,
        PAR_TYP,
        Busy,
        TX_OUT
    );
end

initial begin
    CLK        = 1'b0;
    RST        = 1'b0;
    P_DATA     = 8'b0;
    DATA_VALID = 1'b0;
    PAR_EN     = 1'b0;
    PAR_TYP    = 1'b0;

    #10;
    RST = 1'b1;


    // Test 1: No parity
    @(negedge CLK);
    P_DATA     = 8'hA5;
    PAR_EN     = 1'b0;
    PAR_TYP    = 1'b0;
    DATA_VALID = 1'b1;

    @(negedge CLK);
    DATA_VALID = 1'b0;

    wait (Busy == 1'b0);


    // Test 2: Even parity
    @(negedge CLK);
    P_DATA     = 8'hF3;
    PAR_EN     = 1'b1;
    PAR_TYP    = 1'b0;
    DATA_VALID = 1'b1;

    @(negedge CLK);
    DATA_VALID = 1'b0;

    wait (Busy == 1'b0);


    // Test 3: Odd parity
    @(negedge CLK);
    P_DATA     = 8'hF3;
    PAR_EN     = 1'b1;
    PAR_TYP    = 1'b1;
    DATA_VALID = 1'b1;

    @(negedge CLK);
    DATA_VALID = 1'b0;

    wait (Busy == 1'b0);

    #10;
    $stop;
end

endmodule