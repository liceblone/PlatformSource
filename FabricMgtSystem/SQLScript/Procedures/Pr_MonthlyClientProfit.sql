drop proc Pr_MonthlyClientProfit
go 
        
CREATE proc Pr_MonthlyClientProfit                    
@FBeginYear smalldatetime          
,@FEndYear smalldatetime                          
,@FWhCode varchar(10)                      
,@FinvTypeCode   varchar(50)                                
,@FinvName       varchar(50)                                
,@FgoodCode      varchar(50)                                
,@FcolorCode     varchar(50)                               
,@FCltCode      varchar(50)         
as                    
                    
/*                
        
 declare @FYear smalldatetime  ,@FWhCode varchar(10) ,@FinvTypeCode   varchar(50),@FinvName   varchar(50) ,@FgoodCode varchar(50) ,@FcolorCode     varchar(50)                    
set @FYear='2013-02-01'                    
set @FWhCode='%'                  
set @FinvTypeCode='%'                  
set @FinvName ='%'                  
set @FgoodCode='%'                  
set  @FcolorCode='%'    */                    
                  
set @FBeginYear = dbo.Fn_GetFirstDayofYear(@FBeginYear)      
set @FEndYear   = dbo.Fn_GetFirstDayofYear(@FEndYear)      
      
declare @FSaleOutTypeCode varchar(50), @FSaleRtnTypeCOde varchar(50)                         
select @FSaleOutTypeCode= FParamValue  From TParamsAndValues where FParamCode='010101'                           
select @FSaleRtnTypeCOde= FParamValue  From TParamsAndValues where FParamCode='010102'                   
                         
select invcost.*                     
  ,case when invcost.FinOutTypeCode=@FSaleOutTypeCode then   ( invcost.FOriPrice-invcost.FOutCost )* invcost.FQty                         
        when invcost.FinOutTypeCode=@FSaleRtnTypeCOde then  -( invcost.FOriPrice-invcost.FOutCost )* invcost.FQty end as FProfitAmt                 
  ,case when invcost.FinOutTypeCode=@FSaleOutTypeCode then    invcost.FQty                         
        when invcost.FinOutTypeCode=@FSaleRtnTypeCOde then  - invcost.FQty end as FSalesQty         
  ,'           ' as FCltVdCode         
  ,case when invcost.FinOutTypeCode=@FSaleOutTypeCode then     invcost.FOriPrice * invcost.FQty                         
        when invcost.FinOutTypeCode=@FSaleRtnTypeCOde then  - invcost.FOriPrice * invcost.FQty end as FSalesAmt           
,case when invcost.FinOutTypeCode=@FSaleOutTypeCode then    invcost.FOutCost * invcost.FQty                         
        when invcost.FinOutTypeCode=@FSaleRtnTypeCOde then  - invcost.FOutCost * invcost.FQty end as FCostAmt       
              
   into #TInvCostAccounting                       
  from TInvCostAccounting  invcost                     
  join TInventory inv on invcost.FInvCode=inv.FInvCode                    
  where   (  invcost.FinOutTypeCode =@FSaleOutTypeCode   or invcost.FinOutTypeCode =@FSaleRtnTypeCOde )                   
 and Fmonth>=  @FBeginYear            
 and Fmonth<  dateadd(y,1, @FEndYear)         
                       
 and invcost.FWhcode like @FWhCode            
 and isnull(inv.FinvTypeCode,'') like @FinvTypeCode                                    
 and isnull(inv.FinvName ,'')  like @FinvName                            
 and isnull(inv.FgoodCode ,'') like @FgoodCode                           
 and isnull(inv.FcolorCode ,'')like @FcolorCode              
         
         
update   #TInvCostAccounting set FCltVdCode =B.FCltVdCode         
from     #TInvCostAccounting A        
join     ( select FWhoutCode as FBillCode,FCltVdCode from TwhoutM        
           union all        
           select FWhinCode,FVendorCode    from Twhin        
         ) B on  A.FBillCode=B.FBillCode         
        
         
  select *                    
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=1 and FCltVdCode=CltVd.FCltVdCode   ) as  FJanAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=1 and FCltVdCode=CltVd.FCltVdCode   ) as  FJanQty    
                
                      
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=2 and FCltVdCode=CltVd.FCltVdCode   ) as  FFebAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=2 and FCltVdCode=CltVd.FCltVdCode   ) as  FFebQty                    
                      
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=3 and FCltVdCode=CltVd.FCltVdCode   ) as  FMarAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=3 and FCltVdCode=CltVd.FCltVdCode   ) as  FMarQty                    
                      
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=4 and FCltVdCode=CltVd.FCltVdCode   ) as  FAprAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=4 and FCltVdCode=CltVd.FCltVdCode   ) as  FAprQty                    
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=5 and FCltVdCode=CltVd.FCltVdCode   ) as  FMayAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=5 and FCltVdCode=CltVd.FCltVdCode   ) as  FMayQty                    
                      
 ,(select sum(FProfitAmt)  from #TInvCostAccounting where   MONTH(fmonth)=6 and FCltVdCode=CltVd.FCltVdCode  ) as  FJunAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=6 and FCltVdCode=CltVd.FCltVdCode  ) as  FJunQty                    
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=7 and FCltVdCode=CltVd.FCltVdCode  ) as  FJulAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=7 and FCltVdCode=CltVd.FCltVdCode  ) as  FJulQty                     
                      
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=8 and FCltVdCode=CltVd.FCltVdCode  ) as  FAugAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=8 and FCltVdCode=CltVd.FCltVdCode  ) as  FAugQty                    
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=9 and FCltVdCode=CltVd.FCltVdCode  ) as  FSepAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=9 and FCltVdCode=CltVd.FCltVdCode  ) as  FSepQty                    
                      
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=10 and FCltVdCode=CltVd.FCltVdCode ) as  FOctAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=10 and FCltVdCode=CltVd.FCltVdCode ) as  FOctQty                    
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=11 and FCltVdCode=CltVd.FCltVdCode ) as  FNoAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=11 and FCltVdCode=CltVd.FCltVdCode ) as  FNovQty                    
                      
  ,(select sum(FProfitAmt) from #TInvCostAccounting where   MONTH(fmonth)=12 and FCltVdCode=CltVd.FCltVdCode ) as  FDecAmt                    
  ,(select sum( FSalesQty )from #TInvCostAccounting where   MONTH(fmonth)=12 and FCltVdCode=CltVd.FCltVdCode ) as  FDecQty                        
         
  ,(select sum(FSalesAmt)  from #TInvCostAccounting where   FCltVdCode=CltVd.FCltVdCode ) as  FSalesAmt                    
  ,(select sum( FCostAmt ) from #TInvCostAccounting where   FCltVdCode=CltVd.FCltVdCode ) as  FCostAmt        
        
     into #Show          
   from  ( select FCltCode,FCltCode as FCltVdCode ,  FCltName from TClient  where FCltCode like @FCltCode     ) as CltVd         
             
                       
alter table #Show add FAllYearAmt as                     
( isnull(FJanAmt,0)+isnull(FFebAmt,0)+isnull(FMarAmt,0)+isnull(FAprAmt,0)+isnull(FMayAmt,0)+isnull(FJunAmt,0)          
          
 +isnull(FJulAmt,0)+isnull(FAugAmt,0)+isnull(FSepAmt,0)+isnull(FOctAmt,0)+isnull(FNoAmt,0)+isnull(FDecAmt,0)                     
)                      
alter table #Show add FAllYearQty as              
( isnull(FJanQty,0)+isnull(FFebQty,0)+isnull(FMarQty,0)+isnull(FAprQty,0)+isnull(FMayQty,0)+isnull(FJunQty,0)                    
 +isnull(FJulQty,0)+isnull(FAugQty,0)+isnull(FSepQty,0)+isnull(FOctQty,0)+isnull(FNovQty,0)+isnull(FDecQty,0)                     
)                       
      
alter table #Show add FYearlyProfitRate as     ( case when isnull(FSalesAmt,0)=0 then 0         
else 100*(isnull(FJanAmt,0)+isnull(FFebAmt,0)+isnull(FMarAmt,0)+isnull(FAprAmt,0)+isnull(FMayAmt,0)+isnull(FJunAmt,0)                    
 +isnull(FJulAmt,0)+isnull(FAugAmt,0)+isnull(FSepAmt,0)+isnull(FOctAmt,0)+isnull(FNoAmt,0)+isnull(FDecAmt,0))/isnull(FSalesAmt,0)end  )                       
         
alter table #Show add FYearlyQtyProfitRate as     (     
 case when     
   ( isnull(FJanQty,0)+isnull(FFebQty,0)+isnull(FMarQty,0)+isnull(FAprQty,0)+isnull(FMayQty,0)+isnull(FJunQty,0)                  
    +isnull(FJulQty,0)+isnull(FAugQty,0)+isnull(FSepQty,0)+isnull(FOctQty,0)+isnull(FNovQty,0)+isnull(FDecQty,0) ) =0      
 then 0       
 else ( isnull(FJanAmt,0)+isnull(FFebAmt,0)+isnull(FMarAmt,0)+isnull(FAprAmt,0)+isnull(FMayAmt,0)+isnull(FJunAmt,0)                  
       +isnull(FJulAmt,0)+isnull(FAugAmt,0)+isnull(FSepAmt,0)+isnull(FOctAmt,0)+isnull(FNoAmt,0)+isnull(FDecAmt,0))    
     /(isnull(FJanQty,0)+isnull(FFebQty,0)+isnull(FMarQty,0)+isnull(FAprQty,0)+isnull(FMayQty,0)+isnull(FJunQty,0)                  
       +isnull(FJulQty,0)+isnull(FAugQty,0)+isnull(FSepQty,0)+isnull(FOctQty,0)+isnull(FNovQty,0)+isnull(FDecQty,0))    
 end  )                     
       
    
select  * from #Show       where FAllYearAmt<>0 or  FAllYearQty<>0            
                 
                    
drop table #Show                    
drop table #TInvCostAccounting                    
                  
                    
 ------------------------------------------------------------------------------------ 
