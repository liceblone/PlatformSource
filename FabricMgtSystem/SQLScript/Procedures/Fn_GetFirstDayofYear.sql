drop proc Fn_GetFirstDayofYear
go 

CREATE function Fn_GetFirstDayofYear(@Fday smalldatetime ) returns smalldatetime  
as  
begin  
--print cast(@Fday as int)   
return --convert(smalldatetime,FLOOR( cast(@Fday as decimal(19,6)) ) )-day(@FDay)+1  
dateadd(m,-month( @Fday )+1, convert(smalldatetime,FLOOR( cast(@Fday as decimal(19,6)) ) )-day(@Fday)+1  )
end 


