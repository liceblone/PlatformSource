drop proc Pr_MtrLWhoutFNChk0
go 
create proc Pr_MtrLWhoutFNChk0                                           
@abortstr varchar(100) output ,                                                                        
@FWhOutCode varchar(20),                                                                  
@empid varchar(20)     ,                                                          
@longinID  varchar(20)                                                                
                                                       
as                                         
/*                            
declare @P1 varchar(100) set @P1='' exec Pr_MtrLWhoutChk1 @P1 output, 'MLO00000073', 'E000010', 'chy' select @P1                              
--2010-4-4改成left join                
*/                            
declare @ErrMsg varchar(200)                            
declare @error int                          
declare @FGlCCode varchar(100)                          
set @error =0                                  
set @abortstr=''                          
set @ErrMsg=''                            
                      
                           
if not exists(select *                      
           from TWhOutM M where FWhOutCode=@FWhOutCode and  FisChk=1 )                  
begin                      
   set @abortstr='只能对已审核出库单操作.'                          
   return 0                      
end                 
if not exists(select *                      
           from TWhOutM M where FWhOutCode=@FWhOutCode and  FFnisChk=1 )                  
begin                      
   set @abortstr='该单已经被弃审，请先刷新.'                
   return 0                      
end                 
if  exists( select * from TWhOutDL where FWhOutCode=@FWhOutCode and FReconciled=1)                  
begin                      
   set @abortstr='该单有明细已经对帐，请先刷新.'                
   return 0                      
end                
              
if exists( select * from TInvCostAccounting  where  FbillCode=@FWhOutCode )        
begin        
   set @abortstr='已经成本核算不能弃审.'                                                
   return 0                                            
end          
        
begin tran                                  
       
--清标志                                            
update TWhOutM set FFNischk=0 where  FWhOutCode=  @FWhOutCode                                                             
set @error =@error +@@error                            
                  
--删除应收应付                  
delete TPayReceiveAble where FBillCode=@FWhOutCode                      
set @error =@error +@@error                            
                  
                  
--更新余额表                                       
update TCltVdBookkeeping set FDebtAmt=isnull(B.FInvoiceAmt  ,b.Famt)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0) --2010-4-4改成left join                                  
from TCltVdBookkeeping  A                                            
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode           
where A.FcltVdCode =(select FcltVdCode from TWhOutM where    FWhOutCode=  @FWhOutCode  )                                         
set @error =@error +@@error                                               
    
--sp_help TPayReceiveAble                  
-- select *from TCltVdBookkeeping                            
                        
                   
if @error<>0                                   
begin                               
   if  @abortstr=''                             
    set @abortstr='审核失败'     +convert(varchar(20),@error)                             
  rollback                                   
  return 0                                  
end                                  
commit                                  
                                
     
return 1                                 
                            
              
  
