// Code your design here

module elevator_controller (
    input clk,
    input reset,
    input [2:0] request,      // floor requests: [0], [1], [2]
    output reg [1:0] floor,   // current floor
    output reg door_open,
    output reg direction      // 0 = down, 1 = up
);

parameter IDLE = 2'b00;
parameter MOVE = 2'b01;
parameter DOOR = 2'b10;

reg [1:0] state;
reg [1:0] target_floor;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        floor <= 0;
        door_open <= 0;
        direction <= 0;
    end
    else begin
        case(state)

        IDLE: begin
            door_open <= 0;

            if(request[0]) target_floor <= 0;
            else if(request[1]) target_floor <= 1;
            else if(request[2]) target_floor <= 2;

            if(request != 3'b000)
                state <= MOVE;
        end

        MOVE: begin
            if(target_floor > floor) begin
                floor <= floor + 1;
                direction <= 1;
            end
            else if(target_floor < floor) begin
                floor <= floor - 1;
                direction <= 0;
            end
            else
                state <= DOOR;
        end

        DOOR: begin
            door_open <= 1;
            state <= IDLE;
        end

        endcase
    end
end

endmodule