  drop view VCltVd
  go
		    
  
  create view VCltVd  
as    
     
select 1 FisClt,FcltCode   as FCltVdCode  ,FcltName as FCltVdName,FcltTypeCode,FCityCode,FPhoneticize,FAddr, FTel,FMobilePhone,FLinkMan,FZip,FEmail,FNote, convert(bit,FDEL)  FDEL,FCreateEmp,FCreateTime,FLstEditEmp,FLstEditTime    
 FroM  Tclient    
union all     
select 0  FisClt,FVendorCode   as FCltVdCode  ,FVendorName as FCltVdName,FVendorTypeCode,FCityCode,FPhoneticize,FAddr, FTel,FMobilePhone,FLinkMan,FZip,FEmail,FNote,convert(bit,FDEL) ,FCreateEmp,FCreateTime,FLstEditEmp,FLstEditTime    
 FroM  Tvendor    
 go
  
  
--   sp_helptext Pr_GetAuthorizedUserData
  
  go
  drop proc Pr_GetAuthorizedUserData
  go
     
CREATE proc Pr_GetAuthorizedUserData                  
@FempID varchar(30),                  
@PubDataBase varchar(30),                  
@FTableName varchar(30)                   
as                  
/*                  
declare @FempID varchar(30),                  
@PubDataBase varchar(30),                  
@FTableName varchar(30)                   
set @FempID ='E0000014'                  
set @PubDataBase ='BusiSuitBasicInfo'                  
set @FTableName ='TInvType'                  
*/                  
                  
                   
declare @fsql nvarchar(800)                      
declare @CodeField varchar(50)                      
declare @NameField varchar(50)                      
  
set @FempID = replace( @FempID ,'%' ,'')                      
set @fsql =N'  select   @CodeField =CodeField ,@NameField= NameField from  '+@PubDataBase+'.dbo.Tallusertable where FisBasicTable=1 and isnull(FisSys,0)=0  and TableEName=@FTableName    '                      
exec sp_executesql @fsql,N'@CodeField varchar(30)output,@NameField varchar(30) output  , @FTableName varchar(30)', @CodeField  output,@NameField output,@FTableName                    
 print @CodeField  +@NameField                   
                  
declare @FieldsNames varchar(100)        
set    @FieldsNames =   @CodeField  + ', ' +@NameField   + ',FDEL '             
--select * from T_DataRgtDetail                  
                  
if  exists( select * From sys_user where Empid=@FempID and isnull(IsAdmin,0)=0)                  
and exists(select *from Sys_DataRgtitem where  F_TableEName=  @FTableName   and  FempCode =@FempID and isnull(F_BeEffective,0)=1)                   
--select * from  Sys_DataRgtitem                   
begin                  
 set @fsql='select '+ @FieldsNames +'  from '+@FTableName+' where '+@CodeField+' in (select F_code from T_DataRgtDetail where F_TableEName= '''+@FTableName+'''  and FempCode = '''+@FempID+''')'                  
end                  
else                  
 set @fsql='select '+ @FieldsNames +' from '+@FTableName                  
                  
print @fsql                  
                  
exec (@fsql)                  
                  
                             
              
              
              
go
drop proc   Pr_GetAuthorizedCltVd 
go
Create proc Pr_GetAuthorizedCltVd          
@FempID varchar(30),            
@PubDataBase varchar(30),            
@FTableName varchar(30)             
as            
/*            
declare @FempID varchar(30),            
@PubDataBase varchar(30),            
@FTableName varchar(30)             
set @FempID ='E0000014'            
set @PubDataBase ='BusiSuitBasicInfo'            
set @FTableName ='TInvType'            
*/            
            
             
declare @fsql nvarchar(800)                
declare @CodeField varchar(50)                
declare @NameField varchar(50)                
set @FempID = replace( @FempID ,'%' ,'')                      
set @fsql =N'  select   @CodeField =CodeField ,@NameField= NameField from  '+@PubDataBase+'.dbo.Tallusertable where FisBasicTable=1 and isnull(FisSys,0)=0  and TableEName=@FTableName    '                
exec sp_executesql @fsql,N'@CodeField varchar(30)output,@NameField varchar(30) output  , @FTableName varchar(30)', @CodeField  output,@NameField output,@FTableName              
 print @CodeField  +@NameField             
            
declare @FieldsNames varchar(100)  
set    @FieldsNames =   '*'       
--select * from T_DataRgtDetail            
            
if  exists( select * From sys_user where Empid=@FempID and isnull(IsAdmin,0)=0)            
and exists(select *from Sys_DataRgtitem where  F_TableEName=  @FTableName   and  FempCode =@FempID and isnull(F_BeEffective,0)=1)             
--select * from  Sys_DataRgtitem             
begin            
 set @fsql='select '+ @FieldsNames +'  from '+@FTableName+' where '+@CodeField+' in (select F_code from T_DataRgtDetail where F_TableEName= '''+@FTableName+'''  and FempCode = '''+@FempID+''')'            
end            
else            
 set @fsql='select '+ @FieldsNames +' from '+@FTableName            
            
print @fsql            
            
exec (@fsql)            


go  
alter proc Pr_GetAuthorizedInvType     
@FempID varchar(30),            
@PubDataBase varchar(30),            
@FTableName varchar(30)             
as            
/*            
declare @FempID varchar(30),            
@PubDataBase varchar(30),            
@FTableName varchar(30)             
set @FempID ='E0000014'            
set @PubDataBase ='BusiSuitBasicInfo'            
set @FTableName ='TInvType'            
*/            
            
             
declare @fsql nvarchar(800)                
declare @CodeField varchar(50)                
declare @NameField varchar(50)                						 
declare @FieldsNames varchar(200)  
set @FempID = replace( @FempID ,'%' ,'')                      

set    @FieldsNames =   'FinvTypeCode,FinvTypeName,space(len(FinvTypeCode)-1)+FinvTypeName as FinvTypeNameX,FGeneralMtrl,FPhoneticize,fisMtrl '       
--select * from T_DataRgtDetail            
            
if  exists( select * From sys_user where Empid=@FempID and isnull(IsAdmin,0)=0)            
and exists(select *from Sys_DataRgtitem where  F_TableEName=  @FTableName   and  FempCode =@FempID and isnull(F_BeEffective,0)=1)             
--select * from  Sys_DataRgtitem             
begin            
 set @fsql='select '+ @FieldsNames +'  from '+@FTableName+' where '+@CodeField+' in (select F_code from T_DataRgtDetail where F_TableEName= '''+@FTableName+'''  and FempCode = '''+@FempID+''')'            
end            
else            
 set @fsql='select '+ @FieldsNames +' from '+@FTableName            
            
print @fsql            
            
exec (@fsql)            


go



	drop proc Pr_GetAuthorizedInOutType
go
Create proc Pr_GetAuthorizedInOutType      
@FempID varchar(30),            
@PubDataBase varchar(30),            
@FTableName varchar(30)             
as            
/*            
declare @FempID varchar(30),            
@PubDataBase varchar(30),            
@FTableName varchar(30)             
set @FempID ='E0000014'            
set @PubDataBase ='BusiSuitBasicInfo'            
set @FTableName ='TInvType'            
*/            
            
             
declare @fsql nvarchar(800)                
declare @CodeField varchar(50)                
declare @NameField varchar(50)                
declare @FieldsNames varchar(100)  
set @FempID = replace( @FempID ,'%' ,'')                      


set    @FieldsNames =   '*'       
--select * from T_DataRgtDetail            
            
if  exists( select * From sys_user where Empid=@FempID and isnull(IsAdmin,0)=0)            
and exists(select *from Sys_DataRgtitem where  F_TableEName=  @FTableName   and  FempCode =@FempID and isnull(F_BeEffective,0)=1)             
--select * from  Sys_DataRgtitem             
begin            
 set @fsql='select '+ @FieldsNames +'  from '+@FTableName+' where '+@CodeField+' in (select F_code from T_DataRgtDetail where F_TableEName= '''+@FTableName+'''  and FempCode = '''+@FempID+''')'            
end            
else            
 set @fsql='select '+ @FieldsNames +' from '+@FTableName            
            
print @fsql            
            
exec (@fsql)            

				   