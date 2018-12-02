drop proc Pr_PayReceiveChk0
go 
    
create proc Pr_PayReceiveChk0  
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
    --÷√±Í÷æ                                                                
    update TPayReceive set Fischk=0 ,FchkEmp=null  ,FchkTime=null  where FRpCode=  @FPKCode  
    
        -- update balance    
    update TCltVdBookkeeping set FCreditAmt=isnull(B.Famt  ,0)                            
	from TCltVdBookkeeping  A                                    
	left join (select sum(FAmt)Famt     ,FcltVdCode From TPayReceive where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                    
    join  TPayReceive PR  on PR.FCltVdCode= A.FCltVdCode 
    where PR.FRpCode=  @FPKCode
    
commit    
END TRY    
BEGIN CATCH    
    -- Execute error retrieval routine.    
    EXECUTE usp_GetErrorInfo;    
    if @abortstr=''                                                 
       set @abortstr='∆˙…Û ß∞‹'                            
    rollback                                                       
    return 0       
END CATCH;     
return 1 
