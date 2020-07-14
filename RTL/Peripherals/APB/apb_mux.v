

module apb_mux
(
  // -------------
  // Input pins //
  // -------------
  // Clock and reset
  input HCLK,
  input HRESETn,
  // Slave datas
  input [31:0] PRDATAx0,
  input [31:0] PRDATAx1,
  input [31:0] PRDATAx2,
  input [31:0] PRDATAx3,
  input [31:0] PRDATAx4,
  input [31:0] PRDATAx5,
  input [31:0] PRDATAx6,
  input [31:0] PRDATAx7,
  input [31:0] PRDATAx8,
  // Control signals
  input PSELx0,
  input PSELx1,
  input PSELx2,
  input PSELx3,
  input PSELx4,
  input PSELx5,
  input PSELx6,
  input PSELx7,
  input PSELx8,
  // Slave responses
  input PREADYx0,
  input PREADYx1,
  input PREADYx2,
  input PREADYx3,
  input PREADYx4,
  input PREADYx5,
  input PREADYx6,
  input PREADYx7,
  input PREADYx8,

  input PRESPx0,
  input PRESPx1,
  input PRESPx2,
  input PRESPx3,
  input PRESPx4,
  input PRESPx5,
  input PRESPx6,
  input PRESPx7,
  input PRESPx8,  
  // --------------
  // Output pins //
  // --------------
  output reg PREADY,
  output reg PRESP,
  output reg [31:0] PRDATA
);
// Slave select register
reg [3:0] slave_select;
// Slave select register update
always @ (posedge HCLK or negedge HRESETn) begin
  if(!HRESETn) begin
    slave_select <= 4'b0;
  end
  else begin
    // If PREADY is high, update slave_select
    if(PREADY) begin
      case({PSELx8,PSELx7, PSELx6, PSELx5, PSELx4, PSELx3, PSELx2, PSELx1, PSELx0})
        9'h001: slave_select <= 4'h0;
        9'h002: slave_select <= 4'h1;
        9'h004: slave_select <= 4'h2;
        9'h008: slave_select <= 4'h3;
        9'h010: slave_select <= 4'h4;
        9'h020: slave_select <= 4'h5;
		    9'h040: slave_select <= 4'h6;
        9'h080: slave_select <= 4'h7;
        9'h100: slave_select <= 4'h8;
        // Default is for default slave
        default: slave_select <= 4'hx;
      endcase
    end
  end
end

// Read data multiplexor
always @ (*) begin
  case(slave_select)
    4'h0: PRDATA = PRDATAx0;
    4'h1: PRDATA = PRDATAx1;
    4'h2: PRDATA = PRDATAx2;
    4'h3: PRDATA = PRDATAx3;
    4'h4: PRDATA = PRDATAx4;
    4'h5: PRDATA = PRDATAx5;
    4'h6: PRDATA = PRDATAx6;
	  4'h7: PRDATA = PRDATAx7;
    default: PRDATA = 64'hx;
  endcase
end

// Response multiplexor
always @ (*) begin
  case(slave_select)
    4'h0: begin
      PRESP = PRESPx0;
      PREADY = PREADYx0;
      end
    4'h1: begin
      PRESP = PRESPx1;
      PREADY = PREADYx1;
    end
    4'h2: begin
      PRESP = PRESPx2;
      PREADY = PREADYx2;
    end
    4'h3: begin
      PRESP = PRESPx3;
      PREADY = PREADYx3;
    end
    4'h4: begin
      PRESP = PRESPx4;
      PREADY = PREADYx4;
    end
    4'h5: begin
      PRESP = PRESPx5;
      PREADY = PREADYx5;
    end
    4'h6: begin
      PRESP = PRESPx6;
      PREADY = PREADYx6;
    end
	4'h7: begin
      PRESP = PRESPx7;
      PREADY = PREADYx7;
    end
    default: begin
      PRESP = 1'bx;
      PREADY = 1'bx;
    end
  endcase
end

endmodule
