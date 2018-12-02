drop proc Fn_GetOutSourceWhInCostPrice
go 
CREATE function Fn_GetOutSourceWhInCostPrice
(@FWhInFID varchar(50))returns decimal(19,3)
begin
   --  declare @FWhInFID varchar(30)
   declare @FInvCode varchar(30)  ,@FWhCode varchar(30) ,@FinDate smalldatetime	,@FisExpenses varchar(30)  ,@Fprice decimal(19,6),
           @FAvgPrice decimal(19,6)
   
  -- set @FWhInFID='{58D69F0A-A446-4BFE-8AE6-3B2723C1D670}'
   
   select @FInvCode=dl.FinvCode,@FWhCode =m.FWhCode, @FinDate =FinDate ,@FisExpenses = iotp.FisExpenses, @Fprice = dl.Fprice
   --select  dl.FinvCode, m.FWhCode,  FinDate , iotp.FisExpenses, dl.Fprice
   from Twhindl dl 
   join Twhin m on dl.FWhinCode=m.FWhinCode 
    join TinOutType iotp  on iotp.FinoutTypeCode = m.FinoutTypeCode
   where dl.F_ID = @FWhInFID  
   
  -- select  @FInvCode ,@FWhCode , @FinDate ,@FisExpenses , @Fprice 
   
   select @FAvgPrice = FAvgPrice from TMtrLStorageHis   where FinvCode = @FinvCode and FWhCode=@FWhCode	 and Fmonth<=dateadd(m, -1, dbo.Fn_GetFirstDayofMonth(@FinDate))

   if isnull(@FisExpenses,0)= 0
      set @FAvgPrice= @Fprice
    		    
   return	 @FAvgPrice
   
end

 



