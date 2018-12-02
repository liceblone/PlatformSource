drop proc Pr_InvCostMonthlyChange
go 
  
CREATE proc Pr_InvCostMonthlyChange  
@FBeginMonth smalldatetime      
,@FEndMonth smalldatetime                      
,@FWhCode varchar(10)                  
,@FinvTypeCode   varchar(50)                            
,@FinvName       varchar(50)                            
,@FgoodCode      varchar(50)                            
,@FcolorCode     varchar(50)                           
as  
  
  
set @FBeginMonth = dbo.Fn_GetFirstDayofMonth(@FBeginMonth)  
set @FEndMonth   = dbo.Fn_GetFirstDayofMonth(@FEndMonth)  
                  
select year(invcost.Fmonth) as Fyear, month(invcost.Fmonth) as FMonth, case when isnull(invcost.FBalanceQty,0)=0 then 0 else invcost.FBalanceAmt/invcost.FBalanceQty end FCost   
, Wh.FWhName
,inv.*    
  from TInvCostAccounting  invcost                 
  join TInventory inv on invcost.FInvCode=inv.FInvCode   
  join Twarehouse wh on invcost.FwhCode=wh.Fwhcode 
  where FislastRow=1   
  and Fmonth>=  @FBeginMonth        
  and Fmonth<  dateadd(m,1,@FEndMonth)     
   and invcost.FWhcode like @FWhCode        
  and isnull(inv.FinvTypeCode,'') like @FinvTypeCode                                
  and isnull(inv.FinvName ,'')  like @FinvName     
                   
  and isnull(inv.FgoodCode ,'') like @FgoodCode                       
  and isnull(inv.FcolorCode ,'')like @FcolorCode   
   order by Fmonth desc        
      /**/  

