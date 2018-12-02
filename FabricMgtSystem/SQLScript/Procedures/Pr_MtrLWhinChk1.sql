drop proc Pr_MtrLWhinChk1
go 
create proc Pr_MtrLWhinChk1              
@abortstr varchar(100) output ,                                                                              
@FWhinCode varchar(20),                                                                        
@empid varchar(20)     ,                                                                
@longinID  varchar(20)                                                                      
                                                             
as                                        
                 
/*                                        
2009-12-29 ������                                        
2010-4-3   ����� �ɱ����� �������Ϊ׼                                 
2010-4-10 ȥ���������µ���                          
2011-7-31 ���ɹ��������                        
2011-12-56 ֧�ֶ�ֿ�                    
*/                         
/*                  
declare @abortstr varchar(100)   ,@FWhinCode varchar(20),@empid varchar(20) ,@longinID  varchar(20)                           
set @FWhinCode='MLi00000455'                  
set @empid='000'                  
set @longinID='chy'                  
*/                    
declare @error int  , @FWhoutcode varchar(30)  ,@FinvName varchar(30),@FColorCode varchar(30)  ,@FGoodCode varchar(30)                                 
set @error =0                                                                    
            
--	�������۳��ⵥ����Ӧ�����ڲɹ���ⵥ
if exists( select * from TParamsAndValues where FParamCode='01020401'  and FParamValue=1 )
begin
   select M.FwhCode, dl.FinvCode,m.FoutDate ,m.Fwhoutcode into #TUnChkSLOutDL from TwhoutM M join TwhoutDL dl on M.FWhoutCode=dl.FWhoutCode
   where isnull(m.FisChk,0)=0    
   --and m.FinoutTypeCode = (select  FParamValue From TParamsAndValues where FParamCode='010101' )

   select @FWhoutcode = FWhoutcode , @FinvName = FinvName, @FColorCode=FColorCode, @FGoodCode=FGoodCode 
   from #TUnChkSLOutDL slout join Tinventory inv on slout.FinvCode=inv.FinvCode
  
   if exists(select * from  TMtrLStorage stg 
             join  #TUnChkSLOutDL  slout on stg.finvCode=slout.FinvCode and stg.FwhCode=slout.FwhCode
             join  (select m.FwhCode,dl.FinvCode  ,m.FinDate  from Twhin m join Twhindl dl on m.FwhinCode=dl.FwhinCode 
                    where m.FWhinCode=  @FWhinCode)	whinDL   on  stg.finvCode=whinDL.FinvCode and stg.FwhCode=whinDL.FwhCode
              where stg.FStorage=0 and slout.FoutDate< WhinDL.FinDate)
   begin
      	set @abortstr='���ɹ���ⵥ����Ӧ���ڴ�����ⵥ��������'  +char(13)+char(10)+'������ⵥ:('+@FWhoutcode+') �ͺ�:'+@FinvName +' '+@FColorCode+' '+ @FGoodCode
      	return 0    
   end 
   drop table #TUnChkSLOutDL   
end
BEGIN TRY                  
begin tran 
                                        
--���±�־                      
update TWhin set Fischk=1 ,FchkEmp=@empid ,FchkTime=case when FchkTime is null then getdate()else FchkTime end  where FWhinCode=  @FWhinCode                                                                   
set @error =@error +@@error                                        
                           
--ȡ��ϸ                      
select distinct cdl.FinvCode ,cM.FWhCode ,cM.FinDate ,cdl.FpurchOrdCode ,cdl.FSLOrdCode into #CurWhDL                  
from   Twhindl cdl   join   Twhin cM on cdl.FWhinCode=cM.FWhinCode                   
where  cM.FWhinCode=@FWhinCode                  
set @error =@error +@@error                                        
                
select                   
M.FWhinCode,dl.FinvCOde,M.FWhCode ,M.FinDate, DL.FMainQty as FinQty ,dl.FPackageQty as FinPkgQty ,DL.FpurchOrdCode ,dl.FSLOrdCode                     
into  #iTmp                  
from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                     
-- join  #CurWhDL as Cur on Cur.FinvCode=Dl.FinvCode and Cur.FWhCode=M.FWhCode                  
where M.Fischk=1   and exists ( select 1 from   #CurWhDL as Cur where  Cur.FinvCode=Dl.FinvCode and Cur.FWhCode=M.
FWhCode        )          
set @error =@error +@@error                                        
                                             
--1.��������� 2.�����������                                                
insert into TMtrLStorage(FinvCode ,F_ID,FWhCode)                                  
select FinvCode,newid() ,B.FWhCode from                     
(select distinct FinvCode ,FWhCode from #CurWhDL where  FinvCode+ FWhCode  not in (select distinct FinvCode+FWhCode  from TMtrLStorage)                         
) as B                                                                       
set @error =@error +@@error                                        
                                        
                                          
--�����������                                            
update TMtrLStorage set FinQty=isnull(B.FinQty     ,0)   ,  FinPkgQty=isnull(B.FinPkgQty,0)                                       
--select *                                           
from TMtrLStorage A                                                
left join ( select FinvCOde,sum(isnull(FinQty,0)) as FinQty ,sum(isnull(FinPkgQty,0)) as FinPkgQty   ,FWhCode                    
                   from #iTmp  group by FinvCOde,FWhCode                    
           )AS B ON A.FinvCode=B.FinvCode  and A.FWhCode=B.FWhCode                    
where exists (select 1 from #CurWhDL where FinvCode +FWhCode =  A.FInvCode+A.FWhCode )                  
set @error =@error +@@error                                        
                                        
                        
--�������۶����˻�����                          
update A set A.FSLRtnInQty =B.FMainQty        
--  select *                    
from TSaleOrderDL  A                          
left join (                           
           select   dl.FinvCOde, sum( DL.FMainQty ) as FMainQty ,DL.FSLOrdCode                      
           from  TWhinDL dl join Twhin  M on dl.FwhinCode=M.FwhinCode                         
           where M.Fischk=1                  
           group by DL.FinvCode,  DL.FSLOrdCode                          
          ) B on A.FinvCode=B.FinvCode and A.FSLOrdCode =b.FSLOrdCode                       
 join  #CurWhDL as Cur on Cur.FinvCode=b.FinvCode  and cur.FSLOrdCode =b.FSLOrdCode                        
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
                                        
                       
                        
drop table #iTmp                  
drop table #CurWhDL                  

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
                   

