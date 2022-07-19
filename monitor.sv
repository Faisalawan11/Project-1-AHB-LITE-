

  
 class monitor;
 
   virtual ahb_if aif;//virtual interface for monitor
  
   mailbox #(transaction) mbx;
  
   transaction tr;
  
   function new(mailbox #(transaction) mbx,virtual ahb_if aif);
      this.mbx = mbx;    
     this.aif=aif;
   endfunction
  
  
  task main();
    tr = new();
    repeat(8) begin
      
      
      repeat(10) @(posedge aif.hclk); //repeating for 2 posedge ticks
      
          
      ///Taking signals from Interface in to the transaction class
      tr.hsel = aif.hsel;
      tr.htrans = aif.htrans;
      tr.hwrite = aif.hwrite;
      tr.hsize = aif.hsize;
      tr.hburst = aif.hburst;
      tr.hprot=aif.hprot;
      tr.hwdata=aif.hwdata;
      tr.hrdata=aif.hrdata;
      tr.hready=aif.hready;
      tr.hresp=aif.hresp;
      tr.haddr=aif.haddr;
      
      
      
      mbx.put(tr);//putting transaction signal to scoreboard via mailbox
      
      tr.display("MON");
 
    end
    
  endtask
  
 
  
endclass


