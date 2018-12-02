drop proc PR_InvStorageHisChk
go 
CREATE  proc PR_InvStorageHisChk            
@AbortStr varchar(50) output,            
@WarningStr  varchar(50) output,            
@FMonth smalldatetime,            
@FWhCode  varchar(30),            
@FChkFlag   varchar(30),              
@FEmpCode varchar(30)            
as            
declare @FisChk bit    
print @FisChk          
 if isnull( @FChkFlag,'0')='0'  
  set @FisChk=1           
else        
 set @FisChk=0          
 print @FisChk        
        
  /*          
if exists(            
select Stg.*            
from TMtrLStorageHis Stg             
where  stg.FMonth   <  @FMonth               
)            
begin            
    set @AbortStr ='ֻ�ܶ��ڳ����ݽ������'            
    return 0            
end            
*/          
          
if exists( select * from TMtrLStorageHis where Fmonth=@Fmonth and FWhCode =@FWhCode  and  FisChk =@FisChk )      
begin      
   set @abortstr='����ˢ�����ݣ�'          
 return 0      
end          
if (  exists(select * from TInvCostAcctMonthEndClose where FMonth= @FMonth  and FisClosed=1 ) )          
begin           
   set @abortstr='�Ѿ��½ڲ��ܲ�����'          
   return 0          
end          
    
if ( select max(FMonth) from TMtrLStorageHis )<> @Fmonth     
begin    
   set @abortstr='ֻ��ϵͳ�ڳ�����Ҫ��ˣ�'          
   return 0          
end    
    
 update TMtrLStorageHis           
 set  FisChk=@FisChk           
 , FChkTime=case when @FisChk=1 then  getdate() else null end             
 , FChkEmp =case when @FisChk=1 then  @FEmpCode else null end             
 where Fmonth=@Fmonth and FWhCode =@FWhCode            
           
            
   select         
   FisChk=@FisChk           
 , FChkTime=case when @FisChk=1 then  getdate() else null end             
 , FChkEmp =case when @FisChk=1 then  @FEmpCode else null end            
    from TMtrLStorageHis        
    where Fmonth=@Fmonth and FWhCode =@FWhCode     
 ------------------------------------------------------------------------------------ 
