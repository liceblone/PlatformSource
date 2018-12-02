drop proc Pr_PayReceiveAbleChk0
go 

      
create proc Pr_PayReceiveAbleChk0    
@abortstr varchar(100) output ,                                                                          
@FPKCode varchar(20),                                                                    
@empid varchar(20)     ,                                                            
@longinID  varchar(20)     
as    
    
declare @error int  , @errmsg varchar(50)                         
set @error =0                                                                                                   
set @abortstr=''                                                 
set @errmsg=''                                                 
                           
      
BEGIN TRY      
begin tran                                                            
    --置标志                                                                  
    update TPayReceiveAble set Fischk=0 ,FchkEmp=null  ,FchkTime=null  where FShRpCode=  @FPKCode    
      
    -- update balance      
    update TCltVdBookkeeping set FDebtAmt=isnull(B.FInvoiceAmt  ,0)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0) --2010-4-4改成left join                            
    from TCltVdBookkeeping  A                                      
    left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum( isnull(FInvoiceAmt,FAmt) )FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                      
    join  TPayReceiveAble AR on AR.FCltVdCode= A.FCltVdCode  and AR.FCltVdCode=   B.FcltVdCode    
    where AR.FShRpCode=  @FPKCode  
      
commit      
END TRY      
BEGIN CATCH      
    -- Execute error retrieval routine.      
    EXECUTE usp_GetErrorInfo;      
    if @abortstr=''                                                   
       set @abortstr='弃审失败'                              
    rollback                                                         
    return 0         
END CATCH;       
return 1 
