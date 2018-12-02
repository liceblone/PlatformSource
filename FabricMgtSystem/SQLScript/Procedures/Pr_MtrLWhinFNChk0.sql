drop proc Pr_MtrLWhinFNChk0
go 
			  
CREATE proc Pr_MtrLWhinFNChk0                                                                
@abortstr varchar(100) output ,                                                                                            
@FWhinCode varchar(20),                                                                                      
@empid varchar(20)     ,                                                                              
@longinID  varchar(20)                                                                                    
                                                                           
as                                                                
/*                                                          
declare @P1 varchar(100) set @P1='' exec Pr_MtrLWhinChk0 @P1 output, 'MLi00000075', 'E000010', 'chy' select @P1                                                  
                                                  
2009-12-29 ������   ��������ϸ��Ϊ0 Ҳɾ��                                                          
2010-1-1   ����ʱ����ִ������޶�Ϊ��ǰ����                                                        
2010-4-3  ƽ������= ����ƽ������*�ִ���+ ��ⵥ��*���������/���ִ���+���������     �ĳ�  ƽ������    =  ����ƽ������*�ִ���+ ��ⵥ��*���������/���ִ�����      --2010-4-3  �ֿ�����ٲ�����˲���Ҫ�ӱ�������                                          
 --2010-4-4�ĳ�left join                                
2010-7-15 ֻ����Ҫ���³ɱ���������ͽ��м���ɱ���                          
2011-4-12 ֻ����������0�Ĳ��ϸ��³ɱ��� �� ���µ���                          
*/                                                                   
declare @error int                                                 
declare @FGlCCode varchar(100)                                               
declare @FistDebitCredit int                                           
declare @FNeedUpdateCost bit                   
declare @FWhCode varchar(50)                     
declare @errmsg varchar(50)                     
                                             
set @error =0  set @abortstr=''                                                                                                  
set @errmsg=''                        
                                                   
if not exists(select *    from TWhin M where  FWhinCode=@FWhinCode and FisChk=1 )                                          
begin                                              
   set @abortstr='ֻ�ܶ�����˳��ⵥ����.'                                                  
   return 0                                              
end                                          
if not exists(select *     from TWhin M where FWhinCode=@FWhinCode and FFnisChk=1 )                                           
begin                                              
   set @abortstr='���ⵥ�Ѿ�����������ˢ��.'                       
   return 0                                              
end                                          
if   exists( select *     from TWhindl where FWhinCode=@FWhinCode and FReconciled=1 )                                           
begin                                              
   set @abortstr='�õ�����ϸ�Ѿ����ʣ�����ˢ��.'                       
   return 0                                              
end                                          
                          
if exists( select *  from TWhin M                                                
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                                                
           where M.FWhinCode= @FWhinCode and ( isnull(FGlCCode,'')='' or isnull(FistDebitCredit,'')='') )                                                
begin                                                
   set @abortstr='�������ó�������Ͷ�Ӧ�Ŀ�Ŀ.'                                                    
   return 0                                                
end                       
            
if exists( select * from TInvCostAccounting  where  FbillCode=@FWhinCode )            
begin     
       
   set @abortstr='�Ѿ��ɱ����㲻������.'                                                    
   return 0                                             
end              
            
            
      
select @FGlCCode  =FGlCCode,@FistDebitCredit=convert(int,FistDebitCredit) ,@FNeedUpdateCost =iotp.FNeedUpdateCost                                          
           from TWhin M                                                
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                                                
           where M.FWhinCode= @FWhinCode            
                                                  
BEGIN TRY            
begin tran          
                                                 
--���±�־                                                  
update TWhin set FFNischk=0   where FWhinCode=  @FWhinCode                                                                                 
set @error =@error +@@error                                                     
                                                      
--ɾ��Ӧ��Ӧ��                                         
delete TPayReceiveAble where FBillCode=@FWhinCode                                              
set @error =@error +@@error                                                    
                                          
--get wh items                
select cdl.FinvCode ,cM.FWhCode ,cM.FinDate ,cdl.FpurchOrdCode  into #CurWhDL                  
from   Twhindl cdl   join   Twhin cM on cdl.FWhinCode=cM.FWhinCode                   
where  cM.FWhinCode=@FWhinCode                  
set @error =@error +@@error                                                             
                
select                   
M.FWhinCode,dl.FinvCOde,M.FWhCode ,M.FinDate,M.FCreateTime,M.FinOutTypeCode,DL.FPrice, DL.FMainQty as FinQty ,dl.FPackageQty as FinPkgQty ,DL.FpurchOrdCode                      
into  #iTmp                  
from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                     
join  #CurWhDL as Cur on Cur.FinvCode=Dl.FinvCode and Cur.FWhCode=M.FWhCode                  
where M.FFNischk=1                   
set @error =@error +@@error                                                                          
                
--�������µ���                                      
update TMtrLStorage set FLstPrice=isnull(FPrice,0)                           
--  select *                    
    from TMtrLStorage A                                                                      
    left  join (select DL.FinvCOde,  isnull(DL.FPrice,0)  as FPrice   ,DL.FWhCode                  
                from #iTmp DL                
                join (select Max(FInDate)as FInDate ,Max(FCreateTime) as FCreateTime,FInvCode , FWhCode                   
                      from #iTmp                
                      group by FInvCode ,FWhCode                  
                     )as LstInv on LstInv.FinvCode  =DL.FinvCode                 
                               and LstInv.FInDate  =DL.FinDate                   
                               and LstInv.FCreateTime =DL.FCreateTime                
                where  isnull(DL.FPrice,0) <>0                        ---and M.FinDate =(select Max(FinDate ) from  Twhin where FFnischk=1   )                                      
               )AS B ON A.FinvCode=B.FinvCode  and A.FWhCode= B.FWhCode                 
     where  exists  (select FinvCOde from #CurWhDL where   FinvCode=A.FinvCOde and FWhCode=A.FWhCode)                    
set @error =@error +@@error                                                                  
                                                   
--���������ǰ����  ������ ���෴�Ĵ���    ƽ������   =  ����ƽ������*�ִ���+ ��ⵥ��*���������/���ִ���+���������                                                    
-- select (  isnull(A.FAvgPrice,B.FPrice ) *isnull(A.Fstorage ,0)+ B.FMainQty*B.FPrice ) / (   isnull(A.Fstorage,0)+isn
ull(B.FMainQty,0)   )   --,  isnull(A.FAvgPrice,B.FPrice ) ,isnull(A.Fstorage ,0), B.FMainQty,B.FPrice                                 
   
   
      
         
                   
if @FNeedUpdateCost=1                                     
begin                                                  
    declare @NYearForPriceAVg int                        
    select  @NYearForPriceAVg =isnull(FParamValue,1)-1  From TParamsAndValues where FParamCode='010601'                        
                                   
    select FinvCOde, sum(isnull(FinQty,0)) as FMainQty , sum (isnull(FPrice,0)*FinQty)as Famt   ,FWhCode                   
    into #AvgPrice                        
    from #iTmp   DL                
    where  isnull(FPrice,0) <>0                                 
    and   FinOutTypeCode in (select FinOutTypeCode from TinOutType where FNeedUpdateCost=1)                         
    and   exists            (select FinvCOde from #CurWhDL where       FinvCode=DL.FinvCode )                  
    and   datediff(m, convert(smalldatetime,convert(varchar(4),year(FinDate)) +'-'+convert(varchar(4),month(FinDate))+'-01') ,Getdate())<= @NYearForPriceAVg                 
    group by FinvCOde ,FWhCode    --,FinDate                
    set @error =@error +@@error                    
                 
    update A set A.FAvgPrice=case when (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))=0 then 0 else   (  isnull(A.FUltimoPrice,0) *(isnull(A.FUltimoBalce ,0)  ) + isnull(Famt,0) ) / (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))  end             
   
    -- select   (  isnull(A.FUltimoPrice,0) *(isnull(A.FUltimoBalce ,0)  ) + isnull(Famt,0) ) / (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))    ,*                
    from TMtrLStorage A                                                                      
    left join (select FinvCOde,   Famt      ,FMainQty  ,FWhCode                  
          from #AvgPrice                         
         )AS B ON A.FinvCode=B.FinvCode   and A.FWhCode=B.FWhCode                                                
     where exists   ( select FinvCOde from #CurWhDL where      FinvCode= A.FinvCOde and FWhCode=A.FWhCode)                                                           
     set @error =@error +@@error   
       
     drop table #AvgPrice                                                            
end                 
                                  
    
    
update TCltVdBookkeeping set FDebtAmt=isnull(B.FInvoiceAmt  ,Famt)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0)                                           
from TCltVdBookkeeping  A                                                            
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                                            
where A.FCltVdCode =(select FVendorCode from TWhin where FWhinCode=@FWhinCode  )            
set @error =@error +@@error      
    
                                          
                                          
/*                                            
delete  TPayReceiveAble   where FBillCode=@FWhinCode    --Ӧ�� Ӧ��                                      
set @error =@error +@@error                                                       
update TCltVdBookkeeping set FDebtAmt =isnull(B.Famt,0)                                              
from TCltVdBookkeeping A                                              
left join ( select sum(Famt) as  Famt,FcltVdCode  From TPayReceiveAble where  FcltVdCode=(select FVendorCode from TWhin where FWhinCode=@FWhinCode  )  group by FcltVdCode )as B                                              
      on A.FcltVdCode=B.FcltVdCode                                              
set @error =@error +@@error                       
  */                         
drop table #
iTmp                          
drop table #CurWhDL        
      
commit            
END TRY            
BEGIN CATCH            
    -- Execute error retrieval routine.            
    EXECUTE usp_GetErrorInfo;            
    if @abortstr=''                                                         
       set @abortstr='����ʧ��'      +convert(varchar(20),@error)                                
    rollback                                                               
    return 0               
END CATCH;             
return 1         
                                             
                                                      
                                                       
                                                              
                                                                                            
 ------------------------------------------------------------------------------------ 
