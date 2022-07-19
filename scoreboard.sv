//Gets the packet from monitor, generates the expected result and compares with the actual result received from the Monitor


   
class scoreboard;
  
   mailbox #(transaction) mbx;
  
   transaction tr;
  
   event next;//
  
  bit [31:0] din[$];//queue took to store for write data
  
  
  function new(mailbox #(transaction) mbx);//custom constructor for mailbox
      this.mbx = mbx;     
    endfunction
  
  
  task main();
    
    repeat(8) begin
    
    mbx.get(tr);
    
    tr.display("SCO");
    
    if(tr.hwrite == 1'b1)
      begin 
        din.push_front(tr.hwdata);//Storing the value of hwdata in a queue of zero index
        $display("[SCO] : DATA STORED IN QUEUE :%0d", tr.hwdata);
      end
    
    
    else if(tr.hrdata == tr.hwdata)begin
          
            $display("[SCO] : DATA MATCH");
        end
           else begin
             $error("[SCO] : DATA MISMATCH");
        end
        
        
        
     
    
    ->next;
  end
  endtask
 
  
endclass
 
  

