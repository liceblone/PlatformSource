drop proc PR_LstInvStorageHis
go 
CREATE  proc [dbo].[PR_LstInvStorageHis]             
@FMonth  smalldatetime,                
@FWhCode varchar(40),                
@FInvTypeCode varchar(40),                
@FInvName varchar(40),                
@FColorCode varchar(40),                
@FGoodCode  varchar(40),                
@FinvNote   varchar(40),                
@FEmpCode   varchar(40)                 
as                
                
set @FMonth  = convert( smalldatetime ,  convert(varchar(4),year(@FMonth))+'/'+convert(varchar(2),month(@FMonth))+'/01')                
                
--     truncate table TMtrLStorageHis            
                
if not exists( select * from TMonthEndClose where FisClosed=1)                
begin          
/*      
    if exists( select * from TMtrlStorage where isnull(FAvgPrice ,0) =0 AND isnull( FStorage,0) <>0)          
    begin          
       select '请先补所有存货的成本单价' as FInvName          
    end          
    else        
*/        
    begin   
    if not exists( select 1 from TMtrLStorageHis his join Twarehouse   wh on   wh.FWhCode=his.FWhCode )        
      if not exists (select 1 from TMtrLStorageHis where FisChk=1)        
      begin        
        delete TMtrLStorageHis          
        insert into TMtrLStorageHis                  
        (F_ID,FCreateEmp,FCreateTime,FLstEditEmp,FLstEditTime,                
        FInvCode,FWhCode,FOutQty,FinQty,FLstPrice,FAvgPrice,FinPkgQty,FOutPkgQty,FStorage,                
        FStoragePkgQty,FUltimoPrice,FUltimoBalce,FUltimoBalcePkgQty , FMonth ,FAmt)                
        select       
         stg.F_ID, stg.FCreateEmp, stg.FCreateTime, stg.FLstEditEmp, stg.FLstEditTime,       
         stg.FinvCode, stg.FWhCode,stg.FOutQty,   stg.FinQty,   stg.FLstPrice,stg.FAvgPrice,stg.FinPkgQty, stg.FoutPkgQty, stg.FStorage,        
          stg.FStoragePkgQty,stg.FUltimoPrice,  stg.FUltimoBalce, stg.FUltimoBalcePkgQty             
        , @FMonth  , FAvgPrice*FStorage as FAmt        
        from TMtrLStorage stg       
        join Twarehouse   wh  on stg.FWhCode like Wh.FWhCode and wh.FNeedCostAccounting=1        
        where   isnull( stg.FStorage,0) <>0          
       end           
 end          
end                
                 
select Stg.*  --,inv.FinvName, inv.FColorCode,Inv.FGoodCode,inv.FNote as FinvNote          
from TMtrLStorageHis Stg                
left join TInventory      inv  on Stg.FinvCode = inv.FinvCode                
where  isnull( stg.FStorage,0) <>0 and  stg.FMonth =@FMonth                   
and Stg.FWhCode like @FWhCode                  
and isnull(inv.FInvTypeCode ,'')like @FInvTypeCode                 
and isnull(inv.FInvName ,'')like @FInvName                  
and isnull(inv.FColorCode ,'')like @FColorCode                
and isnull(inv.FGoodCode ,'') like @FGoodCode                 
and isnull(inv.FNote ,'')  like @FinvNote                 
              
              
  --truncate  table TMtrLStorageHis         
 ------------------------------------------------------------------------------------         
       
