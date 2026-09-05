onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_TX_tb/P_DATA
add wave -noupdate /UART_TX_tb/DATA_VALID
add wave -noupdate /UART_TX_tb/PAR_EN
add wave -noupdate /UART_TX_tb/PAR_TYP
add wave -noupdate /UART_TX_tb/CLK
add wave -noupdate /UART_TX_tb/RST
add wave -noupdate /UART_TX_tb/TX_OUT
add wave -noupdate /UART_TX_tb/Busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {202125 ps}
