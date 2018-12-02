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
--2010-4-4�ĳ�left join                
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
   set @abortstr='ֻ�ܶ�����˳��ⵥ����.'                          
   return 0                      
end                 
if not exists(select *                      
           from TWhOutM M where FWhOutCode=@FWhOutCode and  FFnisChk=1 )                  
begin                      
   set @abortstr='�õ��Ѿ�����������ˢ��.'                
   return 0                      
end                 
if  exists( select * from TWhOutDL where FWhOutCode=@FWhOutCode and FReconciled=1)                  
begin                      
   set @abortstr='�õ�����ϸ�Ѿ����ʣ�����ˢ��.'                
   return 0                      
end                
              
if exists( select * from TInvCostAccounting  where  FbillCode=@FWhOutCode )        
begin        
   set @abortstr='�Ѿ��ɱ����㲻������.'                                                
   return 0                                            
end          
        
begin tran                                  
       
--���־                                            
update TWhOutM set FFNischk=0 where  FWhOutCode=  @FWhOutCode                                                             
set @error =@error +@@error                            
                  
--ɾ��Ӧ��Ӧ��                  
delete TPayReceiveAble where FBillCode=@FWhOutCode                      
set @error =@error +@@error                            
                  
                  
--��������                                       
update TCltVdBookkeeping set FDebtAmt=isnull(B.FInvoiceAmt  ,b.Famt)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0) --2010-4-4�ĳ�left join                                  
from TCltVdBookkeeping  A                                            
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode           
where A.FcltVdCode =(select FcltVdCode from TWhOutM where    FWhOutCode=  @FWhOutCode  )                                         
set @error =@error +@@error                                               
    
--sp_help TPayReceiveAble                  
-- select *from TCltVdBookkeeping                            
                        
                   
if @error<>0                                   
begin                               
   if  @abortstr=''                             
    set @abortstr='���ʧ��'     +convert(varchar(20),@error)                             
  rollback                                   
  return 0                                  
end                                  
commit                                  
                                
     
return 1                                 
                            
              
  
