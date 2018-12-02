


select * into #tmp from salesBasicinfo.dbo.Tallusertable where isnull( FisSys ,0) =0

declare @TableName varchar(30)
declare @sql varchar(500)
while (exists(select * From #tmp))
begin
	select @tableName = TableEName from #tmp
 
    if exists( select * From syscolumns where id=object_id(@tableName) and name='FLstEditTime' )
    begin
       set @sql='alter table '+@tableName +' alter column FLstEditTime datetime'
       print @sql
    end

    delete #tmp where TableEName=@TableName
end

drop table #tmp