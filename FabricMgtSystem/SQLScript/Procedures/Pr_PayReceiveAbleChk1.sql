drop proc Pr_PayReceiveAbleChk1
go 
create proc Pr_PayReceiveAbleChk1    
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
    update TPayReceiveAble set Fischk=1 ,FchkEmp=@empid  ,FchkTime=getdate()    where FShRpCode=  @FPKCode
    update TPayReceiveAble set FInvoiceAmt=Famt*(1+isnull(FTaxRate,0)/100)      where FShRpCode=  @FPKCode and isnull( Famt ,0)<>0 and isnull(FInvoiceAmt,0)=0
    update TPayReceiveAble set Famt= FInvoiceAmt/(1+isnull(FTaxRate,0)/100)     where FShRpCode=  @FPKCode and isnull( Famt ,0)=0 and isnull(FInvoiceAmt,0)<>0
        
        --加客户名                
    if not exists(select *from TCltVdBookkeeping where FcltVdCode =(select FcltVdCode from TPayReceiveAble where   FShRpCode=  @FPKCode  ))                
    insert into TCltVdBookkeeping (FcltVdCode,FisClt,F_ID) select FcltVdCode,1,newid() from TPayReceiveAble where   FShRpCode=  @FPKCode                 

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
    
    

