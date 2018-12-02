drop proc Pr_PaymentApportionChk0
go 
CREATE proc	  Pr_PaymentApportionChk0
@Abortstr varchar(30) output,
@WarningStr varchar(30) output,
@FPaymentApportionCode varchar(30)   ,
@FEmpCode  varchar(30)
as

--- select FApportionAmt, * from TPaymentApportionDL 
 

if exists (select *   from TInvCostAccounting  invCost	 join TPaymentApportionDL PayApDL on PayApDL.FWhDLFID = invCost.F_ID
               where  FPaymentApportionCode=@FPaymentApportionCode and fischk=1 )
begin
    set @abortstr='ÒÑºËËã£¬²»ÄÜÆúÉó¡£'                                   
    return 0        
end

BEGIN TRY              
begin tran

   update TInvCostAccounting set  FExpensesApportion  =null
   --select * 
   from TInvCostAccounting  invCost
   join TPaymentApportionDL PayApDL on PayApDL.FWhDLFID = invCost.F_ID
   where  FPaymentApportionCode=@FPaymentApportionCode 
  
   update TPaymentApportion set Fischk=0,fchktime=null,fchkemp=null 	where  FPaymentApportionCode=@FPaymentApportionCode						 
                   
commit              
END TRY              
BEGIN CATCH              
    -- Execute error retrieval routine.              
    EXECUTE usp_GetErrorInfo;              
    if @abortstr=''                                                           
       set @abortstr='ÉóºË³ö´í'   --  +convert(varchar(20),@error)                                  
    rollback                                                                 
    return 0                 
END CATCH;               
return 1             
                                   

