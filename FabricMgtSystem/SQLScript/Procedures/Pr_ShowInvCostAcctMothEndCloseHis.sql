drop proc Pr_ShowInvCostAcctMothEndCloseHis
go 
 CREATE  proc Pr_ShowInvCostAcctMothEndCloseHis                    
@FEmpCode varchar(20) ='%'            
--,@Fyear    varchar(20)                   
as                    
   
   
 if not exists (  select * from    TInvCostAcctMonthEndClose where FisClosed=1)  
      truncate table TInvCostAcctMonthEndClose  
                        
 declare @i int                    
 declare @month smalldatetime   ,@FStartCloseMonth varchar(10)                 
 set @i=0                    
     
                     
 select @FStartCloseMonth=FParamValue From TParamsAndValues where FParamCode= '01050202'    
 --select  @month= dbo.Fn_GetFirstDayofMonth  delete TInvCostAcctMonthEndClose    select Getdate()  
 set @month=CONVERT(smalldatetime, @FStartCloseMonth  )        
 print @month    
 while (  @month < getdate() )                    
 begin                    
     insert into TInvCostAcctMonthEndClose (fMonth , F_ID ,FisClosed )             
     select  @month , newid(),0 where not exists( select * from    TInvCostAcctMonthEndClose where FMonth= @Month )                 
                     
    set @month=dateadd(m,1,@month)                    
    set @i=@i+1                    
 end                    
                     
select FIsClosed ,FMonth,FClsTime , year(fMonth) as FYear  ,month(fmonth) as FMonth2             
,case when Fisclosed=1  then 'рятб╫А' else '' end as FClosedFlag             
--- ,convert(smalldatetime,  convert(varchar(4), year( dateadd (m,-1,getdate()) ))+'/1/1')          
from TInvCostAcctMonthEndClose            
where  fMonth >= convert(smalldatetime,  convert(varchar(4), year( dateadd (year,-1,getdate()) ))+'/1/1')          
order by fmonth desc           
               
          
          
 ------------------------------------------------------------------------------------ 
