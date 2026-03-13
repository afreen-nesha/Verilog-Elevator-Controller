// Code your testbench here

`timescale 1ns/1ps

module elevator_tb;

reg clk;
reg reset;
reg [2:0] request;

wire [1:0] floor;
wire door_open;
wire direction;

elevator_controller uut(
    .clk(clk),
    .reset(reset),
    .request(request),
    .floor(floor),
    .door_open(door_open),
    .direction(direction)
);

always #5 clk = ~clk;

initial begin
  
    $dumpfile("wave.vcd");
    $dumpvars(0,elevator_tb);
  
    clk = 0;
    reset = 1;
    request = 3'b000;

    #10 reset = 0;

    // request floor 2
    #10 request = 3'b100;

    #50 request = 3'b000;

    // request floor 1
    #20 request = 3'b010;

    #50 $finish;
end

endmodule