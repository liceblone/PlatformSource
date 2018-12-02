drop proc Pr_MtrLWhinChk0
go 
  CREATE proc Pr_MtrLWhinChk0                    
@abortstr varchar(100) output ,                                                                          
@FWhinCode varchar(20),                                                                    
@empid varchar(20)     ,                                                            
@longinID  varchar(20)                                                                  
                                                         
as                                              
/*                                        
declare @P1 varchar(100) set @P1='' exec Pr_MtrLWhinChk0 @P1 output, 'MLi00000075', 'E000010', 'chy' select @P1                                
                                
2009-12-29 加事务   本单的明细库为0 也删除                                        
2010-1-1   弃审时检查现存量，限定为当前单据                                      
2010-4-3   新最价 成本价以 财务核算为准  2010-4-3                      
2010-5-9 弃审会将库存记录删除                   
2011-7-31 依采购订单入库                    
2011-12-56 支持多仓库                
*/                                                 
declare @error int                                        
set @error =0                                        
                                                    
                                             
set @abortstr=''                                          
declare @errmsg varchar(50)                                          
set @errmsg=''                                          
                        
if exists( select *from Twhin  where  isnull( FFNischk,0)=1  and FWhinCode=  @FWhinCode   )                                          
begin                        
  set @abortstr= '财务已经审核，必须先在入库核算界面弃审 '                                           
  return 0                           
end                                        
                                
--如果现存量 不足 提示                                          
select @errmsg='现存量不足'+char(13)+inv.FinvName +' 现存量为'+convert(varchar(30),convert(decimal(15,2),FStorage))                 
               from TMtrLStorage A                                              
               join (select FinvName,FinvCOde,sum(FMainQty) as FinQty ,M.FWhCode from TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                 
                     where  M.FWhinCode=  @FWhinCode and isnull(M.Fischk,0)=1  group by FinvCOde,FinvName,M.FWhCode                
                    )AS B  ON A.FinvCode=B.FinvCode   and A.FWhCode=B.FWhCode                                      
          left join Tinventory inv on inv.Finvcode=A.FinvCode                                          
          where isnull(A.FStorage,0)<isnull(B.FinQty    ,0)                                          
set @error =@error +@@error                                             
                                        
if  @errmsg<>''                                            
begin                                          
  set @abortstr=@errmsg+''+char(13)+'需要将出库记录删除再弃审这张单据 '                                          
  raiserror(@abortstr,16,1)                                             
  rollback                                   
  return 0                                          
end                                        
              
BEGIN TRY                  
begin tran 
                          
--更新标志                                
update TWhin set Fischk=0 ,FchkEmp=null  ,FchkTime=null  where FWhinCode=  @FWhinCode                                                               
set @error =@error +@@error                                   
                                
--取明细   drop table #CurWhDL     drop table #iTmp         
select distinct cdl.FinvCode ,cM.FWhCode ,cM.FinDate ,cdl.FpurchOrdCode ,cdl.FSLOrdCode into #CurWhDL              
from   Twhindl cdl   join   Twhin cM on cdl.FWhinCode=cM.FWhinCode               
where   cM.FWhinCode=
@FWhinCode              
set @error =@error +@@error                                   
           
select               
M.FWhinCOde,dl.FinvCOde,M.FWhCode ,M.FinDate, DL.FMainQty as FinQty ,dl.FPackageQty as FinPkgQty ,DL.FpurchOrdCode  ,dl.FSLOrdCode                
into  #iTmp              
from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                 
--join  #CurWhDL as Cur on Cur.FinvCode=Dl.FinvCode and Cur.FWhCode=M.FWhCode              
where M.Fischk=1       and  exists (select 1 from #CurWhDL as Cur where  Cur.FinvCode=Dl.FinvCode and Cur.FWhCode=M.FWhCode        )      
set @error =@error +@@error                                   
              
--2.汇总入库数量                         
update TMtrLStorage set FinQty=isnull(B.FinQty     ,0)   ,  FinPkgQty=isnull(B.FinPkgQty,0)                                   
--select *                                       
from TMtrLStorage A                                            
left join (               
             select FinvCOde,FWhCode ,sum(isnull(FinQty,0)) as FinQty ,sum(isnull(FinPkgQty,0)) as FinPkgQty from #iTmp               
             group by FinvCOde,FWhCode                
           )AS B ON A.FinvCode=B.FinvCode    and A.FWhCode=B.FWhCode                  
where exists (select 1 from #CurWhDL where FinvCode +FWhCode =  A.FInvCode+A.FWhCode )              
set @error =@error +@@error                                                 
                                              
                        
--1. 删除没出,入库明细的资料                                            
delete TMtrLStorage where  FinvCode not in (select FinvCOde from TWhinDL)  and FinvCode not in (select FinvCode from TWhOutDL)                                            
set @error =@error +@@error                                             
--2. 本单的明细库为0 也删除                                        
--delete TMtrLStorage where  FinvCode  in (select FinvCOde from TWhinDL   where FWhinCode=  @FWhinCode  ) and isnull(FStorage,0)=0     2010-5-9 弃审会将库存记录删除                     
--set @error =@error +@@error                                             
                                       
     
--更新销售订单退货数据                      
update A set A.FSLRtnInQty =B.FMainQty    
--  select *                
from TSaleOrderDL  A                      
left join (                       
           select   dl.FinvCOde, sum( DL.FMainQty ) as FMainQty ,DL.FSLOrdCode                  
           from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                 
           join  #CurWhDL as Cur on Cur.FinvCode=Dl.FinvCode    and cur.FSLOrdCode =dl.FSLOrdCode      
           where M.Fischk=1              
           group by DL.FinvCode,  DL.FSLOrdCode                      
          ) B on A.FinvCode=B.FinvCode and A.FSLOrdCode =b.FSLOrdCode                   
where exists (select 1 from #CurWhDL where FinvCode +FSLOrdCode =  A.FInvCode+A.FSLOrdCode )                   
set @error =@error +@@error       
    
--更新采购订单入库数据                  
update A set A.FinQty=B.FMainQty                  
from TPurchaseOrdDL  A                  
left join (                   
  select   dl.FinvCOde, sum( DL.FMainQty ) as FMainQty ,DL.FpurchOrdCode                  
  from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                 
  join  #CurWhDL as Cur on Cur.FinvCode=Dl.FinvCode     and cur.FPurchOrdCode=dl.FPurchOrdCode     
  where M.Fischk=1              
  group by dl.FinvCode, dl.FpurchOrdCode         
          ) B on A.FinvCode=B.FinvCode and A.FpurchOrdCode =b.FpurchOrdCode                  
where exists (select 1 from #CurWhDL where FinvCode +FpurchOrdCode =  A.FInvCode+A.FpurchOrdCode )               
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
drop table #iTmp                       
drop table #CurWhDL     

commit                  
END TRY                  
BEGIN CATCH                  
    -- Execute error retrieval routine.                  
    EXECUTE usp_GetErrorInfo;                  
    if @abortstr=''                                                               
       set @abortstr='弃审失败'   --  +convert(varchar(20),@error)                                      
    rollback                                                                     
    return 0                     
END CATCH;                   
return 1  
           

