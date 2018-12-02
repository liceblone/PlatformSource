drop proc Pr_InvoiceChk1
go 
CREATE        proc Pr_InvoiceChk1                       
@abortstr   varchar(100) output ,                                          
@warningstr varchar(100) output ,                                           
@FSysInvoiceCode varchar(20),                                                                                        
@empid varchar(20)     ,                                                                                
@longinID  varchar(20)                                                                                               
as                                                              
/*                                                  
        
                                             
                          
*/                                                  
declare @ErrMsg varchar(200)  , @error int                                           
set @error =0                                                        
set @abortstr=''                                                
set @ErrMsg=''                                                  
                    
       
       
BEGIN TRY      
begin tran             
                           
    --�ñ�־                                                                  
    update TInvoicedM        set   
    Fischk=1 ,FchkEmp=@empid ,FchkTime=case when FchkTime is null then getdate()else FchkTime end   
    ,FTax= convert(decimal(19,2),  FAmt- FAmt/(1+ isnull(FTaxRate,0)/100) )  
    where  FSysInvoiceCode=  @FSysInvoiceCode        
    --ȡ��ǰ��ϸ                          
    select distinct cdl.FinvCode ,cM.FCltVdCode ,cdl.FBillCode, cdl.FDLID into #CurInvoiceDL                      
    from   TInvoicedDL cdl   join   TInvoicedM cM on cdl.FSysInvoiceCode=cM.FSysInvoiceCode                       
    where  cM.FSysInvoiceCode=@FSysInvoiceCode                      
    --ȡ��ǰ�ͻ�������ϸ                          
    select                       
    M.FCltVdCode  , DL.FAmt                     
    into  #iTmp                      
    from  TInvoiceddl dl join TInvoicedM  M on dl.FSysInvoiceCode=M.FSysInvoiceCode                       
    where M.Fischk=1   and exists ( select 1 from   #CurInvoiceDL as Cur where  Cur.FCltVdCode=m.FCltVdCode         )              
       
    --���������ϸ      
    update Twhindl set FIsInvoiced=1      
    from   Twhindl A      
    join   #CurInvoiceDL  Invoice on A.FWhinCode=Invoice.FBillCode and A.FinvCode=Invoice.FinvCode and A.F_ID=Invoice.FDLID      
          
    --���³�����ϸ      
    update Twhoutdl set FIsInvoiced=1      
    from   Twhoutdl A      
    join   #CurInvoiceDL  Invoice on A.FWhoutCode=Invoice.FBillCode and A.FinvCode=Invoice.FinvCode and A.F_ID=Invoice.FDLID      
          
          
 --���¿�Ʊ���                                               
 update TCltVdBookkeeping set FInvoicedAmt=convert(decimal(19,2), isnull(B.FAmt     ,0))                                     
 --select *                                               
 from TCltVdBookkeeping A                                                    
 left join ( select  sum(isnull(FAmt,0)) as FAmt    ,FCltVdCode                        
        from #iTmp  group by FCltVdCode                        
      )AS B ON A.FCltVdCode=B.FCltVdCode                          
 where exists (select 1 from #CurInvoiceDL where FCltVdCode  =  A.FCltVdCode  )                      
      
commit      
END TRY      
BEGIN CATCH      
    -- Execute error retrieval routine.      
    EXECUTE usp_GetErrorInfo;      
    if @abortstr=''                                                   
       set @abortstr='���ʧ��'     +convert(varchar(20),@error)                          
    rollback                                                         
    return 0         
END CATCH;       
return 1                                                       
                                                               
                                         
                   
