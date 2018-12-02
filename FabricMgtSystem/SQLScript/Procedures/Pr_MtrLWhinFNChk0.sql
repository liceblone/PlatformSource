drop proc Pr_MtrLWhinFNChk0
go 
			  
CREATE proc Pr_MtrLWhinFNChk0                                                                
@abortstr varchar(100) output ,                                                                                            
@FWhinCode varchar(20),                                                                                      
@empid varchar(20)     ,                                                                              
@longinID  varchar(20)                                                                                    
                                                                           
as                                                                
/*                                                          
declare @P1 varchar(100) set @P1='' exec Pr_MtrLWhinChk0 @P1 output, 'MLi00000075', 'E000010', 'chy' select @P1                                                  
                                                  
2009-12-29 加事务   本单的明细库为0 也删除                                                          
2010-1-1   弃审时检查现存量，限定为当前单据                                                        
2010-4-3  平均单价= （现平均单价*现存量+ 入库单价*入库数量）/（现存量+入库数量）     改成  平均单价    =  （现平均单价*现存量+ 入库单价*入库数量）/（现存量）      --2010-4-3  仓库审核再财务审核不需要加本单数量                                          
 --2010-4-4改成left join                                
2010-7-15 只对需要更新成本的入库类型进行计算成本价                          
2011-4-12 只对数量大于0的材料更新成本价 和 最新单价                          
*/                                                                   
declare @error int                                                 
declare @FGlCCode varchar(100)                                               
declare @FistDebitCredit int                                           
declare @FNeedUpdateCost bit                   
declare @FWhCode varchar(50)                     
declare @errmsg varchar(50)                     
                                             
set @error =0  set @abortstr=''                                                                                                  
set @errmsg=''                        
                                                   
if not exists(select *    from TWhin M where  FWhinCode=@FWhinCode and FisChk=1 )                                          
begin                                              
   set @abortstr='只能对已审核出库单操作.'                                                  
   return 0                                              
end                                          
if not exists(select *     from TWhin M where FWhinCode=@FWhinCode and FFnisChk=1 )                                           
begin                                              
   set @abortstr='出库单已经被弃审，请先刷新.'                       
   return 0                                              
end                                          
if   exists( select *     from TWhindl where FWhinCode=@FWhinCode and FReconciled=1 )                                           
begin                                              
   set @abortstr='该单有明细已经对帐，请先刷新.'                       
   return 0                                              
end                                          
                          
if exists( select *  from TWhin M                                                
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                                                
           where M.FWhinCode= @FWhinCode and ( isnull(FGlCCode,'')='' or isnull(FistDebitCredit,'')='') )                                                
begin                                                
   set @abortstr='请先设置出入库类型对应的科目.'                                                    
   return 0                                                
end                       
            
if exists( select * from TInvCostAccounting  where  FbillCode=@FWhinCode )            
begin     
       
   set @abortstr='已经成本核算不能弃审.'                                                    
   return 0                                             
end              
            
            
      
select @FGlCCode  =FGlCCode,@FistDebitCredit=convert(int,FistDebitCredit) ,@FNeedUpdateCost =iotp.FNeedUpdateCost                                          
           from TWhin M                                                
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                                                
           where M.FWhinCode= @FWhinCode            
                                                  
BEGIN TRY            
begin tran          
                                                 
--更新标志                                                  
update TWhin set FFNischk=0   where FWhinCode=  @FWhinCode                                                                                 
set @error =@error +@@error                                                     
                                                      
--删除应收应付                                         
delete TPayReceiveAble where FBillCode=@FWhinCode                                              
set @error =@error +@@error                                                    
                                          
--get wh items                
select cdl.FinvCode ,cM.FWhCode ,cM.FinDate ,cdl.FpurchOrdCode  into #CurWhDL                  
from   Twhindl cdl   join   Twhin cM on cdl.FWhinCode=cM.FWhinCode                   
where  cM.FWhinCode=@FWhinCode                  
set @error =@error +@@error                                                             
                
select                   
M.FWhinCode,dl.FinvCOde,M.FWhCode ,M.FinDate,M.FCreateTime,M.FinOutTypeCode,DL.FPrice, DL.FMainQty as FinQty ,dl.FPackageQty as FinPkgQty ,DL.FpurchOrdCode                      
into  #iTmp                  
from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                     
join  #CurWhDL as Cur on Cur.FinvCode=Dl.FinvCode and Cur.FWhCode=M.FWhCode                  
where M.FFNischk=1                   
set @error =@error +@@error                                                                          
                
--更新最新单价                                      
update TMtrLStorage set FLstPrice=isnull(FPrice,0)                           
--  select *                    
    from TMtrLStorage A                                                                      
    left  join (select DL.FinvCOde,  isnull(DL.FPrice,0)  as FPrice   ,DL.FWhCode                  
                from #iTmp DL                
                join (select Max(FInDate)as FInDate ,Max(FCreateTime) as FCreateTime,FInvCode , FWhCode                   
                      from #iTmp                
                      group by FInvCode ,FWhCode                  
                     )as LstInv on LstInv.FinvCode  =DL.FinvCode                 
                               and LstInv.FInDate  =DL.FinDate                   
                               and LstInv.FCreateTime =DL.FCreateTime                
                where  isnull(DL.FPrice,0) <>0                        ---and M.FinDate =(select Max(FinDate ) from  Twhin where FFnischk=1   )                                      
               )AS B ON A.FinvCode=B.FinvCode  and A.FWhCode= B.FWhCode                 
     where  exists  (select FinvCOde from #CurWhDL where   FinvCode=A.FinvCOde and FWhCode=A.FWhCode)                    
set @error =@error +@@error                                                                  
                                                   
--更新入库数前更新  跟弃审 做相反的处理    平均单价   =  （现平均单价*现存量+ 入库单价*入库数量）/（现存量+入库数量）                                                    
-- select (  isnull(A.FAvgPrice,B.FPrice ) *isnull(A.Fstorage ,0)+ B.FMainQty*B.FPrice ) / (   isnull(A.Fstorage,0)+isn
ull(B.FMainQty,0)   )   --,  isnull(A.FAvgPrice,B.FPrice ) ,isnull(A.Fstorage ,0), B.FMainQty,B.FPrice                                 
   
   
      
         
                   
if @FNeedUpdateCost=1                                     
begin                                                  
    declare @NYearForPriceAVg int                        
    select  @NYearForPriceAVg =isnull(FParamValue,1)-1  From TParamsAndValues where FParamCode='010601'                        
                                   
    select FinvCOde, sum(isnull(FinQty,0)) as FMainQty , sum (isnull(FPrice,0)*FinQty)as Famt   ,FWhCode                   
    into #AvgPrice                        
    from #iTmp   DL                
    where  isnull(FPrice,0) <>0                                 
    and   FinOutTypeCode in (select FinOutTypeCode from TinOutType where FNeedUpdateCost=1)                         
    and   exists            (select FinvCOde from #CurWhDL where       FinvCode=DL.FinvCode )                  
    and   datediff(m, convert(smalldatetime,convert(varchar(4),year(FinDate)) +'-'+convert(varchar(4),month(FinDate))+'-01') ,Getdate())<= @NYearForPriceAVg                 
    group by FinvCOde ,FWhCode    --,FinDate                
    set @error =@error +@@error                    
                 
    update A set A.FAvgPrice=case when (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))=0 then 0 else   (  isnull(A.FUltimoPrice,0) *(isnull(A.FUltimoBalce ,0)  ) + isnull(Famt,0) ) / (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))  end             
   
    -- select   (  isnull(A.FUltimoPrice,0) *(isnull(A.FUltimoBalce ,0)  ) + isnull(Famt,0) ) / (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))    ,*                
    from TMtrLStorage A                                                                      
    left join (select FinvCOde,   Famt      ,FMainQty  ,FWhCode                  
          from #AvgPrice                         
         )AS B ON A.FinvCode=B.FinvCode   and A.FWhCode=B.FWhCode                                                
     where exists   ( select FinvCOde from #CurWhDL where      FinvCode= A.FinvCOde and FWhCode=A.FWhCode)                                                           
     set @error =@error +@@error   
       
     drop table #AvgPrice                                                            
end                 
                                  
    
    
update TCltVdBookkeeping set FDebtAmt=isnull(B.FInvoiceAmt  ,Famt)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0)                                           
from TCltVdBookkeeping  A                                                            
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                                            
where A.FCltVdCode =(select FVendorCode from TWhin where FWhinCode=@FWhinCode  )            
set @error =@error +@@error      
    
                                          
                                          
/*                                            
delete  TPayReceiveAble   where FBillCode=@FWhinCode    --应收 应付                                      
set @error =@error +@@error                                                       
update TCltVdBookkeeping set FDebtAmt =isnull(B.Famt,0)                                              
from TCltVdBookkeeping A                                              
left join ( select sum(Famt) as  Famt,FcltVdCode  From TPayReceiveAble where  FcltVdCode=(select FVendorCode from TWhin where FWhinCode=@FWhinCode  )  group by FcltVdCode )as B                                              
      on A.FcltVdCode=B.FcltVdCode                                              
set @error =@error +@@error                       
  */                         
drop table #
iTmp                          
drop table #CurWhDL        
      
commit            
END TRY            
BEGIN CATCH            
    -- Execute error retrieval routine.            
    EXECUTE usp_GetErrorInfo;            
    if @abortstr=''                                                         
       set @abortstr='弃审失败'      +convert(varchar(20),@error)                                
    rollback                                                               
    return 0               
END CATCH;             
return 1         
                                             
                                                      
                                                       
                                                              
                                                                                            
 ------------------------------------------------------------------------------------ 
