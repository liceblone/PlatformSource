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
    set @AbortStr ='只能对期初数据进行审核'            
    return 0            
end            
*/          
          
if exists( select * from TMtrLStorageHis where Fmonth=@Fmonth and FWhCode =@FWhCode  and  FisChk =@FisChk )      
begin      
   set @abortstr='请先刷新数据！'          
 return 0      
end          
if (  exists(select * from TInvCostAcctMonthEndClose where FMonth= @FMonth  and FisClosed=1 ) )          
begin           
   set @abortstr='已经月节不能操作！'          
   return 0          
end          
    
if ( select max(FMonth) from TMtrLStorageHis )<> @Fmonth     
begin    
   set @abortstr='只有系统期初才需要审核！'          
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
