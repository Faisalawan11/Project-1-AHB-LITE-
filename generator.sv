class generator;
transaction trans,trans1;//Transaction instance or Handler
  mailbox #(transaction) mbx;//mailbox with parameterized class
int count=0;//Count variable taken for number of stimulus

  
  
event next;  ///know when to send next transaction
event done;  ////conveys completion of requested no. of


function new(mailbox#(transaction)mbx);//custom constructor for mbx
this.mbx=mbx;
trans=new();
trans1=new trans;//constructor for transaction class
endfunction
  
  
  task main();
  repeat(count)
    begin
	assert(trans.randomize)
      //begin
        trans.hwrite=1;
      //end
      else $error("Randomization failed");//Randomize the transaction class
      mbx.put(trans.copy);//putting the value of transaction copy
      
      
      assert(trans1.randomize)
      //begin
        trans1.hwrite=0;
      //end
      else $error("Randomization failed");//Randomize the transaction class
      mbx.put(trans1.copy);//putting the value of transaction copy
      trans1.display("GEN");
      @(next);//blocking event it will be true when event next trigger
      end 
     
     
     ->done;//done event triggering
   endtask
  
  
endclass



