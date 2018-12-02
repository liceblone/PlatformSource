drop proc Pr_MtrLWhoutFNChk1
go 
CREATE proc Pr_MtrLWhoutFNChk1       
@abortstr varchar(100) output ,                                                                              
@FWhOutCode varchar(20),                                                                        
@empid varchar(20)     ,                                                                
@longinID  varchar(20)                                                                      
                                                             
as                                               
/*                                  
declare @P1 varchar(100) set @P1='' exec Pr_MtrLWhoutChk1 @P1 output, 'MLO00000073', 'E000010', 'chy' select @P1                                    
--2010-4-4�ĳ�left join                    
*/                                  
declare @ErrMsg varchar(200) ,@error int ,@FGlCCode varchar(100)  ,@FShRpCode varchar(100), @FistDebitCredit int                        
declare @FCltVdCode varchar(20)    
set @error =0                                        
set @abortstr=''                                
set @ErrMsg=''                                  
                            
                                
if not exists(select *                            
           from TWhOutM M where FisChk=1 and FWhOutCode= @FWhOutCode  )                        
begin                            
   set @abortstr='������˳��ⵥ,��������.'                                
   return 0                            
end                        
if  exists(select *                            
           from TWhOutM M where FFnisChk=1 and FWhOutCode= @FWhOutCode  )                        
begin                            
   set @abortstr='���Ѿ�����ˣ�����ˢ��.'                  
   return 0                            
end                        
                
if exists( select *                            
           from TWhOutM M                            
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                            
           where M.FWhOutCode= @FWhOutCode and ( isnull(FGlCCode,'')='' or isnull(FistDebitCredit,'')='') )                            
begin                            
   set @abortstr='�������ó�������Ͷ�Ӧ�Ŀ�Ŀ.'                                
   return 0                            
end    /*  */                
          
 update TWhOutdl   set Fprice=0   where  isnull(FTaxPrice,0)=0 and isnull(Fprice,0)=0 and FWhOutCode= @FWhOutCode              
 set @error =@error +@@error                                    
 update TWhOutdl   set FTaxPrice= Fprice*(1+isnull(FTaxRate,0)/100)   where  isnull(FTaxPrice,0)=0 and FWhOutCode= @FWhOutCode              
 set @error =@error +@@error                                    
 update TWhOutdl   set Fprice   = FTaxPrice/(1+isnull(FTaxRate,0)/100)  where  isnull(Fprice,0)=0 and FWhOutCode= @FWhOutCode              
 set @error =@error +@@error              
           
           
 if exists( select *   from TWhOutdl where  FWhOutCode= @FWhOutCode and isnull(FTaxPrice,0)<isnull(Fprice,0) )          
 begin                            
   set @abortstr='��˰���۴���.'                                
   return 0                            
end    /*  */           
                      
select @FGlCCode  =FGlCCode,@FistDebitCredit=convert(int,FistDebitCredit) ,@FCltVdCode=FCltVdCode                       
           from TWhOutM M                            
           join TinOutType iotp on M.FinOutTypeCode=iotp.FinOutTypeCode                            
           where M.FWhOutCode= @FWhOutCode      
               
--   �����ɹ���Ӧ�̱���ѡ��ɹ�������  select * from TWhOutM    
if exists( select FByOrder,* from Tvendor  where FByOrder=1 and FVendorCode =@FCltVdCode  )    
  if exists( select FpurchordCOde,* from TWhOutDL where isnull(FpurchordCOde,'')='' and FWhOutCode= @FWhOutCode   )    
  begin    
    set   @abortstr='�����ɹ���Ӧ�̱���ѡ��ɹ�������'    
    return 0    
  end    

--   �������ۿͻ�����ѡ�����۶�����    
if exists( select FByOrder,* from TClient  where FByOrder=1 and FCltCode =@FCltVdCode  )    
  if exists( select FSLOrdCode,* from TWhOutDL where isnull(FSLOrdCode,'')='' and FWhOutCode= @FWhOutCode   )    
  begin    
    set   @abortstr='�������ۿͻ�����ѡ�����۶�����'    
    return 0    
  end     
      
                                      
BEGIN TRY            
begin tran                                    
              
                        
--�ñ�־                                                  
update TWhOutM set FFNischk=1               
,FInvoiceAmt=(select sum(FTaxPrice*FOutQty)from TWhOutdl where FWhOutCode=  @FWhOutCode  )               
,FTax =(FTaxRate/100)*(select sum(FTaxPrice*FOutQty)from TWhOutdl where FWhOutCode=  @FWhOutCode  ) /(1+FTaxRate/100)              
where  FWhOutCode=  @FWhOutCode                     
set @error =@error +@@error       
      
                          
--ȡ��ϸ  select  * from TWhOutM drop table  #CurWhDL    drop table #oTmp M.Fwhoutcode=  'MLO00000294'                           
SELECT             
M.FCltVdCode ,DL.FWhoutcode,M.FWhCode,DL.FinvCode,DL.FSLOrdCode ,DL.FProduceOrdCode  , DL.FinvName ,DL.FcolorCode,DL.FGoodCode ,Dl.FPdtInvCode ,DL.FPurchOrdCode ,sum(DL.FoutQty) as FoutQty            
into #CurWhDL                                 
FROM TWhoutDL DL join TWhOutM M on DL.FWhOutCode=M.FWhOutCode                              
where  M.Fwhoutcode=@FWhOutCode                             
group by             
M.FCltVdCode ,DL.FWhoutcode,M.FWhCode,DL.FinvCode,DL.FSLOrdCode ,DL.FProduceOrdCode  , DL.FinvName ,DL.FcolorCode,DL.FGoodCode ,Dl.FPdtInvCode  ,DL.FPurchOrdCode             
set @error =@error +@@error                           
                                 
                        
EXEC PrSys_GetBillCode @FShRpCode OUTPUT,601                                                    
set @error =@error +@@error                          
                      
--Ӧ��Ӧ��                        
insert into TPayReceiveAble      (                     
  FShRpCode, FCreateEmp,FCreateTime,FGlCCode,FDate,FClerkEmp,FNote,FCltVdCode,FisClt,FBillCode,FisSys,FModalType,FFormID,Famt,FisChk,FChkEmp,FChkTime ,FTaxRate,FInvoiceAmt,FTax)                        
select @FShRpCode,@empid,getdate(),@FGlCCode ,    FOutDate,FOutEmp,FNote,FcltVdCode,FisClt,FWhoutCode,1,   'BillEx'  ,1042,@FistDebitCredit*Famt,1,@empid,getdate()  ,m.FTaxRate,m.FInvoiceAmt,m.FTax   from  TWhOutM  m where  FWhOutCode=  @FWhOutCode       
set @error =@error +@@error                                  
                        
--�ӿͻ���                        
if not exists(select *from TCltVdBookkeeping where FcltVdCode =(select FcltVdCode from TWhOutM where    FWhOutCode=  @FWhOutCode  ))                        
insert into TCltVdBookkeeping (FcltVdCode,FisClt,F_ID) select FcltVdCode,FisClt,newid() from TWhOutM where    FWhOutCode=  @FWhOutCode                          
                        
--��������                        
update TCltVdBookkeeping set FDebtAmt=isnull(B.FInvoiceAmt  ,b.Famt)  ,FNeedInvoiceAmt= isnull(B.FInvoiceAmt,0) --2010-4-4�ĳ�left join                                  
from TCltVdBookkeeping  A                                            
left join (select sum(FAmt)Famt , sum(FTax)FTax ,sum(FInvoiceAmt)FInvoiceAmt  ,FcltVdCode From TPayReceiveAble where FisChk=1 group by FcltVdCode )B on A.FcltVdCode=B.FcltVdCode           
where A.FcltVdCode =(select FcltVdCode from TWhOutM where    FWhOutCode=  @FWhOutCode  )                                         
set @error =@error +@@error                                                      
            

                            
--�������۶����������        select FCltCode from TSaleOrder                         
update A set A.FOutQty =B.FOutQty                                
--  select *                          
from TSaleOrderDL  A      
join TSaleOrder    SLM on SLM.FSlOrdCode= A.FSlO
rdCode                               
left join (                                 
    select DL.FinvCode, sum( DL.FOutQty )as FOutQty ,DL.FSLOrdCode                                
    FROM TWhoutDL DL  join TWhOutM M on DL.FWhOutCode=M.FWhOutCode            
    join #CurWhDL Cur on Cur.FinvCode =Dl.FinvCode  and cur.FSLOrdCode =dl.FSLOrdCode                     
    where  M.Fischk=1                         
           group by DL.FinvCode,  DL.FSLOrdCode                                
          ) B on A.FinvCode=B.FinvCode and A.FSLOrdCode =b.FSLOrdCode                             
where exists (select 1 from #CurWhDL cur where cur.FCltVdCode =  SLM.FCltCode )                             
set @error =@error +@@error                                   
                                      
 --���²ɹ������˻�����         select * from TPurchaseOrder                         
update A set A.FPchsRtnOutQty =B.FOutQty                                
--  select *                          
from TPurchaseOrdDL  A             
join TPurchaseOrder  PurchM on A.FPurchOrdCode = PurchM.FPurchOrdCode                        
left join (                                 
    select DL.FinvCode, sum( DL.FOutQty )as FOutQty ,DL.FPurchOrdCode                                
    FROM TWhoutDL DL  join TWhOutM M on DL.FWhOutCode=M.FWhOutCode                            
    join #CurWhDL Cur on Cur.FinvCode =Dl.FinvCode   and cur.FPurchOrdCode =dl.FPurchOrdCode                   
    where  M.Fischk=1                         
           group by DL.FinvCode,  DL.FPurchOrdCode                                
          ) B on A.FinvCode=B.FinvCode and A.FPurchOrdCode =b.FPurchOrdCode                             
where exists ( select * from #CurWhDL where FCltVdCode =  PurchM.FVendorCode )                             
set @error =@error +@@error       
                              
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



