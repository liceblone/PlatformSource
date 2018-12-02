drop proc Pr_GetInvIOItems
go 
CREATE  proc Pr_GetInvIOItems              
@FBeginMonth smalldatetime,                                    
@FEndMonth   smalldatetime,                                      
@FinoutTypeCode varchar(50),                                   
@FcltvdCode     varchar(50),                                   
@FinvTypeCode   varchar(50),                                   
@FinvName       varchar(50),                                   
@FgoodCode      varchar(50),                                   
@FcolorCode     varchar(50),                                   
@FWhCode        varchar(50)='%',                                  
@FEmpCode       varchar(50)                                  
                                    
as                                    
                                    
-- exec Pr_GetInvIOItems '2013-01-01 00:00:00','2013-01-10 00:00:00','%','%','%','%','%','%','W0004%','000%'                  
                    
/*                                         
  declare @FBeginMonth smalldatetime                                     
  set @FBeginMonth='2012-1-1'                      
*/                       
if  not exists( select * from TInvCostAcctMonthEndClose where FisClosed=1 and FMonth= dateadd(m,-1,@FBeginMonth)  )                                     
begin                          
  select '请先月节初期!'as FinvName                          
end                          
                        
/*                       
 declare @FBeginMonth smalldatetime,@FEndMonth   smalldatetime,              @FinoutTypeCode varchar(50),                                  
@FcltvdCode     varchar(50),           @FinvTypeCode   varchar(50),           @FinvName       varchar(50),                                   
@FgoodCode      varchar(50),           @FcolorCode     varchar(50),           @FWhCode        varchar(50) ,                                  
@FEmpCode       varchar(50)                                  
set @FBeginMonth='2012-12-01'                        
set @FEndMonth='2013-01-08'                        
set @FinoutTypeCode='%'                        
set @FcltvdCode='%'                        
set @FinvTypeCode='%'                        
set @FinvName='%'                        
set @FgoodCode='%'                        
set @FcolorCode='%'                        
set @FWhCode='W0004%'                        
set @FEmpCode='%'                    
     */                           
declare @FSaleOutTypeCode varchar(50), @FSaleRtnTypeCOde varchar(50)               
select @FSaleOutTypeCode= FParamValue  From TParamsAndValues where FParamCode='010101'                 
select @FSaleRtnTypeCOde= FParamValue  From TParamsAndValues where FParamCode='010102'                                      
set @FEmpCode=replace(@FEmpCode,'%', '')                                  
set @FBeginMonth = dbo.Fn_GetFirstDayofMonth( @FBeginMonth )                                  
set @FEndMonth   = dateadd(m, 1,dbo.Fn_GetFirstDayofMonth( @FEndMonth  ))                      
print @FBeginMonth    print     @FEndMonth                  
                      
select                                                      
OutM.FWhOutCode as FBillCode  ,OutDL.Fprice ,OutDL.F_ID ,                                    
isnull( OutDL.FOutQty ,0)  as FMainQty    ,isnull(OutDL.Fprice*OutDL.FOutQty  ,0)   as FAmt                                     
,inv.FinvCode ,OutM.FOutDate as Fdate   , OutM.FWhCode   , 1054 as FormID ,'BillEx' as BillType                                      
,invTp.FinvTypeName ,ioTp.FinOutTypeName ,OutM.FinOutTypeCode ,OutDL.FinvName,OutDL.FGoodCode,OutDL.FColorCode,inv.Fnote as FinvNote                                                                         
,Wh.FWhName       , OutM.FChkTime   , 0.0 as FOutCost                             
  into  #itemIO                              
from TwhoutM   OutM                                                                 
             
join TwhOutdl  OutDL on OutM.FWhOutCode=OutDL.FWhOutCode                             
join Tinventory inv on inv.FinvCode=OutDL.FinvCode                              
left join Tunit ut  on ut.FunitCOde=inv.FmainUnitCOde                                                                           
left join TMtrLStorage stg on OutDl.FinvCode=stg.FinvCode    and stg.FWhCode=OutM.FWhCode                                                                  
left join Tinvtype invTp  on invTp.FinvTypeCode=inv.FinvTypeCode                                    
left join TinoutType ioTp on ioTp.FinOutTypeCode =OutM.FinOutTypeCode                                    
left join TWareHouse wh   on Wh.FWhCode=OutM.FWhCode and wh.FNeedCostAccounting=1     --   select FNeedCostAccounting from TWareHouse                                 
where OutM.Fischk=1                                                       
and  OutM.FOutDate >=@FBeginMonth                                                      
and  OutM.FOutDate <@FEndMonth                                                                              
and  isnull(OutM.FinOutTypeCode,'')like @FinoutTypeCode                                                                                
and  isnull( OutM.Fcltvdcode,'')   like @FcltvdCode                                                        
and  isnull( inv.FinvTypeCode,'')  like @FinvTypeCode                                                                                  
and  isnull( inv.FinvName ,'')     like @FinvName                                                                                        
and  isnull(inv.FgoodCode ,'')     like @FgoodCode                                                                              
and  isnull(inv.FcolorCode,'')     like @FcolorCode                                                    
and  isnull(OutM.FWhCode,'')       like @FWhCode                                                                                                    
union all                             
select                                                         
inM.FWhinCode as FBillCode ,inDL.Fprice,inDL.F_ID ,                                    
isnull( inDL.FMainQty,0)  as FMainQty,isnull( inDL.Fprice*inDL.FMainQty,0)  as FAmt                                    
,inv.FinvCode ,inM.FinDate as Fdate       ,inM.FWhCode  , 1055 as FormID ,'BillEx' as BillType                                    
,invTp.FinvTypeName ,ioTp.FinOutTypeName ,inM.FinOutTypeCode,inDL.FinvName,inDL.FGoodCode,inDL.FColorCode,inv.Fnote as FinvNote                                    
,Wh.FWhName  , inM.FChkTime        , null as FOutCost                             
From Twhin inM                                                                               
join Twhindl inDL   on inM.FWhinCode=inDL.FWhinCode                                      
join Tinventory inv on inv.FinvCode=inDL.FinvCode                                        
left join Tunit ut  on ut.FunitCOde=inv.FmainUnitCOde                                    
left join Tinvtype invTp  on invTp.FinvTypeCode=inv.FinvTypeCode                                    
left join TinoutType ioTp on ioTp.FinOutTypeCode =inM.FinOutTypeCode                                    
left join TWareHouse wh   on Wh.FWhCode=inM.FWhCode     and wh.FNeedCostAccounting=1                               
where inM.Fischk=1                                                              
and   inM.FinDate>=@FBeginMonth                                                           
and   inM.FinDate<@FEndMonth                                                                                
and  isnull(inM.FinOutTypeCode,'')like @FinoutTypeCode                                                                                
and  isnull( inM.FVendorCode,'')  like @FcltvdCode                                                                                    
and  isnull( inv.FinvType
Code,'') like @FinvTypeCode                                                                                  
and  isnull( inv.FinvName ,'')    like @FinvName                                                             
and  isnull(inv.FgoodCode ,'')    like @FgoodCode                        
and  isnull(inv.FcolorCode,'')    like @FcolorCode                                                     
and  isnull(inM.FWhCode,'')       like @FWhCode                                     
                                    
/*                              
 insert into TInvCostAccounting                                     
 (FInvCode,FOriPrice,FBillCode, BillType, FormID,FQty,F_ID,FDate, FWhCode,FMonth)                                    
 select                                     
 FInvCode,FPrice,FBillCode , BillType, FormID,FMainQty,F_ID,FDate, FWhCode  ,  convert(varchar(4),year(FDate))+'/'+ convert(varchar(4), month(FDate))+'/1'                                   
 from #itemIO io where not exists(select 1 from TInvCostAccounting where F_ID= io.F_ID )                                    
*/                                 
                                
 if   ( select count(*) from #itemIO )<> (select count(*) from TInvCostAccounting Ico where Ico.FMonth=@FBeginMonth and FWhCode= @FWhCode )        
 delete TInvCostAccounting where FMonth = @FBeginMonth and FWhCode= @FWhCode        
                                           
 select Ico.FInvCode, Ico.FOriPrice as FPrice,  Ico.FBillCode, Ico.BillType, Ico.FormID, Ico.FQty, Ico.F_ID,Ico.FDate                             
,Ico.FOriPrice*Ico.FQty as FAmt    , Ico.FWhCode                                    
,Ico.FAccountTime ,case when Ico.FIsAccounted=1 then '已核算' else '' end as FIsAccounted   ,Ico.FChkTime                                 
,itm.FinvTypeName ,itm.FinOutTypeName ,itm.FinOutTypeCode ,itm.FinvName, itm.FGoodCode, itm.FColorCode, itm.FinvNote  ,itm.FWhName                                    
,convert(varchar(4),year(Ico.FMonth  ))+'/'+ convert(varchar(2),month(Ico.FMonth  ))    as FMonth  ,Ico.FOriPrice      , Ico.FOutCost                        
,case when itm.FinOutTypeCode=@FSaleOutTypeCode then   ( Ico.FOriPrice-Ico.FOutCost )* Ico.FQty               
      when itm.FinOutTypeCode=@FSaleRtnTypeCOde then  -( Ico.FOriPrice-Ico.FOutCost )* Ico.FQty end as FProfitAmt                    
into #TmpLst                              
                    
from #itemIO   itm                               
join TInvCostAccounting Ico      on Ico.F_ID =itm.F_ID                                    
where ico.FDate >=@FBeginMonth and  ico.FDate <@FEndMonth                                    
union    all                                         
select itm.FInvCode, itm.FPrice, itm.FBillCode, itm.BillType, itm.FormID, itm.FMainQty,    Itm.F_ID, Itm.FDate                                     
,Itm.FAmt   , Itm.FWhCode                                    
,null as FAccountTime ,''   as FIsAccounted   ,itm.FChkTime                                 
,itm.FinvTypeName ,itm.FinOutTypeName ,itm.FinOutTypeCode,itm.FinvName, itm.FGoodCode, itm.FColorCode, itm.FinvNote  ,itm.FWhName                                    
,  convert(varchar(4),year(itm.FDate))+'/'+ convert(varchar(2),month(itm.FDate))    as FMonth    ,0 as FOriPrice , 0.0 as FOutCost                               
,0.0000 as FProfitAmt                    
from #itemIO   itm                                
where  not  exists   ( select 1 from TInvCostAccounting  where  F_ID = itm.F_ID and FWhCode like @FWhCode)                               
                              
                                     
select FMonth as FBeginMonth, FMonth as FEndMonth,* from #TmpLst    order by  Fdate ,FChkTime                                    
                              
drop table #TmpLst                                
drop table #itemIO         
 -----------------------------------------------
------------------------------------- 
