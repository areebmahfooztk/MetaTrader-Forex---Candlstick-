#include<Trade\Trade.mqh>
CTrade trade ;
void OnTick()
   {
   
    MqlRates PriceInformation[];
    
    ArraySetAsSeries(PriceInformation,true);
    
    int Data = CopyRates(Symbol(),Period(),0,40,PriceInformation);
    
    double closePrice= PriceInformation[1].close;
    double High = PriceInformation[1].high;
    double Low = PriceInformation[1].low;
    
    double marl=PriceInformation[0].open+0.001;
    double mars=PriceInformation[0].open+0.001;
    
    
    int HighestCandle;
    
    double Hig[];
    
    ArraySetAsSeries(Hig, true);
    CopyHigh(_Symbol,_Period,0,40,Hig);
    
    HighestCandle=ArrayMaximum(Hig,0,40);
    double pro=PriceInformation[HighestCandle].high;
    
  
    int index_high = iLowest(NULL, 0, MODE_CLOSE, 40, 0);
    double shor = PriceInformation[index_high].close;

    if (PriceInformation[0].open >= closePrice && PositionsTotal()==0)
     {
       double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
       double tp=0;
       double sl=0;
       tp=tp+pro;
       sl=sl+(marl-(tp-marl));
       Comment("stoploss\t=",sl,"\t takeprofit=",tp);
        
       trade.Buy(0.5,NULL,Ask,sl-100*_Point+100*_Point,(tp+0* _Point),NULL); 
    
     }
    else if (PriceInformation[0].open <= Low && PositionsTotal()==0)
     {
      double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
      double tp=0;
      double sl=0;
      tp=tp+shor;
      sl=sl+(mars+(mars-tp));
      Comment("stoploss\t=",sl,"\t takeprofit=",tp);

      trade.Sell(0.5,NULL,Bid,sl+100*_Point-100*_Point,(tp-0* _Point),NULL);
    }
     Comment("running arbmhz");
    
   }