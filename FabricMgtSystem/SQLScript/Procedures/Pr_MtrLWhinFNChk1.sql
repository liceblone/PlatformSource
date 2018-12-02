drop proc Pr_MtrLWhinFNChk1
go 
CREATE proc Pr_MtrLWhinFNChk1                
@abortstr varchar(100) output ,                                                                                                                    
@FWhinCode varchar(20) ,                                                                                                              
@empid  varchar(20) ,                                                                                                      
@longinID varchar(20)                                                                                                            
                                                                                                   
as                                                                                     
/*                                                                              
2009-12-29 ������                                                                       
2010-4-3  ƽ������= ����ƽ������*�ִ���+ ��ⵥ��*���������/���ִ���+���������     �ĳ�  ƽ������    =  ����ƽ������*�ִ���+ ��ⵥ��*���������/���ִ�����      --2010-4-3  �ֿ�����ٲ�����˲���Ҫ�ӱ�������                                                                
                --2010-4-4�ĳ�left join                                                      
2010-7-15 ֻ����Ҫ���³ɱ���������ͽ��м���ɱ���                                                
2011-4-12 ֻ����������0�Ĳ��ϸ��³ɱ��� �� ���µ���                                            
2011-11-18 ƽ�����۸������� ȡǰN���µ�����                                
2012-1-4   multi warehouses                                  
*/                                                                                 
                                                                   
                                                                                     
if not exists(select *   from TWhin M where M.FWhinCode= @FWhinCode and FisChk=1 )                                                                  
begin                                                                      
   set @abortstr='����˳��ⵥ.'                                                                          
   return 0                                                                      
end                                                                  
if  exists(select *    from TWhin M where M.FWhinCode= @FWhinCode and FFnisChk=1 )                                        
begin                                                                      
   set @abortstr='�õ��Ѿ������.'                                        
   return 0                                                                      
end                                                                                                  
if exists( select *    from TWhin M                                                                      
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                                                                      
           where M.FWhinCode= @FWhinCode and ( isnull(FGlCCode,'')='' or isnull(FistDebitCredit,'')='') )                                                                      
begin                                                                      
   set @abortstr='�������ó�������Ͷ�Ӧ�Ŀ�Ŀ.'                                                                          
   return 0                                                                      
end                                                                      
if (    exists(select *From TParamsAndValues where FParamCode='01050101')                                          
    and exists(select *From TParamsAndValues where FParamCode='01050101' and FParamValue=1 )                                          
    )                                          
   if exists( select *   from TWhin M                                                                      
           join TWhindl dl on M.FWhinCode=dl.FWhinCode                                                             
  
           where  ( isnull(dl.Fprice,0)=0 and isnull(dl.FTaxPrice,0)=0  )and M.FWhinCode= @FWhinCode )          
   begin                                                                      
     set @abortstr='�뽫������д����'                    
      return 0           
           
   end                                
                                                                   
 update TWhindl   set Fprice= 0  where  isnull(FTaxPrice,0)=0 and isnull(Fprice,0)=0 and  FWhinCode= @FWhinCode                        
 update TWhindl   set FTaxPrice= Fprice*(1+isnull(FTaxRate,0)/100)   where  isnull(FTaxPrice,0)=0 and FWhinCode= @FWhinCode                        
 update TWhindl   set Fprice   = FTaxPrice/(1+isnull(FTaxRate,0)/100)  where  isnull(Fprice,0)=0 and FWhinCode= @FWhinCode                        
                    
  if exists( select *   from TWhindl where FWhinCode= @FWhinCode and isnull(FTaxPrice,0)<isnull(Fprice,0) )                    
 begin                                      
   set @abortstr='��˰���۴���.'                                          
   return 0                                      
end                      
                     
 /*                                          
declare @abortstr varchar(30),@FWhinCode varchar(30) ,@empid  varchar(30) ,@longinID varchar(30)                                 
set @FWhinCode ='MLi00000454'                            
set @empid  ='000'                             
set @longinID ='chy'*/                              
                            
                            
declare @FGlCCode   varchar(100)  ,@FShRpCode  varchar(100),@FistDebitCredit int ,@FNeedUpdateCost bit,@error int, @FWhCode    varchar(30) ,@FVendorCode varchar(30)                           
set @error =0                                                                      
set @abortstr=''                              
                                    
select @FGlCCode  =FGlCCode,@FistDebitCredit=convert(int,FistDebitCredit) ,@FNeedUpdateCost =iotp.FNeedUpdateCost                                   
      ,@FVendorCode =M.FVendorCode          
           from TWhin M                                  
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                                                                      
           where M.FWhinCode= @FWhinCode             
                     
          
--   �����ɹ���Ӧ�̱���ѡ��ɹ�������          
if exists( select FByOrder,* from Tvendor  where FByOrder=1 and FVendorCode =@FVendorCode  )          
  if exists( select FpurchordCOde,* from TwhinDL where isnull(FpurchordCOde,'')='' and FWhinCode= @FWhinCode   )          
  begin          
    set   @abortstr='�����ɹ���Ӧ�̱���ѡ��ɹ�������'          
    return 0          
  end          
--   �������ۿͻ�����ѡ�����۶�����          
if exists( select FByOrder,* from TClient  where FByOrder=1 and FCltCode =@FVendorCode  )          
  if exists( select FSLOrdCode,* from TwhinDL where isnull(FSLOrdCode,'')='' and FWhinCode= @FWhinCode   )          
  begin          
    set   @abortstr='�������ۿͻ�����ѡ�����۶�����'          
    return 0          
  end                  
          
                                       
BEGIN TRY                  
begin tran                             
                      
--�ñ�־                                                                  
update TWhin set FFNischk=1                            
,FInvoiceAmt=(select sum(FTaxPrice*FMainQty)from TWhindl where FWhinCode= @FWhinCode )                         
,FTax =(FTaxRate/100)*(select sum(FTaxPrice*FMainQty)from TWhindl where FWhinCode= @FWhinCode  ) /(1+FTaxRate/100)                        
where FWhinCode=  @FWhinCode                                                                                                         
set @error =@error +@@error                                                                                      
                             
     
--get wh items        select FvendorCode  from Twhin                    
select cM.FVendorCode, cdl.FinvCode ,cM.FWhCode ,cM.FinDate ,cdl.FpurchOrdCode  ,cdl.FSlOrdCode into #CurWhDL                   
from   Twhindl cdl   join   Twhin cM on cdl.FWhinCode=cM.FWhinCode                               
where  cM.FWhinCode=@FWhinCode                   
set @error =@error +@@error                                                                                      
                            
select                               
M.FWhinCode,dl.FinvCOde,M.FWhCode ,M.FinDate,M.FCreateTime,M.FinOutTypeCode,DL.FPrice, DL.FMainQty as FinQty ,dl.FPackageQty as FinPkgQty ,DL.FpurchOrdCode                                  
into #iTmp                              
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
-- select (  isnull(A.FAvgPrice,B.FPrice ) *isnull(A.Fstorage ,0)+ B.FMainQty*B.FPrice ) / (   isnull(A.Fstorage,0)+isnull(B.FMainQty,0)   )   --,  isnull(A.FAvgPrice,B.FPrice ) ,isnull(A.Fstorage ,0), B.FMainQty,B.FPrice                                 
  
     
     
        
           
            
              
if @FNeedUpdateCost=1                                                               
begin                                                              
    declare @NYearForPriceAVg int  ,@FMaxMonthCloseDay smalldatetime                          
    select  @NYearForPriceAVg =isnull(FParamValue,1)-1  From TParamsAndValues where FParamCode='010601'                                    
    select  @FMaxMonthCloseDay=Max(FMonth) from TMonthEndClose where FisClosed=1                                      
                                               
    select FinvCOde, sum(isnull(FinQty,0)) as FMainQty , sum (isnull(FPrice,0)*FinQty)as Famt   ,FWhCode                               
    into #AvgPrice           
                         
    from #iTmp   DL                            
    where  isnull(FPrice,0) <>0                                             
    and   FinOutTypeCode in (select FinOutTypeCode from TinOutType where FNeedUpdateCost=1)                                     
    and   exists            (select FinvCOde from #CurWhDL where       FinvCode=DL.FinvCode )                              
    and   datediff(m, dbo.FN_GetFirstDayOfMonth(  FinDate ) ,Getdate())<= @NYearForPriceAVg                             
    and   FinDate>=@FMaxMonthCloseDay                          
    group by FinvCOde ,FWhCode  --  ,FinDate                            
    set @error =@error +@@error                               
                             
    update A set A.FAvgPrice=case when (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))=0 then 0 else   (  isnull(A.FUltimoPrice,0) *(isnull(A.FUltimoBalce ,0)  ) + isnull(Famt,0) ) / (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))  end              
 
     
      
        
          
            
              
    -- select   (  isnull(A.FUltimoPrice,0) *(isnull(A.FUltimoBalce ,0)  ) + isnull(Famt,0) ) / (isnull(B.FMainQty ,0) +isnull(A.FUltimoBalce ,0))    ,*                            
    from TMtrLStorage A                                                                                  
    join (select FinvCOde,   Famt      ,FMainQty  ,FWhCode                 
          from   #AvgPrice                                     
         )AS B ON A.FinvCode=B.FinvCode   and A.FWhCode=B.FWhCode                                                            
     where exists   ( select FinvCOde from #CurWhDL where      FinvCode= A.FinvCOde and FWhCode=A.FWhCode)                                                                         
     set @error =@error +@@error           
             
     drop table #AvgPrice                                                                            
end                                                              
                                                              
EXEC PrSys_GetBillCode @FShRpCode OUTPUT,601                                                                                            
set @error =@error +@@error                                                                                  
                                                                         
 --Ӧ�� Ӧ��                                             
insert into  TPayReceiveAble                                                                    
(FShRpCode,FCreateEmp,FCreateTime,FGlCCode,FDate,FClerkEmp,FCltVdCode,FisClt,FBillCode,FisSys,FModalType,FFormID,Famt ,FisChk,FChkEmp,FChkTime ,FTaxRate,FInvoiceAmt,FTax )                                                                      
select                                                                       
@FShRpCode,@empid,getdate(),@FGlCCode,M.FinDate,M.FinEmp,M.FVendorCode,M.FisClt,M.FWhinCode,1,'BillEx','1043',@FistDebitCredit*M.Famt  ,1,@empid,getdate() ,m.FTaxRate,@FistDebitCredit*m.FInvoiceAmt,@FistDebitCredit*m.FTax                                  
  
    
                       
                
from TWhin M    where M.FWhinCode= @FWhinCode                                
set @error =@error +@@error                                                                   
                                                                      
if not exists(select *From TCltVdBookkeeping where FCltVdCode =(select FVendorCode from TWhin where FWhinCode=@FWhinCode  ) )                                                                      
insert into TCltVdBookkeeping(F_ID,FCltVdCode,FisClt) select newid(),FVendorCode,FisClt  from TWhin where FWhinCode=@FWhinCode                       
set @error =@error +@@error                                                                       
                                                   
update TCltVdBookkeeping set FDebtAmt=isnull(B.FInvoiceAmt  ,Famt)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0)                                                 
from TCltVdBookkeeping  A                                                                  
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode                                                                  
where A.FCltVdCode =(select FVendorCode from TWhin where FWhinCode=@FWhinCode  )                  
set @error =@error +@@error                                                                            
                  
                        
       
--�������۶����˻�����                            
update A set A.FSLRtnInQty =B.FMainQty          
--  select *                      
from TSaleOrderDL  A                            
left join (                             
           select   dl.FinvCOde, sum( DL.FMainQty ) as FMainQty ,DL.FSLOrdCode                        
           from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                       
           join  #CurWhDL as Cur on Cur.FinvCode=Dl.FinvCode  and cur.FSLOrdCode =dl.FSLOrdCode              
           where M.Fischk=1                    
           group by DL.FinvCode,  DL.FSLOrdCode                            
          ) B on A.FinvCode=B.FinvCode and A.FSLOrdCode =b.FSLOrdCode                         
where exists (select 1 from #CurWhDL where FinvCode +FSLOrdCode =  A.FInvCode+A.FSLOrdCode )                         
set @error =@error +@@error             
          
                                            
--���²ɹ������������                          
update A set A.FinQty=B.FMainQty                       
-- select *                     
from TPurchaseOrdDL  A                        
left join (                         
  select   dl.FinvCOde, sum( DL.FMainQty ) as FMainQty ,DL.FpurchOrdCode                        
  from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                                   
  where M.Fischk=1                    
  group by dl.FinvCode, dl.FpurchOrdCode                
          ) B on A.FinvCode=B.FinvCode and A.FpurchOrdCode =b.FpurchOrdCode                    
  join  #CurWhDL as Cur on Cur.FinvCode=b.FinvCode  and cur.FPurchOrdCode =b.FPurchOrdCode                     
set @error =@error +@@error      
               
select A.FinQty,B.FMainQty  ,*                     
from TPurchaseOrdDL  A                        
left join (                         
  select   dl.FinvCOde, sum( DL.FMainQty ) as FMainQty ,DL.FpurchOrdCode                        
  from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                                 
  where M.Fischk=1                    
  group by dl.FinvCode, dl.FpurchOrdCode                                    
          ) B on A.FinvCode=B.FinvCode and A.FpurchOrdCode =b.FpurchOrdCode                    
  join  #CurWhDL as Cur on Cur.FinvCode=b.FinvCode  and cur.FPurchOrdCode =b.FPurchOrdCode      
              
--���³ɱ�����   select FOriPrice from TMtrLStorageHis          
update TInvCostAccounting               
set FOriPrice   =  cdl.FPrice              
from TInvCostAccounting InvCst              
join Twhindl            cdl   on   cdl.F_ID=InvCst.F_ID              
where  cdl.FWhinCode=@FWhinCode and InvCst.FOriPrice <>  cdl.FPrice              
set @error =@error +@@error                                                                                                          
            
--�����ۼƳɱ�����            
update TMtrLStorageHis set            
FCostInaccuracy= CIY.FCostInaccuracy            
from TMtrLStorageHis His            
join (            
      select  sum( isnull(FOriPrice,0)-isnull(FEstimatedPrice,0)) as FCostInaccuracy            
      ,Fmonth,FInvCode,FWhCOde             
      from TInvCostAccounting    where isnull(
FOriPrice,0)>0               
      group by Fmonth,FInvCode,FWhCOde             
      ) as CIY on CIY.FMonth=his.FMonth and CIY.FInvCode=his.FInvCode and CIY.FWhCode=his.FWhCode            
join #CurWhDL cur on cur.FWhCode=His.FWhCode  and His.FInvCode=His.FInvCode            
                  and year(cur.FinDate)=year(his.FMonth) and month(cur.FinDate)+1=month(his.FMonth)            
            
                   
                            
drop table #iTmp                     
drop table #CurWhDL              
            
commit                  
END TRY                  
BEGIN CATCH            
    -- Execute error retrieval routine.                  
    EXECUTE usp_GetErrorInfo;                  
    if @abortstr=''                                                               
       set @abortstr='���ʧ��'      +convert(varchar(20),@error)                                      
    rollback                
                                                                    
    return 0                     
END CATCH;           
return 1                 
            
            
          
 ------------------------------------------------------------------------------------     
     
