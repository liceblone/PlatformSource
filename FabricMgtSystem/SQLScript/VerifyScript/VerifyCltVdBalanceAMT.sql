select  FDebtAmt,  B.FInvoiceAmt  ,Famt                                            
from TCltVdBookkeeping  A                                                            
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                                            
where   FDebtAmt<> B.FInvoiceAmt                                                                  
                                                    
  select FCreditAmt, isnull(B.Famt  ,0)  
 from TCltVdBookkeeping  A                                      
 left join (select sum(FAmt)Famt     ,FcltVdCode From TPayReceive where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                      
    join  TPayReceive PR  on PR.FCltVdCode= A.FCltVdCode  
    where	 FCreditAmt<> isnull(B.Famt  ,0)  