drop proc Fn_GetDateWithoutTime
go 
 
CREATE function Fn_GetDateWithoutTime(@Fday smalldatetime ) 
returns smalldatetime  
as  
begin  
--print cast(@Fday as int)   
return DATEADD(dd, DATEDIFF(d, 0,  @Fday ), 0)		
end
