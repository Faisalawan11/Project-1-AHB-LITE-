class environment;
 
    generator gen;
    driver drv;
  
    monitor mon;
    scoreboard sco;
  
  mailbox #(transaction) gdmbx; ///generator + Driver
    
  mailbox #(transaction) msmbx; ///Monitor + Scoreboard
 
  event nextgs;
 
 
  virtual ahb_if aif;
  
  
  function new(virtual ahb_if aif);
 
    
    
    gdmbx = new();
    gen = new(gdmbx);//using same mailbox for generator and driver
    drv = new(gdmbx);
    
    
    
    
    msmbx = new();
    mon = new(msmbx,aif);
    sco = new(msmbx);
    
    
    this.aif = aif;
    
    drv.aif = this.aif;
   // mon.aif = this.aif;
    
    
    gen.next = nextgs;
    sco.next = nextgs;
 
  endfunction
  
  
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
  fork
    gen.main();
    drv.main();
    mon.main();
    sco.main();
  join_any
    
  endtask
  
  task post_test();
    wait(gen.done.triggered);  
    $finish();
  endtask
  
  task main();
    pre_test();
    test();
    post_test();
  endtask
  
  
  
endclass
 
