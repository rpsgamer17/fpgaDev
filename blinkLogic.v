module blinkLogic(
    input clk,          // 100 MHz clock input
    output [7:0] leds   // 3 LEDs
);
    reg [26:0] counter = 0;      // Counter to slow down the clock
    reg [7:0] led_state = 8'b00000001; // Initial state: only LED0 ON
    reg direction = 1;           // 1 = left, 0 = right

    always @(posedge clk) begin
        counter <= counter + 1;

        if (counter == 12_500_000) begin // ~0.5 seconds at 100 MHz
            counter <= 0;

            // Shift LEDs based on direction
            if (direction) begin
                // Check for leftmost LED (prevent invalid state)
                if (led_state == 8'b10000000) begin
                    direction <= 0; // Reverse direction to right
                end else begin
                    led_state <= led_state << 1; // Shift left
                end
            end else begin
                // Check for rightmost LED (prevent invalid state)
                if (led_state == 8'b00000001) begin
                    direction <= 1; // Reverse direction to left
                end else begin
                    led_state <= led_state >> 1; // Shift right
                end
            end
        end
    end

    assign leds = led_state; // Drive the LEDs
endmodule
