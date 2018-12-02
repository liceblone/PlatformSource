create proc Pr_EvaluateCltCreditStatus
@BeginDate smalldatetime
@BeginEnd  smalldatetime

@ClientID varchar(20)

as

select *from  sys_user

create table #CltBalance(     GatheringEmp  varchar(20),               
Code  varchar(20),Name  varchar(50),NickName  varchar(20),ClassId  varchar(50),FatherId  varchar(20),RegionId  varchar(50),  
TaxId  varchar(30),LawMan  varchar(20),Bank  varchar(50),BankId  varchar(30),LinkMan  varchar(30),Tel  varchar(50),  
Fax  varchar(50),Addr  varchar(50),Zip  varchar(6),Mobile  varchar(23),BeepPager  varchar(20),Url  varchar(50),  
Email  varchar(50),Note  text,Demand  varchar(200),Products  varchar(200),IsPub  bit,Balance  money,AddEmpId  varchar(20),  
MIncrease  numeric(5),MSubtract  numeric(5),ChkFund  decimal(17,2),rpRemain  decimal(17,2))  
declare @Today smalldatetime  ---,  @EmpId varchar(20)    drop table #CltBalance  
set @Today =GETDATE()  
insert into #CltBalance 
exec fn_Client_fund '', @Today ,'日期','Admin','纯客户'  

delete	 #CltBalance  where chkfund <=0 and  rpRemain<=0


select *from #CltBalance    ---  drop table #ATItems

create table #ATItems(
ClientId   varchar(20)
,BillCode    varchar(20)
,GetFund decimal(15,3)
,FDate smalldatetime
,IsChk  bit
,ChkTime smalldatetime
,billtime smalldatetime	 
,Balance  decimal(19,3)
,Findex	 int identity(1,1)
,IsStartingPoint bit
CONSTRAINT PK_ClientIDBilltime PRIMARY KEY (clientid,billtime desc,BillCode)
)

		 select * from fn_shldin
		 
insert into #ATItems(ClientId,BillCode, GetFund,FDate,IsChk,ChkTime,BillTime,Balance)
select ClientId,code, GetFund as xFund,InvoiceDate,IsChk,ChkTime ,billtime ,GetFund as Balance 
from sl_invoice where billtime >= dateadd(year,-3,getdate()) and  ClientId in (select Code from #CltBalance)                                    
union all               
select ClientId,code,PayFund,InDate,IsChk,ChkTime,billtime , PayFund as Balance 
from fn_shldin where billtime >= dateadd(year,-3,getdate()) and  ClientId in (select Code from #CltBalance)  
order by clientid,billtime desc

select *from #ATItems

Declare @i int	 ,@balance decimal(29,3) ,@rpRemain decimal(19,2), @ClientID varchar(20)
Declare Cur Cursor For Select  code, rpRemain From #CltBalance   
Open Cur
Fetch next From Cur Into @ClientID	,@rpRemain
While @@fetch_status=0     
Begin
    select @balance =0 
    print @ClientID   
    print @rpRemain
    Update #ATItems Set   Balance =@balance	  ,@balance=GetFund+@balance  
    ,IsStartingPoint=case  when  Balance>@rpRemain then 1 end			   where clientId =@clientId 
    
	delete #ATItems 
	where clientId =@clientId 
	and  Findex<>(select findex from #ATItems 
	              where clientId =@clientId and IsStartingPoint=1 
	              and Findex=(select min(findex) from #ATItems where clientId =@clientId and IsStartingPoint=1 )
	              )	     /* */
    Fetch Next From Cur Into @ClientID   ,@rpRemain
End   
Close Cur   
Deallocate Cur

select * from #ATItems where  clientId in(  Select  top 3 code From #CltBalance )	  order by clientId, billtime	 desc
 Select   * From #CltBalance 
HZ001427 
HZ001124  
HZ001493

6241484.20
4048248.27
3356978.80