drop proc   Pr_EnquiryQuotationChk1
go
create proc Pr_EnquiryQuotationChk1
@abortstr   varchar(100) output ,                                      
@warningstr varchar(100) output ,                                       
@FEnquiryQuotationCode varchar(20),                                                                                    
@empid varchar(20)     ,                                                                            
@longinID  varchar(20)   
as

update TEnquiryQuotationM  set Fischk=1 ,FchkEmp=@empid ,FchkTime= getdate() 
where  FEnquiryQuotationCode=  @FEnquiryQuotationCode                                                                               

return 1

go

drop proc	 Pr_EnquiryQuotationChk0
go
create proc Pr_EnquiryQuotationChk0
@abortstr   varchar(100) output ,                                      
@warningstr varchar(100) output ,                                       
@FEnquiryQuotationCode varchar(20),                                                                                    
@empid varchar(20)     ,                                                                            
@longinID  varchar(20)                                                                                           
as

update TEnquiryQuotationM  set Fischk=0 ,FchkEmp=null ,FchkTime=null    
where  FEnquiryQuotationCode=  @FEnquiryQuotationCode                                                                               

return 1

go


   

alter proc Pr_EnquiryQuotationLst	                                    
  @FCltVdCode  varchar(20)      
, @FInvName  varchar(20)      
, @FInvTypeCode  varchar(20)      
, @FColorCode  varchar(20)      
, @FGoodCode  varchar(20)      
, @FBeginDate  smalldatetime      
, @FEndDate  smalldatetime
, @FIncludeUnChk  bit      
, @FEmpCode     varchar(20)
, @FPriceTypeCode varchar(30)    
       
as      
                                                                                      
 
create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
create table #TPriceType ( FPriceTypeCode	varchar(30) , FPriceTypeName	varchar(30)  ,FDEL bit )
create table #TinvType   ( FinvTypeCode		varchar(30) , FinvTypeName		varchar(30)  ,FDEL bit )
create table #TWareHouse ( FWhCode			varchar(30) , FWhName			varchar(30)  ,FDEL bit )	
create table #TinOutType ( FinOutTypeCode	varchar(30) , FinOutTypeName	varchar(30)  ,FDEL bit )

insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
insert into	 #TPriceType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TPriceType'
insert into  #TWareHouse	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TWareHouse'
insert into  #TinvType		exec Pr_GetAuthorizedUserData @FEmpCode ,'SalesBasicInfo','TInvType'
insert into  #TinOutType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TInOutType '

select clt.FCltCode as fCltVdCode , clt.FcltName as FcltVdName   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode
join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
union all 
select vd.FVendorcode	, vd.FVendorName as FcltVdName
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode
join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode

			   

select 
case when M.FIschk=1 then '¡Ì'else '' end as FIsChk,
m.FEnquiryQuotationCode,
M.FNote,		M.FDate,		M.FCltVdCode,		CltVd.FcltvdName as  FcltvdCodeLkp   ,
M.FHandlerEmp,	Hep.FEmpName as FHandlerEmplkp,		M.FAvaliableDays,		M.FPriceTypeCode, 
ptp.FPriceTypeName as FPriceTypeCodelkp	,			DL.FInvCode,			DL.FNote as FdlNote,
DL.FPrice,			DL.FInvName,					DL.FColorCode,			DL.FGoodCode,
DL.FTaxPrice,		DL.FQty,						DL.FBrand
from  TEnquiryQuotationM  m 
join  TEnquiryQuotationDL dl on m.FEnquiryQuotationCode =dl.FEnquiryQuotationCode
join #TCltVD      as CltVd       on CltVd.FcltvdCode=M.FcltvdCode      
join #TinvType   invtp on invtp.FinvTypeCode=inv.FinvTypeCode                                                                          
join #TPriceType  ptp on ptp.FCode =  m.FPriceTypeCode

left join ( select   FCode , FName  from #TCltVD    ) as CltVd   on CltVd.FCode=M.FcltvdCode      
left join Temployee  Hep on Hep.FempCode=M.FHandlerEmp     
left join Tinventory inv on inv.FinvCode=DL.FinvCode       
left join Tunit      mut on mut.Funitcode=inv.FMainUnitCode 
	 
	 
 where isnull(M.FCltVdCode,'') like @FCltVdCode      
and   isnull(DL.FinvName,'')    like @FInvName      
and   isnull(inv.FInvTypeCode ,'') like @FInvTypeCode      
and   isnull(inv.FcolorCode ,'') like @FColorCode      
and   isnull(inv.FgoodCode ,'') like @FGoodCode   




drop table #TPriceType
drop table #TCltVD