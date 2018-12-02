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
   set @Abortstr='��̯�����ڷ��ý��'  
   return 0  
end  
             
if   exists (select *   from Twhindl dl join Twhin M on m.Fwhincode = dl.FWhinCode  
               join TPaymentApportionDL PayApDL on PayApDL.FWhDLFID = dl.F_ID  
               where isnull(FisChk,0) =0 and  FPaymentApportionCode=@FPaymentApportionCode   )  
begin  
    set @abortstr='���ⵥ�Ѿ�������'                                     
    return 0          
end  

if exists(   select FWhCode from TPaymentApportiondl   where  FPaymentApportionCode=@FPaymentApportionCode group by FWhCode having count(*)>1 )
begin
    set @abortstr='ֻ�ܷ�̯һ���ֿ����ⵥ��'                                     
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
       set @abortstr='��˳���'   --  +convert(varchar(20),@error)                                    
    rollback                                                                   
    return 0                   
END CATCH;                 
return 1               
                                     
