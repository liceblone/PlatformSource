drop proc Pr_PaymentApportionChk1
go 
CREATE proc   Pr_PaymentApportionChk1  
@Abortstr varchar(30) output,  
@WarningStr varchar(30) output,  
@FPaymentApportionCode varchar(30)   ,  
@FEmpCode  varchar(30)  
as  
  
--- select FApportionAmt, * from TPaymentApportionDL   
  
if exists(   select FApportionAmt, * from TPaymentApportion   where  FPaymentApportionCode=@FPaymentApportionCode and FAmt <>FApportionAmt )  
begin  
   set @Abortstr='分摊金额不等于费用金额'  
   return 0  
end  
             
if   exists (select *   from Twhindl dl join Twhin M on m.Fwhincode = dl.FWhinCode  
               join TPaymentApportionDL PayApDL on PayApDL.FWhDLFID = dl.F_ID  
               where isnull(FisChk,0) =0 and  FPaymentApportionCode=@FPaymentApportionCode   )  
begin  
    set @abortstr='出库单已经被弃审。'                                     
    return 0          
end  

if exists(   select FWhCode from TPaymentApportiondl   where  FPaymentApportionCode=@FPaymentApportionCode group by FWhCode having count(*)>1 )
begin
    set @abortstr='只能分摊一个仓库的入库单。'                                     
    return 0
end  
   
  
BEGIN TRY                
begin tran  
    /*  
   update TInvCostAccounting set  FExpensesApportion  = PayApDL.FApportionAmt  
   --select *   
   from TInvCostAccounting  invCost  
   join TPaymentApportionDL PayApDL on PayApDL.FWhDLFID = invCost.F_ID  
   where  FPaymentApportionCode=@FPaymentApportionCode   
         */  
           
   update TPaymentApportion set Fischk=1,fchktime=getdate(),fchkemp=@FEmpCode  where  FPaymentApportionCode=@FPaymentApportionCode         
   
                     
commit                
END TRY                
BEGIN CATCH                
    -- Execute error retrieval routine.                
    EXECUTE usp_GetErrorInfo;                
    if @abortstr=''                                                             
       set @abortstr='审核出错'   --  +convert(varchar(20),@error)                                    
    rollback                                                                   
    return 0                   
END CATCH;                 
return 1               
                                     
