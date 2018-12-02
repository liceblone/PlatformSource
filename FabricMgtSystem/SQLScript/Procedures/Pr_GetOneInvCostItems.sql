drop proc Pr_GetOneInvCostItems
go 
  
  
CREATE proc Pr_GetOneInvCostItems                              
@FWhCode  varchar(30),                              
@FBeginMonth   smalldatetime,                              
@FEndMonth   smalldatetime,                              
@FinvCode varchar(30)                              
as                              
/*                              
      select * from   TInvCostAccounting where fmonth>='2013-3-1'               
      select * from TMtrLStorageHis where fmonth='2013-1-1'                     
exec Pr_GetOneInvCostItems 'W00000001%','2013-02-01 00:00:00','Inv00001001%'                            
declare @FWhCode  varchar(30), @FMonth   smalldatetime, @FinvCode varchar(30)                              
set @FWhCode='W0004'                              
set @FMonth='2013-1-01'                              
set @FinvCode='Inv00000997'                              
                            
select * from TInvCostAccounting                            
select * from Tinouttype                            
                            
*/                    
        
set @FBeginMonth =dbo.Fn_GetFirstDayofMonth( @FBeginMonth)                               
set @FEndMonth   =dbo.Fn_GetFirstDayofMonth( @FEndMonth)         
declare @FMonth   smalldatetime        
set    @FMonth  =@FBeginMonth                       
        
create table #tmp                
(FGroup smalldatetime,Findex  int    ,  FInvCode  varchar(30)   ,FWhCode  varchar(30) ,FWhDLFID varchar(50)  ,FBalanceAmt  decimal(19,3)   ,FStorage  decimal(19,3)   ,                
FStoragePkgQty  decimal(19,3)   ,FCreateTime  datetime   ,FChkTime  smalldatetime   ,FMonth  smalldatetime   ,                
FDate  smalldatetime  ,FOriPrice  decimal(19,3)   ,FOutCost  decimal(19,3)   ,FBillCode  varchar(50)   ,                
FormID  varchar(50)   ,BillType  varchar(50) , ParameterFLDs varchar(50),FWindowsFID varchar(50)  ,FEstimatedPrice  varchar(50)   ,FQty  decimal(19,3)  ,FAmt decimal(19,3)  ,FPackageQty  decimal(19,3)   ,                
FAvgPrice  decimal(19,3)  ,FinOutTypeName  varchar(50)   ,RowIndex  int identity(1,1), FCostInaccuracy  decimal(19,6)     
,FCostInaccuracyAmt decimal(19,3) ,FExpensesApportion decimal(19,3),FAccountingPrice decimal(19,6) , Fisin bit default null )                
                     
insert into #tmp                
(FGroup,Findex,FInvCode,FWhCode,FBalanceAmt,FStorage,FStoragePkgQty,FCreateTime,FChkTime,FMonth,FDate,FOriPrice,                
FOutCost,FBillCode,FormID,BillType,FEstimatedPrice,FQty,FAmt,FPackageQty,FAvgPrice,FinOutTypeName,FCostInaccuracy    
,FCostInaccuracyAmt, FExpensesApportion,FAccountingPrice)                  
select distinct FMonth as FGroup,1000000---case when FMonth=dbo.Fn_GetFirstDayofMonth(  @FMonth  ) then 10000000 else   -1 end as Findex        
,FinvCode,FwhCode                  
,isnull(FRevisedPrice*isnull(FRevisedStorage,FStorage),FAmt) as FAmt,isnull(FRevisedStorage ,FStorage)as FStorage,isnull(FRevisedPkgStorage,FStoragePkgQty) as FStoragePkgQty                          
,null as FCreateTime,null as FChkTime                            
,FMonth ,null as FDate  ,null as FOriPrice,null FOutCost,null FBillCode,null FormID,null BillType                  
,null as FEstimatedPrice                           
,null as FQty ,null as FAmt ,null as FPackageQty              
,case when FStorage is not null then isnull(FRevisedPrice,FAmt/FStorage) else null end as  FAvgPrice                             
,convert(varchar(4),year(FMonth)) +'/'+ convert(varchar(2),month(FMonth)) +' ÆÚÄ©' as  FInOutTypeName                          
,null as FCostInaccuracy ,null as FCostInaccuracyAmt    ,null as FExpensesApportion , null  as FAccountingPrice       
from TMtrLStorageHis where FWhCode like @FWhCode and FinvCode like @FinvCode and FMonth>=dbo.Fn_GetFirstDayofMonth( dateadd(m,-1, @FMonth) )                              
        
         
if not exists(se
lect * from #tmp where FMonth = dateadd(m,-1, @FBeginMonth)   )        
insert #tmp   (FGroup,Findex,FInvCode,FWhCode, FMonth,  FOutCost, FAmt,FAvgPrice ,FInOutTypeName)                  
select dateadd(m,-1, @FBeginMonth) , -100000, replace(@FinvCode, '%', ''), replace(@FWhCode, '%', ''), dateadd(m,-1, @FBeginMonth)  ,0,0,0         
,convert(varchar(4),year(dateadd(m,-1, @FBeginMonth) )) +'/'+ convert(varchar(2),month(dateadd(m,-1, @FBeginMonth) )) +' ÆÚÄ©' as  FInOutTypeName                          
        
                   
                   
while (@FMonth<=@FEndMonth)        
begin         insert into #tmp                
 (FGroup,Findex,FInvCode,FWhCode,FWhDLFID, FBalanceAmt,FStorage,FStoragePkgQty  
 ,FCreateTime,FChkTime,FMonth,FDate,FOriPrice  ,FOutCost  
 ,FBillCode,FormID,BillType, ParameterFLDs,FWindowsFID ,FEstimatedPrice  
 ,FExpensesApportion, FAccountingPrice, Fisin ,FinOutTypeName ,FAmt,FPackageQty  
 ,FQty,FAvgPrice  ,FCostInaccuracy,FCostInaccuracyAmt )                  
        
 select @FMonth as FGroup,1 as Findex, InvCst.FInvCode,InvCst.FWhCode ,InvCst.F_ID, InvCst.FBalanceAmt,InvCst.FBalanceQty,InvCst.FBalancePkgQty   
 ,InvCst.FCreateTime ,InvCst.FChkTime ,InvCst.FMonth ,InvCst.FDate   ,InvCst.FOriPrice    ,InvCst.FOutCost  
 ,InvCst.FBillCode,InvCst.FormID,InvCst.BillType, InvCst.ParameterFLDs, InvCst.FWindowsFID  ,InvCst.FEstimatedPrice     
 ,InvCst.FExpensesApportion   , InvCst.FAccountingPrice ,invCst.Fisin   ,IoTp.FinOutTypeName,InvCst.FAmt, InvCst.FPackageQty               
 , case when InvCst.Fisin=1 then InvCst.FQty else -InvCst.FQty end as FQty                            
 ,case when InvCst.FBalanceQty =0 then InvCst.FOutCost else InvCst.FBalanceAmt/InvCst.FBalanceQty end FAvgPrice                            
 ,case when isnull(InvCst.FOriPrice,0)<>0 then  InvCst.FEstimatedPrice -InvCst.FOriPrice  end  as FCostInaccuracy              
 ,case when isnull(InvCst.FOriPrice,0)<>0 then (InvCst.FEstimatedPrice -InvCst.FOriPrice )*InvCst.FQty end  as FCostInaccuracyAmt    
 from TInvCostAccounting InvCst                             
 join Tinouttype         IoTp  on invCst.FinOutTypeCode = IoTp.FinOutTypeCode                    
 where InvCst.FWhCode like @FWhCode and InvCst.FinvCode like @FinvCode and InvCst.FMonth=dbo.Fn_GetFirstDayofMonth(@FMonth)           
         
 set @FMonth =dateadd(m,1,@FMonth)                           
end                   
                
                
select tmp.*  , wh.FWhName   ,isnull(tmp.FAccountingPrice*tmp.FQty, tmp.FAvgPrice*tmp.FQty)+isnull(tmp.FExpensesApportion,0) as FPNAmt   
,case when tmp.FAccountingPrice =0  then 'clred' else 'clblack' end as FntClr    
from #tmp tmp   join TWarehouse wh on tmp.FWhCode = wh.FWhCode      
order by tmp.FWhCode, tmp.FGroup, tmp.Findex, isnull(tmp.FDate, dateadd(m,1,tmp.fmonth)-1 )  ,tmp.RowIndex,tmp.FChkTime                            
      
drop table #tmp                              
                               
         
