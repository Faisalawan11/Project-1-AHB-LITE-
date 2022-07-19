// Code your testbench here
// or browse Examples
module tb;
    `include "transaction.sv"
    `include "generator.sv"
    `include "driver.sv"
    `include "interface.sv"
    `include "monitor.sv"
    `include "scoreboard.sv"
    `include "environment.sv"
    
    logic   hclk = 1;
   logic   hresetn;  
    
    
    always #10 hclk = ~hclk;
  initial begin
 	hresetn=0;
    #20;
    hresetn=1;
  end
    
    
  ahb_if aif(hclk,hresetn);
  amba_ahb_slave dut (.hclk(hclk), .hresetn(hresetn), .hsel(1'b1),.haddr(aif.haddr), .htrans(aif.htrans), .hwrite(aif.hwrite), .hsize(aif.hsize), .hburst(aif.hburst), .hprot(aif.hprot), .hwdata(aif.hwdata), .hrdata(aif.hrdata), .hready(aif.hready),.hresp(aif.hresp));//connecting interface to DUT ports
    
    
  
    environment env;//Environment class instance
    
    
    
    initial begin
      env = new(aif);//custom constructor to initialize the virtual interface to actual interface 
      env.gen.count = 4;//count value for number of transactions
      env.main();
    end
      
    
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
   
    
  endmodule
 
 
