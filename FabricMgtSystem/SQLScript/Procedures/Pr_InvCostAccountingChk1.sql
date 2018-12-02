drop proc Pr_InvCostAccountingChk1
go 
        
CREATE  proc [dbo].[Pr_InvCostAccountingChk1]                                             
@Abortstr  varchar(300) output                                                                          
,@Warningstr  varchar(3000) output                                              
,@FMonth smalldatetime                                               
,@FWhCode varchar(10)                                                    
,@FIsAccounted varchar(10)                                                    
,@FEmpCode  varchar(30)                                                                               
as                 
                                             
declare @RowIndex int                              
select @FMonth=dbo.Fn_GetFirstDayofMonth (@FMonth)                                 
print @FMonth  print DATEADD(m,-1,@FMonth)                                            
                                 
/*                                            
declare @p1 varchar(300)          
set @p1=NULL          
declare @p2 varchar(3000)          
set @p2=NULL          
exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,'2013-02-19 20:03:00','W00000001','','E000010'          
          
declare @p1 varchar(300)          
set @p1=NULL          
declare @p2 varchar(3000)          
set @p2=NULL          
exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,'2013-02-19 20:03:00','W00000001','已核算','E000010'          
                                            
                                           
 */                                                       
                                   
-- select dbo.FN_GetFirstDayofMonth(getdate())                                    
                                    
--如果期末数据已审，则不能弃审                      
if isnull(@FIsAccounted,'') <> ''                                                  
begin                      
   if exists( select 1 from  TMtrLStorageHis                          
              where year(FMonth)=year(@FMonth) and   month(FMonth)=month(@FMonth) and FWhCode=@FWhCode  and FisChk=1)                      
   begin                      
    set @AbortStr= convert(varchar(4),year(  @FMonth ))+'-'+convert(varchar(4),month( @FMonth  ))+' 期末数据已经审核！请先弃审期末数据。'                                              
    return 0                                                   
   end                                                                                                           
end                                
declare @FMinAbortClsDate datetime                                                 
if exists( select * From TInvCostAcctMonthEndClose                                     
                   where Fmonth =dateadd(m,-1,@FMonth) and  isnull(FisClosed,0)=0    )                                    
begin                                              
   set @AbortStr='请先月节'+convert(varchar(4),year( dateadd(m,-1,@FMonth) ))+'-'+convert(varchar(4),month( dateadd(m,-1,@FMonth) ))+' 记录'                                              
   return 0                                                   
end                                                
                                              
/*                                                  
declare @FMonth smalldatetime      ,@FWhCode varchar(10)      ,@FIsAccounted varchar(10)      ,@FEmpCode  varchar(30)                                              
 set @FMonth='2013-02-10 01:05:46'                                              
 set @FWhCode='W00000001'                                              
 set @FIsAccounted=''                                             
 set @FMonth=dbo.Fn_GetFirstDayofMonth(@FMonth)                                            
select @FMonth     */                                        
                      
 --   select * from TInvCostAccounting  where Fmonth=@Fmonth                                            
       
                                       
                               
declare  @AccountingType int   , @SlIOType varchar(20)                                     
select @AccountingType  =FParamValue From TParamsAndValues where FParamCode='01050301'    print @AccountingType              
                            
select                     
inM.FWhinCode as FBillCode ,inDL.Fprice,inDL.F_ID , isnull(dbo.Fn_GetOutSourceWhInCostPrice(inDL.F_ID),0) as FAccountingPrice,                             
isnull( inDL.FMainQty,0)  as FMainQty                                              
,isnull( case when isnull(dbo.Fn_GetOutSourceWhInCostPrice(inDL.F_ID) ,0)=0 then stg.FLstPrice*inDL.FMainQty else dbo.Fn_GetOutSourceWhInCostPrice(inDL.F_ID)*inDL.FMainQty end ,0)  as FAmt                                                       
,inv.FinvCode ,inM.FinDate as Fdate       ,inM.FWhCode  , 1055 as FormID ,'BillEx' as BillType   ,'FBillCode' as ParameterFLDs    ,'{80ABD574-3465-4E04-9389-4FF9C28EFF83}' as FWindowsFID                                        
,invTp.FinvTypeName ,ioTp.FinOutTypeName ,inDL.FinvName,inDL.FGoodCode,inDL.FColorCode,inv.Fnote as FinvNote                                                        
,Wh.FWhName  , inM.FChkTime   ,0.000000 as FOutCost   ,case when isnull(indl.Fprice,0)=0 then 1 else 0 end as FPriceIsEstimated,stg.FLstPrice                                            
,inM.FinOutTypeCode   ,inM.FFnIschk   , inDL.FPackageQty   , dbo.fn_GetExpensesApportion(inDL.F_ID ) as FExpensesApportion                                 
 into  #itemIn                                                                                                  
From Twhin inM                                                                                                   
join Twhindl inDL   on inM.FWhinCode=inDL.FWhinCode                                                          
join Tinventory inv on inv.FinvCode=inDL.FinvCode                                                            
left join Tunit ut  on ut.FunitCOde=inv.FmainUnitCOde                                                        
left join Tinvtype invTp  on invTp.FinvTypeCode=inv.FinvTypeCode                                
left join TinoutType ioTp on ioTp.FinOutTypeCode =inM.FinOutTypeCode                                                        
left join TWareHouse wh   on Wh.FWhCode=inM.FWhCode   and wh.FNeedCostAccounting=1                                                    
left join TMtrLStorage stg on stg.FinvCode=inv.FInvCode  and stg.FWhCode=inM.FWhCode                                          
where inM.FisChk=1     and inM.FWhCode like @FWhCode                                                                               
and   dbo.Fn_MonthEqual(inM.FinDate ,  @FMonth)=1   and  isnull(inM.FWhCode,'')       = @FWhCode                                                    
                                            
select                                                                          
OutM.FWhOutCode,OutDL.Fprice ,OutDL.F_ID , null as FAccountingPrice ,                                                   
isnull( OutDL.FOutQty ,0)  as FMainQty    ,isnull(OutDL.Fprice*OutDL.FOutQty  ,0)   as FAmt                                                         
,inv.FinvCode ,OutM.FOutDate as Fdate   , OutM.FWhCode   , 1054 as FormID ,'BillEx' as BillType ,'FBillCode' as ParameterFLDs  , '{553E4ABD-BE4E-4F92-82CE-3C5411F8ED23}' as FWindowsFID                                                          
,invTp.FinvTypeName ,ioTp.FinOutTypeName ,OutDL.FinvName,OutDL.FGoodCode,OutDL.FColorCode,inv.Fnote as FinvNote                                                                                             
,Wh.FWhName       , OutM.FChkTime  ,0.000000 as FOutCost   ,0 as FPriceIsEstimated,0 as FLstPrice                                          
,OutM.FinOutTypeCode  ,OutM.FFnIschk   ,OutDL.FPackageQty  ,0 as FExpensesApportion               
                    
into  #itemOut                                                
from TwhoutM   OutM                                                  
join TwhOutdl  OutDL on OutM.FWhOutCode=OutDL.FWhOutCode                                                      
join Tinventory inv on inv.FinvCode=OutDL.FinvCode                                                                                                  
left join Tunit ut  on ut.FunitCOde=inv.FmainUnitCOde                                                                                               
left join TMtrLStorage stg on OutDl.FinvCode=stg.FinvCode    and stg.FWhCode=OutM.FWhCode                                                                                      
left join Tinvtype invTp  on invTp.FinvTypeCode=inv.FinvTypeCode                                                        
left join TinoutType ioTp on ioTp.FinOutTypeCode =OutM.FinOutTypeCode                                                        
left join TWareHouse wh   on Wh.FWhCode=OutM.FWhCode     and wh.FNeedCostAccounting=1                                 
where OutM.FisChk=1    and   OutM.FWhCode like  @FWhCode                      
and   dbo.Fn_MonthEqual(OutM.FOutDate ,@FMonth)=1 and  isnull(OutM.FWhCode,'') = @FWhCode                                      
                                      
   /*                                  
if exists(  select * from ( select FFnisChk from #itemIn union select FFnisChk from #itemOut )as T where isnull( FFnisChk  ,0)=0 )                                    
begin                                    
  set @Warningstr='有记录未财务审核，不能成本核算。'                                    
  return 0                                    
end */                                               
                                                 
create table #Items                                            
( id int identity(1,1),                                             
FBillCode varchar(50),Fprice decimal(15,6),F_ID varchar(50),FAccountingPrice decimal(19,6),FMainQty decimal(19,4), FAmt decimal(19,4)
,  FinvCode varchar(30),Fdate smalldatetime ,FWhCode varchar(50),FormID int ,BillType varchar(6),ParameterFLDs varchar(300),FWindowsFID varchar(50)
,FinvTypeName varchar(50),                        
FinOutTypeName varchar(50),FinvName varchar(50),FGoodCode varchar(50),FColorCode varchar(50),FinvNote varchar(200),                                            
FWhName varchar(50),FChkTime datetime,FOutCost decimal(15,6),FPriceIsEstimated int,FLstPrice decimal(15,6)  ,FinOutTypeCode varchar(50)                                       
,FFnIschk bit                                         
,FPackageQty decimal(19,4),FQty decimal(22,6),FAmount decimal(22,6),FBalanceAmt decimal(22,6),FBalanceQty decimal(22,6)
,FBalancePkgQty decimal(22,6), FIsIn int                                            
,FNote varchar(200), FisLastRow bit  ,RowIndex int  , FEstimatedPrice decimal(22,6) , FExpensesApportion  decimal(22,6)       
CONSTRAINT PK_tmpIOItems PRIMARY KEY (FWhCode,FinvCode,Fdate,FChkTime,id)                                               
)                                            
                                               
insert  into #Items                                            
select  FBillCode,Fprice ,F_ID , FAccountingPrice ,FMainQty    , FAmt     ,FinvCode ,Fdate   , FWhCode   , FormID , BillType 
,ParameterFLDs,FWindowsFID  ,FinvTypeName ,FinOutTypeName ,FinvName,FGoodCode,FColorCode,FinvNote                                                                                             
,FWhName       , FChkTime  , FOutCost   , FPriceIsEstimated, FLstPrice              ,FinOutTypeCode  ,FFnIschk                              
,FPackageQty,FmainQty as FQty ,FAmt as FAmount ,0.0000000 as FBalanceAmt ,0.0000000 as FBalanceQty ,0.000000 as FBalancePkgQty                 
,1 as FIsIn ,' ' as FNote ,0 as FisLastRow     ,0 as RowIndex    ,nu
ll as FEstimatedPrice  ,FExpensesApportion                                  
from #itemIn                                            
union all                                            
select FWhOutCode,Fprice ,F_ID ,FAccountingPrice , FMainQty    , FAmt      ,FinvCode ,Fdate   , FWhCode   , FormID , BillType                                                          
,ParameterFLDs,FWindowsFID  ,FinvTypeName ,FinOutTypeName ,FinvName,FGoodCode,FColorCode,FinvNote                                                                                             
,FWhName       , FChkTime  , FOutCost   , FPriceIsEstimated, FLstPrice          ,FinOutTypeCode  ,FFnIschk                              
,-1*FPackageQty ,-1*FmainQty as FQty ,-1*FAmt as FAmount ,0.000000 as FBalance ,0.0000000 as FBalanceQty ,0.000000 as FBalancePkgQty                 
, 0 as FIsIn ,' ' as FNote ,0 as FisLastRow  ,0 as RowIndex ,null as FEstimatedPrice   ,null as FExpensesApportion              
from #itemOut                                            
order by Fdate, FChkTime                                            
           
                                            
delete TInvCostAccounting from TInvCostAccounting  InvAct   where year(FMonth)=year(@FMonth) and   month(FMonth)=month(@FMonth) and FWhCode=@FWhCode                                                   
delete TMtrLStorageHis    where year(FMonth)=year(@FMonth) and   month(FMonth)=month(@FMonth) and FWhCode=@FWhCode                                       
declare @FinvCode varchar(20),@FAmount decimal(19,4) ,@FStoragePkgQty decimal(19,4),@FStgAmt decimal(19,4),@FQty decimal(19,4),@FMainQty decimal(19,4)          
 ,@FAvgPrice decimal(19,6) ,@FRevisedPrice decimal(19,6)   ,@FOutCost  decimal(19,6)   ,@FSLRtnTypeCode varchar(30)      
 ,@FSumInAmount decimal(19,6), @FSumInQty decimal(19,6)    ,@FExpensesApportion  decimal(19,6)         
           
 select  @FSLRtnTypeCode = FParamValue  From TParamsAndValues where FParamCode='010102'       print @FSLRtnTypeCode                           
                                
if isnull(@FIsAccounted,'') = ''                                                  
begin                                                  
  if @AccountingType = 1                                                
  begin  /*                      
     declare @FinvCode varchar(20),@FAmount decimal(19,4) ,@FStoragePkgQty decimal(19,4),@FStgAmt decimal(19,4),@FQty decimal(19,4),@FMainQty decimal(19,4) ,@FAvgPrice decimal(19,6) ,@FRevisedPrice decimal(19,6)   ,@FOutCost  decimal(19,6)   ,@FSLRtnType
   
   
      
        
Code varchar(30)          
      , @FMonth smalldatetime , @RowIndex int   , @FWhCode varchar(10) ,@FSumInAmount decimal(19,6), @FSumInQty decimal(19,6)                                             
     select  @FSLRtnTypeCode = FParamValue  From TParamsAndValues where FParamCode='010102'       print @FSLRtnTypeCode          
     set @FMonth='2013-2-01'               set @FWhCode='W00000001'      */          
               
     declare cursor1 cursor for                                                     
     select distinct   FinvCode from #Items  -- where Finvcode='inv00000800'   --- order by Fdate,FChkTime                                          
     open cursor1                                                                   
        fetch next from cursor1 into @FinvCode                              
        while @@fetch_status=0                                                       
        begin                                            
          set @FAmount =0   set @FQty=0       set @RowIndex=0   set @FStoragePkgQty=0   set   @FRevisedPrice=0                       
                                                   
          select                         
           @FAmount=isnull( isnull(FRevisedPrice*isnull(FRevisedStorage,FStorage),FAmt) ,0)                         
          ,@FQty = isnul
l( FRevisedStorage,FStorage)                          
          ,@FStoragePkgQty =isnull( isnull( FRevisedPkgStorage,FStoragePkgQty),0)               
          ,@FRevisedPrice= isnull( FRevisedPrice ,FAvgPrice)                 
           from TMtrLStorageHis where FMonth=DATEADD(m,-1,@FMonth) and FInvCode= @FinvCode  and FWhCode= @FWhCode                             
                                 
           select  @FAmount, @FQty, @FStoragePkgQty ,@FinvCode  ,DATEADD(m,-1,@FMonth) ,@FStoragePkgQty                    
          -- select * from TMtrLStorageHis where Finvcode='Inv00003445'          
          -- select A. FOutcost, b. FAvgPrice  from #Items A join TMtrLStorage B on A.FinvCode=B.FinvCode and A.FWhCode=B.FWhCode  and A.FinOutTypeCode='011201' and A.FInvCode ='Inv00000800'          
          -- select FOutcost,FQty,Famt from #Items    where FInvCode ='Inv00000800'    and FIsIn = 1          
          
          --销售退货 取期初成本                          
          if  @FQty>0                    
          update #Items  set FOutcost=@FAmount/ @FQty       where FInvCode =@FinvCode and FinOutTypeCode=@FSLRtnTypeCode and @FQty>0           
          --销售退货 取最新进价          
          update #Items set FOutcost= FAvgPrice  from #Items A join TMtrLStorage B on A.FinvCode=B.FinvCode and A.FWhCode=B.FWhCode and isnull( A.FOutCost,0)=0 and A.FinOutTypeCode=@FSLRtnTypeCode and A.FInvCode =@FinvCode          
          select @FSumInAmount=SUM(case when  isnull(FOutcost,0)=0 then Famt else FOutcost*FQty end ) from #Items    where FInvCode =@FinvCode    and FIsIn = 1    print '@FSumInAmount' print @FSumInAmount          
          select @FSumInQty   =SUM(FQty) from #Items    where FInvCode =@FinvCode    and FIsIn = 1                                        print '@FSumInQty'    print @FSumInQty          
                  
             select @FAvgPrice= (isnull(@FSumInAmount,0)+ isnull( @FAmount,0) )/ (isnull( @FSumInQty,0) + isnull( @FQty,0) )                                                                     print '@FAvgPrice'   print @FAvgPrice           
          update #Items  set FOutcost=@FAvgPrice       where FInvCode =@FinvCode and FIsIn=0           
                    
          --update estimated price  when in price is 0                
          update #Items set                             
           @FQty= ISNULL(@FQty,0)+isnull(FQty ,0)       ,@FStoragePkgQty=isnull(@FStoragePkgQty,0)+ isnull(FPackageQty,0)                                            
          ,@FAmount=@FAmount+ case when ISNULL(FOutCost,0)=0 then  FAmount else Fqty*FoutCost end                 ,FBalanceQty=isnull(@FQty,0)                                      ,FBalanceAmt=isnull(@FAmount,0)                                            
  
    
     
          ,FBalancePkgQty=@FStoragePkgQty               ,FisLastRow =case when A.id =isnull( (select MAX(id) from  #Items where FinvCode =A.FinvCode ),0) then 1 else 0 end                               
          ,RowIndex=@RowIndex                           ,@RowIndex=@RowIndex+1                 
          from #Items A                                            
          where FInvCode =@FinvCode  and FWhCode= @FWhCode         
                                                                
          fetch next from cursor1 into @FinvCode                                              
        end                                            
     close cursor1                                                               
     deallocate cursor1                 
               
     --select * from #Items where FInvCode ='Inv00003445' order by RowIndex           
                                                 
  end                                               
  if @AccountingType = 2                                              
  begin                                                   
/*                                            
     selec
t  isnull(FRevisedPrice*FRevisedStorage,FAmt) , isnull( FRevisedStorage,FStorage) , isnull( FRevisedPkgStorage,FStoragePkgQty)                        
     , FAmt,FStorage , FStoragePkgQty,Finvcode ,FMonth,FWhCode from TMtrLStorageHis    where Finvcode='Inv00001001' and fmonth='2013-01-01'              
     select * from #Items                                            
     select * from TInvCostAccounting where FMonth='2013-2-01'                      
     declare  @AccountingType int   , @SlRtnIOType varchar(20) ,@SlIOType varchar(20)                                     
     select @AccountingType  =FParamValue From TParamsAndValues where FParamCode='01050301'                                                
     select @SlRtnIOType =FParamValue From TParamsAndValues where FParamCode='010102'                                         
     declare @FinvCode varchar(20),@FWhCode varchar(20),@FAmount decimal(19,4) ,@FStgAmt decimal(19,4),@FQty decimal(10,4),@FMainQty decimal(19,4), @FMonth smalldatetime ,@FAvgPrice decimal(19,6)   ,@FStoragePkgQty decimal(19,6)  ,@RowIndex int          
   
                                      
     set @FMonth='2013-2-01'               set @FWhCode='W00000001'    */               
                                                 
     declare cursor2 cursor for                                                     
     select distinct   FinvCode from #Items --- order by Fdate,FChkTime                                          
     open cursor2                                                                   
        fetch next from cursor2 into @FinvCode                              
        while @@fetch_status=0                                                       
        begin                                            
          set @FAmount =0   set @FQty=0       set @RowIndex=0                            
                                                   
          select                         
           @FAmount=isnull(FRevisedPrice*isnull(FRevisedStorage,FStorage),FAmt)                         
          ,@FQty =isnull( FRevisedStorage,FStorage)                          
          ,@FStoragePkgQty =isnull( FRevisedPkgStorage,FStoragePkgQty)             
          ,@FRevisedPrice= FRevisedPrice                  
           from TMtrLStorageHis where FMonth=DATEADD(m,-1,@FMonth) and FInvCode= @FinvCode  and FWhCode= @FWhCode                             
                                
          select  @FAmount, @FQty, @FStoragePkgQty ,@FinvCode  ,DATEADD(m,-1,@FMonth)                     
                                              
          set @FAmount=isnull(@FAmount,0)                                             
          set @FQty  =isnull(@FQty ,0)                     
          set @FStoragePkgQty=isnull(@FStoragePkgQty, 0)                                            
          select  @FAvgPrice=case when isnull(@FRevisedPrice,0)<>0 then @FRevisedPrice               
                                  when @FQty<>0 then @FAmount/@FQty else null end                
          set @FOutCost= @FAvgPrice                                                                  
          print   '@FAvgPrice='+convert(varchar(20),  @FAvgPrice)                                            
          print @FAmount print @FQty print @FinvCode    print @FAvgPrice                           
                                       
          --update estimated price  when in price is 0                
          update #Items set               
          FEstimatedPrice=case when isnull(Fprice,0)=0 THEN @FAvgPrice ELSE null END ,                
          FAmt=   case  when isnull(FAmt,0)=0 then  FMainQty*@FAvgPrice  else FAmt end ,              
          FAmount=case  when isnull(FAmt,0)=0 then  FMainQty*@FAvgPrice  else FAmt end              
          where FInvCode =@FinvCode and  Fisin=1 and isnull(Fprice,0)=0  and FWhCode= @FWhCode          
      
                
          update #Items set                                      
           @FAvgPrice=--case when FPrice=0 then FEstimatedPrice else FPrice end--              
            case when   @FQty<>0  then @FAmount/@FQty else null end                
          ,@FOutCost =@FAvgPrice                                         
          ,@FQty= ISNULL(@FQty,0)+isnull(FQty ,0)                                            
          ,@FStoragePkgQty=isnull(@FStoragePkgQty,0)+ isnull(FPackageQty,0)                                            
          ,@FAmount=@FAmount+  case when Fisin=0  then FQty*isnull(@FAvgPrice ,0)                  
                            when FinoutTypeCode=@FSLRtnTypeCode then FQty*isnull(@FAvgPrice ,Fprice)                  
                            else FAmount + isnull(FExpensesApportion, 0) end                          
                  
          ,FBalanceQty=isnull(@FQty,0)                                               
          ,FBalanceAmt=isnull(@FAmount,0)                                                
          ,FOutCost=  isnull(@FOutCost,0)                                               
          ,FBalancePkgQty=@FStoragePkgQty                                            
          ,FisLastRow =case when A.id =isnull( (select MAX(id) from  #Items where FinvCode =A.FinvCode ),0) then 1 else 0 end                               
          ,RowIndex=@RowIndex                              
          ,@RowIndex=@RowIndex+1                 
          from #Items A                                            
          where FInvCode =@FinvCode and ISNULL(FQty,0) <>0 and FWhCode= @FWhCode                                           
                                                      
          fetch next from cursor2 into @FinvCode                                              
        end                                            
     close cursor2                                                               
     deallocate cursor2                                                                                      
  end                                     
          
     insert into TInvCostAccounting                                                         
     (FInvCode,FOriPrice,FBillCode, BillType, FormID, ParameterFLDs,FWindowsFID 
     ,FQty,F_ID,FAccountingPrice,FDate, FWhCode   ,FMonth ,FChkTime , FIsAccounted ,FoutCost                                        
     ,Fisin,FBalanceQty,FBalanceAmt,Findex ,FBalancePkgQty  ,FisLastRow ,FinOutTypeCode ,FPackageQty ,FAmt ,RowIndex,FEstimatedPrice  ,FExpensesApportion)                                                
     select                                                     
     FInvCode,FPrice,FBillCode , BillType, FormID,   ParameterFLDs,FWindowsFID 
     ,FMainQty,F_ID,FAccountingPrice,FDate, FWhCode ,dbo.FN_GetFirstDayofMonth(FDate)  ,FChkTime ,     1  ,FoutCost                                         
     ,Fisin,FBalanceQty,FBalanceAmt , id  ,FBalancePkgQty  ,FisLastRow  ,FinOutTypeCode  ,FPackageQty  ,FAmt ,RowIndex  ,FEstimatedPrice ,FExpensesApportion                                 
     from #Items [io]                                             
                              
      --当月无出入库，取上月月节数据                                    
     insert into TMtrLStorageHis(f_ID,FCreateEmp,FCreateTime ,FMonth,FStorage,FStoragePkgQty,FInvCode,FWhCode, FAvgPrice,  FIsChk,FChkTime,FChkEmp,FAmt,FRevisedPkgStorage,FRevisedPrice,FRevisedStorage,FCostInaccuracy)                           
     select                                     
     newid(),FCreateEmp,getdate() ,@Fmonth,FStorage,FStoragePkgQty,FInvCode,FWhCode, FAvgPrice,  0,getdate() ,FChkEmp,FAmt ,FRevisedPkgStorage,FRevisedPrice,FRevisedStorage,FCostInaccuracy                                   
     from  TMtrLStorageHis where Fmonth=dateadd(m,-1,@Fmonth) and FWhCode=@FWhCode and                            
    
 not exists(select * from TInvCostAccounting io                             
                where  io.Fwhcode=TMtrLStorageHis.FwhCode      and io.FInvCode=TMtrLStorageHis.FInvCode  and   FMonth=@FMonth   )                               
                                              
     --有出入库取核算明细                                    
     insert into TMtrLStorageHis       (F_ID,FMonth,FInvCode,FWhCode,FAvgPrice,FStorage,FStoragePkgQty,FAmt,FIsChk,FChkTime,FChkEmp)                                      
     select                                       
     newid(),FMonth,FInvCode,FWhCode, FBalanceAmt/FBalanceQty ,FBalanceQty,FBalancePkgQty, FBalanceAmt,0, getdate() ,FAccountEmp                                      
     from TInvCostAccounting where FisLastRow=1 and FMonth=@FMonth   and FBalanceQty>0     and FWhCode=@FWhCode                                                
end            
                                                 
                                                    
drop table #Items                                            
drop table #itemIn                                                
drop table #itemOut                                 
 ------------------------------------------------------------------------------------ 
