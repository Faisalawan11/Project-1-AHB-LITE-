//Fields required to generate the stimulus are declared in the transaction class

class transaction;
  bit hsel;//Selection bit for the slave
  rand bit [31:0] haddr;//Address Line
  rand bit [1:0] htrans;//Transfer type
  bit hwrite;//Transfer direction
  rand bit [2:0] hsize;//Transfer size
  rand bit [2:0] hburst;//3 bit burst for Single, INC and Wrap beats
  rand bit [3:0] hprot;//Protection Signal
  rand bit [31:0] hwdata;//Data coming from the Master
  bit [31:0] hrdata;//hrdata is high when slave is returning the data
  bit hready;// Ready to serve the request provided by the Master
  bit hresp;//Response conveyed by slave to Master
 
  
  constraint c1{htrans==2;}
  constraint c2{hsize inside {2};}
  constraint c3{if(hsize==1)haddr%2==0;
                else if(hsize==2)haddr%4==0;
                else haddr%1==0;}
  constraint c4{haddr<=1023;}
  constraint c5{hwdata<=255;}
  constraint c6{hprot==4'b0001;}
  constraint c7{hburst==0;}
/*  constraint ahb_lite{
    hsize inside{3'b000,3'b001,3'b010};
    //transfer size (byte, half word, word)
    htrans dist{2'b00:=10,2'b01:=10,2'b10:=80};
    // Idle 10%,Busy 10%, Non Seq 80%
    hprot inside{4'b0001};
    //protection signals for data
   // hwrite dist{1'b1:=1,1'b0:=1};
    //half distribution for hwrite
   // hsel inside {1'b1};
    //selection for this slave bus
   // haddr inside {[32'h0:32'h255]};
  }*/
    //////Display Method for all the ports///////////////
  function void display(input string tag);
    $display ("[%0s]: hsel: %0d\t haddr: %0d\t htrans: %0b\t hwrite: %0b\t hsize: %0b\t hburst: %0b\t hprot:%0b\t hwdata: %0d\t hrdata: %0d\t hready: %0b\t hresp: %0b\t", tag, hsel, haddr, htrans, hwrite, hsize, hburst, hprot, hwdata, hrdata, hready, hresp);
  endfunction
  
  //////////////Deep copy//////////////
  function transaction copy();
    copy=new();
    copy.hsel=this.hsel;
    copy.haddr=this.haddr;
    copy.htrans=this.htrans;
    copy.hwrite=this.hwrite;
    copy.hsize=this.hsize;
    copy.hburst=this.hburst;
    copy.hprot=this.hprot;
    copy.hwdata=this.hwdata;
    copy.hrdata=this.hrdata;
    copy.hready=this.hready;
    copy.hresp=this.hresp;
 endfunction
endclass
