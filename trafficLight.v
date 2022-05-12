/*
  Author : Rakotojaona Nambinina
  email : Andrianoelisoa.Rakotojaona@gmail.com
  Description : traffic light verilog code
*/
`timescale 1ns / 1ps

module TrafficLight(
                   clk,
                   rst,
                   press,
                   Light_for_car,
                   Light_for_people
                   );
  // input port
  input clk;
  input rst;
  input press;
  // output port
  
  /*
    001 : RED
    010 : ORANGE
    100 : GREEN
  */
  output reg [2:0] Light_for_car;  
  output reg [2:0] Light_for_people;
  
  integer counter;
  // state 
  integer state;
  
  always @ (posedge clk)
    begin
      counter <= counter + 1;
      if (rst)
        begin
          counter <=0;
          state <=0;
          Light_for_car <=3'b010;
          Light_for_people <=3'b010;
        end
      else
        begin
          case (state)
            0:
              begin
                if (counter == 32'd2)
                  begin
                    state <=1;
                  end 
              end
            1:
              begin
                if (press)
                  begin
                    state <=2;
                    counter <=0;
                  end 
              end
            2:
              begin
                if (counter == 32'd2)
                  begin
                    state <=3;
                    counter <=0;
                  end 
              end 
            3:
              begin
                if (counter == 32'd5)
                  begin
                    state <=1;
                  end 
              end 
          endcase
        end 
    end
    
  always @ (negedge clk)
    begin
      case (state)
      
        /*
    001 : RED
    010 : ORANGE
    100 : GREEN
  */
        0: // idle state 
          begin
            Light_for_car <=3'b010;
            Light_for_people <=3'b010;
          end
        1: // pass car
          begin
            Light_for_car <=3'b100;
            Light_for_people <=3'b001;
          end 
        2: // wait state
          begin
            Light_for_car <=3'b010;
            Light_for_people <=3'b010;
          end
        3: // pass people
          begin
            Light_for_car <=3'b001;
            Light_for_people <=3'b100;
          end 
      endcase
    end 
  
endmodule

/*


module tb(

    );
    
  // input port
  reg clk;
  reg rst;
  reg press;
  // output port
  wire [2:0] Light_for_car;  
  wire [2:0] Light_for_people;
  
    TrafficLight uut (
                   clk,
                   rst,
                   press,
                   Light_for_car,
                   Light_for_people
                   );
  initial
    begin
      clk =0;
      rst =1;
      press =0;
      #10
      rst=0;
      #30
      press =1;
      #10
      press =0;
      #100
      press =1;
    end 
  always
    begin
      #5 clk = ! clk;
    end
 
endmodule
*/
