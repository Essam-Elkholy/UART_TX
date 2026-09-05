module UART_TX(
    input  wire [7:0] P_DATA,  //Parallel Data In
    input  wire       DATA_VALID,
    input  wire       PAR_EN, PAR_TYP,
    input  wire       CLK,
    input  wire       RST,

    output wire       TX_OUT,  // Serial Data Out
    output wire       Busy
);
    
// Internal Signals

wire [1:0] mux_sel;
wire       ser_en;
wire       ser_done;
wire       ser_data;
wire       par_bit;

wire       data_accept;
reg  [7:0] data_reg;

// Blocks Instance
// FSM
FSM U_FSM (
    .DATA_VALID (data_accept),
    .PAR_EN     (PAR_EN),
    .ser_done   (ser_done),
    .ser_en     (ser_en),
    .mux_sel    (mux_sel),
    .Busy       (Busy),
    .CLK        (CLK),
    .RST        (RST)
);

// Serializer
serializer U_serializer (
    .P_DATA     (data_reg),
    .ser_done   (ser_done),
    .ser_en     (ser_en),
    .ser_data   (ser_data),
    .CLK        (CLK),
    .RST        (RST)
);

// Parity Calculator
parity_Calc U_parity_Calc (
    .P_DATA     (P_DATA),
    .DATA_VALID (data_accept),
    .PAR_TYP    (PAR_TYP),
    .par_bit    (par_bit),
    .CLK        (CLK),
    .RST        (RST)
);

// MUX
MUX U_MUX (
    .mux_sel    (mux_sel),
    .ser_data   (ser_data),
    .par_bit    (par_bit),
    .TX_OUT     (TX_OUT)
);

// Accept data only when UART_TX is IDLE
assign data_accept = DATA_VALID && !Busy;

// Save data of the beginnig of new frame
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        data_reg <= 8'b0;
    end
    else if (data_accept) begin
        data_reg <= P_DATA;
    end
end

endmodule