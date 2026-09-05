transcript on

if {![file exists work]} {
    vlib work
}

vmap work work

vlog -work work FSM.v
vlog -work work MUX.v
vlog -work work parity_Calc.v
vlog -work work serializer.v
vlog -work work UART_TX.v
vlog -work work UART_TX_tb.v

vsim -voptargs=+acc work.UART_TX_tb

do wave.do

run -all
wave zoom full
