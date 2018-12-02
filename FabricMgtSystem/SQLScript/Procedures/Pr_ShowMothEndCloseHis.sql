drop proc Pr_ShowMothEndCloseHis
go 
 create  proc Pr_ShowMothEndCloseHis                    
@FEmpCode varchar(20) ='%'            
--,@Fyear    varchar(20)                   
as                    
   
 if not exists (  select * from    TMonthEndClose where FisClosed=1)  
      truncate table TMonthEndClose  
                        
 declare @i int                    
 declare @month smalldatetime   ,@FStartCloseMonth varchar(10)                 
 set @i=0                    
     
                     
 select @FStartCloseMonth=FParamValue From TParamsAndValues where FParamCode= '01050202'    
 --select  @month= dbo.Fn_GetFirstDayofMonth  delete TMonthEndClose    select Getdate()  
 set @month=CONVERT(smalldatetime, @FStartCloseMonth  )        
 print @month    
 while (  @month < getdate() )                    
 begin                    
     insert into TMonthEndClose (fMonth , F_ID ,FPhoneticize,FisClosed )             
     select  @month , newid() , '' ,0 where not exists( select * from    TMonthEndClose where FMonth= @Month )                 
                     
    set @month=dateadd(m,1,@month)                    
    set @i=@i+1                    
 end                    
                     
select FIsClosed ,FMonth,FClsTime , year(fMonth) as FYear  ,month(fmonth) as FMonth2             
,case when Fisclosed=1  then 'рятб╫А' else '' end as FClosedFlag             
--- ,convert(smalldatetime,  convert(varchar(4), year( dateadd (m,-1,getdate()) ))+'/1/1')          
from TMonthEndClose            
where  fMonth >= convert(smalldatetime,  convert(varchar(4), year( dateadd (year,-1,getdate()) ))+'/1/1')          
order by fmonth desc           
               
          
          
 ------------------------------------------------------------------------------------ 
