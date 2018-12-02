
alter proc Pr_MtrLWhoutFNChk1                                        
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
declare @FShRpCode    varchar(100)                  
declare @FistDebitCredit int              
set @error =0                              
set @abortstr=''                      
set @ErrMsg=''                        
                  
                      
if not exists(select *                  
           from TWhOutM M where FisChk=1 and FWhOutCode= @FWhOutCode  )              
begin                  
   set @abortstr='请先审核出库单,再做核算.'                      
   return 0                  
end              
if  exists(select *                  
           from TWhOutM M where FFnisChk=1 and FWhOutCode= @FWhOutCode  )              
begin                  
   set @abortstr='该已经被审核，请先刷新.'        
   return 0                  
end              
      
if exists( select *                  
           from TWhOutM M                  
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                  
           where M.FWhOutCode= @FWhOutCode and ( isnull(FGlCCode,'')='' or isnull(FistDebitCredit,'')='') )                  
begin                  
   set @abortstr='请先设置出入库类型对应的科目.'                      
   return 0                  
end    /*  */                
              
select @FGlCCode  =FGlCCode,@FistDebitCredit=convert(int,FistDebitCredit)              
           from TWhOutM M                  
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                  
           where M.FWhOutCode= @FWhOutCode                   
                                
begin tran                              
    
 update TWhOutdl   set Fprice=0   where  isnull(FTaxPrice,0)=0 and isnull(Fprice,0)=0 and FWhOutCode= @FWhOutCode    
 set @error =@error +@@error                          
 update TWhOutdl   set FTaxPrice= Fprice*(1+FTaxRate/100)   where  isnull(FTaxPrice,0)=0 and FWhOutCode= @FWhOutCode    
 set @error =@error +@@error                          
 update TWhOutdl   set Fprice   = FTaxPrice/(1+FTaxRate/100)  where  isnull(Fprice,0)=0 and FWhOutCode= @FWhOutCode    
 set @error =@error +@@error                   
--置标志                                        
update TWhOutM set FFNischk=1     
,FInvoiceAmt=(select sum(FTaxPrice*FOutQty)from TWhOutdl where FWhOutCode=  @FWhOutCode  )     
,FTax =(FTaxRate/100)*(select sum(FTaxPrice*FOutQty)from TWhOutdl where FWhOutCode=  @FWhOutCode  ) /(1+FTaxRate/100)    
where  FWhOutCode=  @FWhOutCode           
set @error =@error +@@error                        
              
EXEC PrSys_GetBillCode @FShRpCode OUTPUT,601                                          
set @error =@error +@@error                
            
--应收应付              
insert into TPayReceiveAble      (              
  FShRpCode, FCreateEmp,FCreateTime,FGlCCode,FDate,FClerkEmp,FNote,FCltVdCode,FisClt,FBillCode,FisSys,FModalType,FFormID,Famt,FisChk,FChkEmp,FChkTime ,FTaxRate,FInvoiceAmt,FTax)              
select @FShRpCode,@empid,getdate(),@FGlCCode ,    FOutDate,FOutEmp,FNote,FcltVdCode,FisClt,FWhoutCode,1,   'BillEx'  ,1042,@FistDebitCredit*Famt,1,@empid,getdate()  ,m.FTaxRate,m.FInvoiceAmt,m.FTax   from  TWhOutM  m where  FWhOutCode=  @FWhOutCode       
                      
set @error =@error +@@error                        
              
--加客户名              
if not exists(select *from TCltVdBookkeeping where FcltVdCode =(select FcltVdCode from TWhOutM where    FWhOutCode=  @FWhOutCode  ))              
insert into TCltVdBookkeeping (FcltVdCode,FisClt,F_ID) select FcltVdCode,FisClt,newid() from TWhOutM where    FWhOutCode=  @FWhOutCode                
              
--更新余额表              
update TCltVdBookkeeping set FDebtAmt=isnull(B.FAmt  ,0)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0) --2010-4-4改成left join                        
from TCltVdBookkeeping  A                                  
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode   
where A.FCltVdCode= (select FCltVdCode from TWhOutM where FWhOutCode=@FWhOutCode )           
set @error =@error +@@error                                            
  
--sp_help TCltVdBookkeeping              
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
                        
              
 ------------------------------------------------------------------------------------  
 
 go
   
alter proc Pr_MtrLWhoutFNChk0                                         
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
update TCltVdBookkeeping set FDebtAmt=isnull(B.FAmt  ,0)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0) --2010-4-4改成left join                        
from TCltVdBookkeeping  A                                  
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                  
where A.FCltVdCode= (select FCltVdCode from TWhOutM where FWhOutCode=@FWhOutCode )           
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
                          
            
          
          
        
 ------------------------------------------------------------------------------------  
 