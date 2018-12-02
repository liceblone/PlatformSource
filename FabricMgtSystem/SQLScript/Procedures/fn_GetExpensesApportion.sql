drop proc fn_GetExpensesApportion
go 
create function fn_GetExpensesApportion( @F_ID varchar(50) )	
returns decimal(19,6)
as
begin
-- declare @F_ID varchar(50) set @F_ID='{E17F2732-1E4C-4EFA-9D33-761B7AC2204D}'

declare @FApportionAMt decimal(19,6)		
select @FApportionAMt=sum( isnull( DL.FApportionAMt,0 ))
	from TPaymentApportionDL DL 
	join TPaymentApportion   M on DL.FPaymentApportionCode =M.FPaymentApportionCode
	where  M.FisChk=1  and DL.FWhDLFID=@F_ID

return 	@FApportionAMt	 
--print @FApportionAMt
end
