--  exec Pr_FnOutItems '%','%','%','%','%','%','%','%','%','%','2012-12-17 00:00:00','2013-06-16 00:00:00',1      
drop proc Pr_FnOutItems
go
CREATE proc Pr_FnOutItems      
   @FCltVdCode   varchar(20)      
,  @FWhCode   varchar(20)      
,  @Fwkshopcode   varchar(20)      
,  @FInOutTypeCode   varchar(20)      
,  @FInvName   varchar(20)      
,  @FSLOrdCode   varchar(20)      
,  @FProduceOrdCode   varchar(20)      
,  @FInvTypeCode   varchar(20)      
,  @FColorCode   varchar(20)      
,  @FGoodCode    varchar(20)      
,  @FBeginDate   smalldatetime      
,  @FEndDate     smalldatetime      
,  @FOnyUnChk  bit  
,  @FEmpCode varchar(30)  =''  
      
      
as    
--  declare @FEmpCode varchar(30)  

--create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
-- insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
create table #TPriceType ( FPriceTypeCode	varchar(30) , FPriceTypeName	varchar(30)  ,FDEL bit )
	insert into	 #TPriceType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TPriceType'
create table #TinvType   ( FinvTypeCode		varchar(30) , FinvTypeName		varchar(30)  ,FDEL bit )
	insert into  #TinvType		exec Pr_GetAuthorizedUserData @FEmpCode ,'SalesBasicInfo','TInvType'
create table #TWareHouse ( FWhCode			varchar(30) , FWhName			varchar(30)  ,FDEL bit )	
	insert into  #TWareHouse	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TWareHouse'
create table #TinOutType ( FinOutTypeCode	varchar(30) , FinOutTypeName	varchar(30)  ,FDEL bit )
	insert into  #TinOutType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TInOutType '


select clt.FCltCode as fCltVdCode , clt.FcltName as FcltVdName   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode
join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
union all 
select vd.FVendorcode	, vd.FVendorName as FcltVdName
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode
join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode

      
select         
DL.FinvCode,		DL.FinvName,		DL.FGoodCode,		DL.FproductName,      
DL.FColorCode,      DL.Fprice,			DL.Fnote,			DL.FWhCode,      
DL.FOutQty,			DL.FPackageQty,     DL.FQtyitem,      
DL.FinOutTypeCode,  DL.Fdate,			DL.FInvAlias,      
DL.FReconciled,     DL.FReconcileEmp,   DL.FReconcileTime,      
DL.FSLOrdCode,      DL.FProduceOrdCode, DL.FPdtInvCode,      
DL.FPurchOrdCode,DL.Fprice*FOutQty as FAmt, inv.FWidth,inv.FWeight,  M.FwhoutCode,    
 itp.FinOutTypeName , Eot.FempName as FOutEmpLkp ,wh.FWhName ,wsp.FWkShopName,      
 mut.FunitName as FmainunitCodeLkp,Aut.FunitName as FAssistunitCodeLkp,inv.FchgRate,inv.Fchgrate*FoutQty as FassistQty ,invtp.FInvTypeName      
,case when M.Fischk=1 then '¡Ì'else '' end as FIsChk , inv.FgoodCode as FGoodCodelkp ,CltVd.FcltvdName as FCltVdCodeLkp ,M.FOutDate      
,case when M.FFNischk=1 then '¡Ì'else '' end as FFNIsChk ,M.FNote as FMNote      
,ECt.FempName as FcreateEmplkp      
,inv.Fnote as FInvNoteLkp    ,inv.FBrand as FBrandlkp   
 into #Tmp      
From TWhOutDL DL      
join    TWhOutM  M   on M.FwhoutCode=DL.FwhoutCode      
left join Tinventory inv on inv.FinvCode=DL.FinvCode      
	 join #TinvType   invtp on invtp.FinvTypeCode=inv.FinvTypeCode      
	 join #TCltVD      as CltVd       on CltVd.FcltvdCode=M.FcltvdCode      
     join #TinOutType itp on itp.FinOutTypeCode=DL.FinOutTypeCode      
left join Temployee  Eot on Eot.FempCode=m.FoutEmp      
left join Temployee  ECt on ECt.FempCode=m.FCreateEmp      
	 join #TWareHouse wh  on wh.FwhCode=DL.FwhCode      
left join TWorkShop  wsp on wsp.FWkShopCode=DL.FWkShopCode      
left    join Tunit      Mut on Mut.Funitcode=Inv.FmainunitCode      
left    join Tunit      Aut on Aut.Funitcode=Inv.FAssistunitCode      
where isnull(M.FCltVdCode ,'')         like @FCltVdCode      
and   isnull(wh.FwhCode,'')   like @FWhCode      
and   isnull(DL.FWkShopCode,'') like @FWkShopCode      
and   isnull(DL.FinOutTypeCode,'')  like @FInOutTypeCode      
and   isnull(DL.FinvName,'')        like @FInvName      
and   isnull(dl.FSLOrdCode ,'')     like @FSLOrdCode      
and   isnull(dl.FProduceOrdCode ,'')like @FProduceOrdCode       
and   isnull(inv.FInvTypeCode ,'') like @FInvTypeCode      
and   isnull(inv.FcolorCode ,'') like @FColorCode      
and   isnull(inv.FgoodCode ,'') like @FGoodCode      
and    M.FOutDate>=@FBeginDate and    M.FOutDate<=@FEndDate     
order by M.FCreateTime desc ,DL.FDate desc       
      
--select * from #tmp      
      
select * from #tmp       where    (@FOnyUnChk=1  and FFNischk ='') or @FOnyUnChk=0    
      
      
      
drop table #tmp     

--drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 
drop table #TPriceType  
drop table #TWareHouse  	
drop table #TinOutType 
drop table #TinvType    
 
 ------------------------------------------------------------------------------------ 
 
 go
 
drop  proc Pr_FnInItems  
 
 go
 create proc Pr_FnInItems      
  @FCltVdCode  varchar(20)      
, @FWhCode  varchar(20)      
, @FWkShopCode  varchar(20)      
, @FInOutTypeCode  varchar(20)      
, @FInvName  varchar(20)      
, @FInvTypeCode  varchar(20)      
, @FColorCode  varchar(20)      
, @FGoodCode  varchar(20)      
, @FBeginDate  smalldatetime      
, @FEndDate  smalldatetime      
, @FOnyUnChk  bit 
, @FempCode varchar(30)     
      
as      


--create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
-- insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
create table #TPriceType ( FPriceTypeCode	varchar(30) , FPriceTypeName	varchar(30)  ,FDEL bit )
	insert into	 #TPriceType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TPriceType'
create table #TinvType   ( FinvTypeCode		varchar(30) , FinvTypeName		varchar(30)  ,FDEL bit )
	insert into  #TinvType		exec Pr_GetAuthorizedUserData @FEmpCode ,'SalesBasicInfo','TInvType'
--create table #TWareHouse ( FWhCode			varchar(30) , FWhName			varchar(30)  ,FDEL bit )	
--	insert into  #TWareHouse	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TWareHouse'
create table #TinOutType ( FinOutTypeCode	varchar(30) , FinOutTypeName	varchar(30)  ,FDEL bit )
	insert into  #TinOutType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TInOutType '


select clt.FCltCode as fCltVdCode , clt.FcltName as FcltVdName   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
union all 
select vd.FVendorcode	, vd.FVendorName as FcltVdName
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode


select DL.F_ID,M.FCreateEmp,M.FCreateTime,M.FPrdcPLCode,M.FWhCode,M.FInDate,  inv.FWidth,inv.FWeight, inv.FBrand as FBrandLkp,     
M.FVendorCode,M.FWhinCode,DL.FPrice,DL.FPrice*DL.FmainQty as FAmt,M.FWkShopCode , M.FNote as FMNote       
,DL.FpurchOrdCode   ,case when M.FIschk=1 then '¡Ì'else '' end as FIsChk,M.FInOutTypeCode,      
DL.FInvCode,DL.FInvName,DL.FGoodCode,DL.FProductName,DL.FColorCode,DL.FMainQty,DL.FChgRate*DL.FMainQty as FAssistQty,dl.FInvAlias, DL.FNote ,      
itp.FInOutTypeName ,CltVd.FCltVdName ,Cep.FempName as FCreateEmpLkp,wh.FWhname,wsp.FWkShopName,mut.FUnitName as FMainUnitCodeLkp,dl.FPackageQty,invtp.FInvTypeName  ,iep.FEmpName as FInEmpLkp       
,case when M.FFNischk=1 then '¡Ì'else '' end as FFNIsChk         
,inv.Fnote as FInvNoteLkp      
into #tmp      
 From TWhin  M      
join TWhinDL DL on M.FwhinCode=DL.FwhinCode 
left join Tinventory inv on inv.FinvCode=DL.FinvCode       
	 join #TinvType   invtp on invtp.FinvTypeCode=inv.FinvTypeCode       
	 join #TinOutType itp on itp.FinOutTypeCode=M.FinOutTypeCode       
	 join #TCltVD CltVd		on CltVd.FcltvdCode=M.FVendorCode      
left join Temployee  Cep on Cep.FempCode=M.FCreateEmp      
left join Temployee  iep on iep.FempCode=M.FINEmp      
left join TWareHouse wh  on wh.FwhCode=M.FwhCode      
left join TWorkShop  wsp on wsp.FWkShopCode=M.FWkShopCode      
left join Tunit      mut on mut.Funitcode=inv.FMainUnitCode      
      
where isnull(M.FVendorCode,'') like @FCltVdCode      
and   isnull(wh.FwhCode,'')   like @FWhCode      
and   isnull(M.FWkShopCode,'') like @FWkShopCode      
and   isnull(M.FinOutTypeCode,'') like @FInOutTypeCode      
and   isnull(DL.FinvName,'')    like @FInvName      
and   isnull(inv.FInvTypeCode ,'') like @FInvTypeCode      
and   isnull(inv.FcolorCode ,'') like @FColorCode      
and   isnull(inv.FgoodCode ,'') like @FGoodCode      
and   M.FinDate>=@FBeginDate and    M.FinDate<=@FEndDate    
order by M.FCreateTime  desc , M.FWhCode        
      
      
select * from #tmp  where    (@FOnyUnChk=1  and FFNischk ='') or @FOnyUnChk=0     
      
      
      
drop table #tmp      
 ------------------------------------------------------------------------------------ 
 
--drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 
drop table #TPriceType  
-- drop table #TWareHouse  	
drop table #TinOutType 
drop table #TinvType    

go


			drop    	 proc Pr_CltVdARItems 
			go
			
CREATE proc Pr_CltVdARItems        
@FbeginDate smalldatetime,                                                                          
@FendDate   smalldatetime,                                                                          
@FCltTypeCode varchar(20),                                                                          
@FCltVdCode   varchar(20),        
@FOnyUnChk       bit  ,    
@FisClt bit  ,
@FEmpCode varchar(20)   
as      



create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
 
 select clt.FcltCode as FCltVdCode,clt.FCltName as FCltVdName,clt.FCltTypeCode , 1 as Fisclt   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
 where clt.FCltTypeCode like @FCltTypeCode
union all 
select vd.FVendorcode	, vd.FVendorName as FcltVdName	,vd. FVendorTypeCode ,0
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode
where vd.FvendorTypeCode like @FCltTypeCode   
  
   select         
   AR.F_ID,  AR.FCreateTime,AR.FGlCCode,AR.FDate,AR.FClerkEmp    ,AR.FNote,AR.FCltVdCode,AR.FisClt,AR.FBillCode,AR.FisSys,AR.FModalType        
   ,AR.FFormID,AR.Famt,AR.FChkTime,AR.FShRpCode,AR.FQty,AR.FReconcileTime --,AR.FReconcileEmp        
   ,AR.FTaxRate,AR.FInvoiceAmt,AR.FTax        
   , case when AR.FReconciled=1 then '¡Ì'else '' end as FReconciled         
   , case when AR.Fischk=1 then '¡Ì'else '' end as FIsChk         
   ,CltVd.FCltVdName    ,GLC.FGLCName       ,EChk.FEmpName as  FChkEmplkp    ,ECt.FEmpName as  FCreateEmplkp        
   ,ClerkEmp.FEmpName as  FClerkEmplkp        
   into #tmp        
   From TPayReceiveAble  AR        
        join   #TCltVD  CltVd on CltVd.FCltVdCode=AR.FCltVdCode        
        join   #TGLC   GLC on GLC.FGLCCode=AR.FGLCCode        
   left join Temployee  EChk on EChk.FempCode=AR.FChkEmp            
   left join Temployee  ECt on ECt.FempCode=AR.FCreateEmp         
   left join Temployee  ClerkEmp on ClerkEmp.FempCode=AR.FClerkEmp        
   WHERE cLTVD.FisClt=@FisClt        
           
          
select * from #tmp            
where (@FOnyUnChk=1  and Fischk ='' )       
or    (@FOnyUnChk=0   and Fdate>=@FbeginDate and FDate<@FendDate+1 and FCltVdCode like @FCltVdCode)       
        
        
drop table #tmp      
      
 ------------------------------------------------------------------------------------ 			   
 
drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 
 
 
 go
 
 drop proc Pr_CltVdPayReceiveItems
 go
   
CREATE proc Pr_CltVdPayReceiveItems        
@FbeginDate smalldatetime,                                                                          
@FendDate   smalldatetime,                                                                          
@FCltTypeCode varchar(20),                                                                          
@FCltVdCode   varchar(20),        
@FOnyUnChk       bit   ,    
@FisClt bit     ,
@FEmpCode	   varchar(30)
as        


create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
 
 select clt.FcltCode as FCltVdCode,clt.FCltName as FCltVdName,clt.FCltTypeCode , 1 as Fisclt   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
 where clt.FCltTypeCode like @FCltTypeCode
union all 
select vd.FVendorcode	, vd.FVendorName as FcltVdName	,vd. FVendorTypeCode ,0
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode
where vd.FvendorTypeCode like @FCltTypeCode 

   select         
   PR.F_ID,  PR.FCreateTime,PR.FGlCCode,PR.FDate,PR.FClerkEmp   ,PR.FNote,PR.FCltVdCode,PR.FisClt,PR.FBillCode        
   ,PR.Famt,PR.FChkTime,PR.FRpCode,PR.FQty,PR.FReconcileTime --,PR.FReconcileEmp        
   , case when PR.FReconciled=1 then '¡Ì'else '' end as FReconciled         
   , case when PR.Fischk=1 then '¡Ì'else '' end as FIsChk       ,CltVd.FCltVdName      
   ,GLC.FGLCName     ,EChk.FEmpName as  FChkEmplkp      ,ECt.FEmpName as  FCreateEmplkp     ,ClerkEmp.FEmpName as  FClerkEmplkp        
   into #tmp        
   From TPayReceive   PR        
     join #TCltVD CltVd on CltVd.FCltVdCode=PR.FCltVdCode        
     join   #TGLC   GLC on GLC.FGLCCode=PR.FGLCCode        
   left join Temployee  EChk on EChk.FempCode=PR.FChkEmp            
   left join Temployee  ECt on ECt.FempCode=PR.FCreateEmp         
   left join Temployee  ClerkEmp on ClerkEmp.FempCode=PR.FClerkEmp   
   where cltvd.Fisclt = @Fisclt       
           
           
          
select * from #tmp            
where (@FOnyUnChk=1  and Fischk ='')         
or    (@FOnyUnChk=0   and Fdate>=@FbeginDate and FDate<@FendDate+1 and FCltVdCode like @FCltVdCode)       
        
drop table #tmp        
 ------------------------------------------------------------------------------------ 
 
drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 


go

drop   proc Pr_GetPurchOrderItems
go
  
create proc Pr_GetPurchOrderItems    
@FbeginDate smalldatetime    
, @FendDate  smalldatetime    
 , @FCltCode varchar(30)     
 , @FVendorCode varchar(30)     
 , @FinvName varchar(30)    
  , @FColorCode varchar(30)     
  , @FGoodCode varchar(30)     
  , @FContractNo varchar(30)     
  , @FUnClosed  bit
  , @FempCode varchar(30)    
    
as    

--create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
-- insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
--create table #TPriceType ( FPriceTypeCode	varchar(30) , FPriceTypeName	varchar(30)  ,FDEL bit )
--	insert into	 #TPriceType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TPriceType'
create table #TinvType   ( FinvTypeCode		varchar(30) , FinvTypeName		varchar(30)  ,FDEL bit )
	insert into  #TinvType		exec Pr_GetAuthorizedUserData @FEmpCode ,'SalesBasicInfo','TInvType'
--create table #TWareHouse ( FWhCode			varchar(30) , FWhName			varchar(30)  ,FDEL bit )	
--	insert into  #TWareHouse	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TWareHouse'
--create table #TinOutType ( FinOutTypeCode	varchar(30) , FinOutTypeName	varchar(30)  ,FDEL bit )
--	insert into  #TinOutType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TInOutType '


--select clt.FCltCode as fCltVdCode , clt.FcltName as FcltVdName   into #TCltVD 
--from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
-- union all 
select vd.FVendorcode	as fCltVdCode, vd.FVendorName as FcltVdName	   into #TCltVD 
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode
    
select M.FPurchOrdCode,M.FPurchTypeCode,M.FPurchDate,Dl.FRequestDate ,M.FcltCode,    
M.FNote as FMnote,M.FChkEmp, M.FChkTime,  M.FPrincipalEmp,epp.FempName as FPrincipalEmpLkp    
,case when M.FisChk=1 then '¡Ì' else '' end as FisChk    
,case when DL.FisCls =1 then '¡Á'  else '' end as FIsCls , DL.FPurchPrice*DL.FPurchQty  as FAmt     
,invtp.FinvTypename      
,DL.FInvAlias  ,DL.FinvCode,DL.FPurchPrice,DL.FPurchQty,DL.FNote,M.FvendorCode ,DL.Finqty ,DL.FPchsRtnOutQty , DL.FPurchQty - isnull ( DL.Finqty ,0) + isnull ( DL.FPchsRtnOutQty ,0) as FpchsOrdBalanceQty    
    
,vd.FcltvdName as FvendorCodelkp ,Inv.FinvName,inv.FColorCode,inv.FgoodCode,inv.FWidth,inv.Fweight ,inv.FproductName ,inv.FNote as FInvNotelkp    
,Clt.FCltName as FcltCodelkp    
,ut.FunitName  as FMainunitCodelkp    
,M.FContractNo ,M.FCounterSign    
 From TPurchaseOrder  M    
join  TPurchaseOrdDL  DL on M.FPurchOrdCode=DL.FPurchOrdCode    
join  Tinventory     inv on DL.FinvCOde=inv.FinvCode    
  join #TinvType invtp on invtp.FinvTypeCode=inv.FinvTypeCode    
  join #TCltVD   vd   on Vd.FcltvdCode=M.FVendorCOde   
   
left join Temployee epp  on epp.FempCode=M.FPrincipalEmp    
left join Tclient   clt  on clt.FcltCode=M.FCltCode    
left join Tunit     ut   on ut.FunitCode=inv.FmainunitCode    
    
where (M.FPurchDate>=@FBeginDate    
 and   M.FPurchDate<=@FEndDate    
 and   isnull(M.FcltCode,'') like @FcltCode    
 and   isnull(M.FVendorCode,'') like @FVendorCode    
 and  isnull(inv.FinvName,'') like @FinvName    
 and  isnull(inv.FColorCode,'') like @FColorCode    
 and  isnull(inv.FGoodCode,'') like @FGoodCode    
 and  isnull(M.FContractNo ,'') like @FContractNo   
 and  @FUnClosed=0   
)  
 or   
( isnull( dl.FisCls ,0)=0 and @FUnClosed=1 )    
    
order by M.FCreateTime desc




--drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 
--drop table #TPriceType  
-- drop table #TWareHouse  	
--drop table #TinOutType 
drop table #TinvType 

go


drop proc Pr_GetSalesOrderItems   
go

CREATE proc Pr_GetSalesOrderItems          
@FbeginDate smalldatetime          
, @FendDate  smalldatetime          
, @Fcltcode varchar(30)          
, @FinvName varchar(30)          
, @FGoodCode varchar(30)          
, @FProductName varchar(30)          
, @FSlTypeCode varchar(30)          
, @FinvTypeCode varchar(30)          
, @FUnClosed bit 
,@FempCode varchar(30)         
          
as          
 

--create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
--insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
create table #TinvType   ( FinvTypeCode		varchar(30) , FinvTypeName		varchar(30)  ,FDEL bit )
	insert into  #TinvType		exec Pr_GetAuthorizedUserData @FEmpCode ,'SalesBasicInfo','TInvType'


 select clt.FcltCode as FCltVdCode,clt.FCltName as FCltVdName,clt.FCltTypeCode , 1 as Fisclt   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
 
 
 select          
M.FSlOrdCode,  M.FSignEmp, sgnEmp.FEmpName as FSignEmpLkp , M.FSignDate, M.FContractNo ,         
M.FCltCode, clt.FcltVdName as Fcltname , sltp.FSLTypeName, M.FSLTypeCode,  M.FNote as FMNote ,          
case when M.FisChk =1 then '¡Ì' else '' end as FIsChk ,          
case when DL.FisCls =1   then '¡Á' else '' end as FIsCls ,          
inv.FinvName, inv.FGoodCode, inv.FProductName,inv.Fnote as FInvNote, ut.FunitName,invtp.FinvTypeName,          
Dl.FOrdQty -DL.FQtyCompletion  as FPdcRestQty, Dl.FOrdQty as FMainQty ,   DL.FOrdQty - isnull (DL.FOutQty ,0) + isnull ( DL.FSLRtnInQty ,0) as FSLOrdBalanceQty,          
DL.F_ID,DL.FInvCode,DL.FDeliveryDate,DL.FOrdPrice,DL.FNote,DL.FInvName,DL.FGoodCode,DL.FProductName,DL.FPrdcPLCode,DL.FMainUnitCode,          
DL.FOrdQty,DL.FcolorCode,DL.FOutQty,DL.FQtyCompletion,DL.FSLRtnInQty,DL.FOrdPrice*DL.FOrdQty as FAmt          
          
     From TSaleOrder   M          
     join TSaleOrderDL DL on M.FSLOrdCode=DL.FSLOrdCode          
left     join #TCltVD      clt on clt.FcltVdcode=m.Fcltcode          
left     join Tinventory   inv    on inv.FInvCode =DL.FInvCode          
left join Temployee    sgnEmp on sgnEmp.Fempcode=M.FSignEmp          
left join TSaleType    sltp   on sltp.FSlTypeCode=M.FSLTypeCode          
left join Tunit        ut     on ut.FunitCode =inv.FMainUnitCode          
     join #TinvType   invtp on inv.FinvTypeCode=invtp.FinvTypeCode          
where          
 ( FSignDate>=@FbeginDate and FSignDate<=@FendDate          
 and   isnull(m.Fcltcode ,'')  like @Fcltcode          
 and   isnull(inv.FinvName,'')    like @FinvName          
 and   isnull(inv.FGoodCode ,'') like @FGoodCode          
 and   isnull( inv.FProductName ,'') like @FProductName          
 and   isnull(m.FSLTypeCode ,'') like @FSLTypeCode          
 and   isnull(inv.FinvTypeCode,'') like @FinvTypeCode    
 and   @FUnClosed=0          
)     
or     
( isnull( dl.FisCls ,0)=0 and @FUnClosed=1 ) 






--drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 
--drop table #TPriceType  
-- drop table #TWareHouse  	
--drop table #TinOutType 
drop table #TinvType 


go


  drop  proc Pr_WhInItems  

go
CREATE proc Pr_WhInItems      
  @FCltVdCode  varchar(20)      
, @FWhCode  varchar(20)      
, @FWkShopCode  varchar(20)      
, @FInOutTypeCode  varchar(20)      
, @FInvName  varchar(20)      
, @FInvTypeCode  varchar(20)      
, @FColorCode  varchar(20)      
, @FGoodCode  varchar(20)      
, @FBeginDate  smalldatetime      
, @FEndDate  smalldatetime      
, @FIncludeUnChk  bit      
, @FEmpCode     varchar(20)      
as      
     
     
--create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
-- insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
-- create table #TPriceType ( FPriceTypeCode	varchar(30) , FPriceTypeName	varchar(30)  ,FDEL bit )
--	insert into	 #TPriceType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TPriceType'
create table #TinvType   ( FinvTypeCode		varchar(30) , FinvTypeName		varchar(30)  ,FDEL bit )
	insert into  #TinvType		exec Pr_GetAuthorizedUserData @FEmpCode ,'SalesBasicInfo','TInvType'
create table #TWareHouse ( FWhCode			varchar(30) , FWhName			varchar(30)  ,FDEL bit )	
 	insert into  #TWareHouse	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TWareHouse'
create table #TinOutType ( FinOutTypeCode	varchar(30) , FinOutTypeName	varchar(30)  ,FDEL bit )
	insert into  #TinOutType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TInOutType '

select clt.FCltCode as fCltVdCode , clt.FcltName as FcltVdName   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
union all 
select vd.FVendorcode	, vd.FVendorName as FcltVdName
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode

 
declare @MonthSpan int       
select @MonthSpan = FParamValue  From TParamsAndValues where  FParamCode='010104'      
if exists( select * from sys_user where EmpID=replace(@FEmpCode,'%','') and isnull( isAdmin, 0) =0 )      
if dateadd(m,-@MonthSpan ,getdate())>@FBeginDate      
set @FBeginDate=dateadd(m,-@MonthSpan ,getdate())      
      
      
select DL.F_ID,M.FCreateEmp,M.FCreateTime,M.FPrdcPLCode,M.FWhCode,M.FInDate,  inv.FWidth,inv.FWeight,      
M.FVendorCode,M.FWhinCode,convert(decimal(19,8),DL.FPrice) as FPrice,DL.FPrice*DL.FmainQty as FAmt,M.FWkShopCode , M.FNote as FMNote       
,DL.FpurchOrdCode   ,case when M.FIschk=1 then '¡Ì'else '' end as FIsChk,M.FInOutTypeCode,      
DL.FInvCode,DL.FInvName,DL.FGoodCode,DL.FProductName,DL.FColorCode,DL.FMainQty,DL.FChgRate*DL.FMainQty as FAssistQty,dl.FInvAlias, DL.FNote ,      
itp.FInOutTypeName ,CltVd.FCltVdName ,Cep.FempName as FCreateEmpLkp,wh.FWhname,wsp.FWkShopName,mut.FUnitName as FMainUnitCodeLkp,dl.FPackageQty,invtp.FInvTypeName  ,iep.FEmpName as FInEmpLkp       
,case when M.FFNischk=1 then '¡Ì'else '' end as FFNIsChk         
,inv.Fnote as FInvNoteLkp ,inv.FBrand as FBrandlkp     
into #tmp      
 From TWhin  M      
 join TWhinDL DL on M.FwhinCode=DL.FwhinCode  
      join Tinventory	 inv	on inv.FinvCode=DL.FinvCode       
		join #TinvType	 invtp	on invtp.FinvTypeCode=inv.FinvTypeCode       
		join #TinOutType itp	on itp.FinOutTypeCode=M.FinOutTypeCode       
        join #TCltVD	 CltVd  on CltVd.FcltvdCode=M.FVendorCode  
        join #TWareHouse wh		on wh.FwhCode=M.FwhCode     
left join Temployee      Cep	on Cep.FempCode=M.FCreateEmp      
left join Temployee      iep	on iep.FempCode=M.FINEmp      
left join TWorkShop  wsp on wsp.FWkShopCode=M.FWkShopCode      
left    join Tunit      mut on mut.Funitcode=inv.FMainUnitCode      
      
where isnull(M.FVendorCode,'') like @FCltVdCode      
and   isnull(wh.FwhCode,'')   like @FWhCode      
and   isnull(M.FWkShopCode,'') like @FWkShopCode      
and   isnull(M.FinOutTypeCode,'') like @FInOutTypeCode      
and   isnull(DL.FinvName,'')    like @FInvName      
and   isnull(inv.FInvTypeCode ,'') like @FInvTypeCode      
and   isnull(inv.FcolorCode ,'') like @FColorCode      
and   isnull(inv.FgoodCode ,'') like @FGoodCode      
order by M.FCreateTime  desc , M.FWhCode        
      
      
select * from #tmp      
where   FinDate>=@FBeginDate and    FinDate<=@FEndDate        
--union all      
--select * from #tmp where   FinDate<@FBeginDate  and @FIncludeUnChk=1 and  FFNischk =''       
      
drop table #tmp

------------

--drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 
--drop table #TPriceType  
drop table #TWareHouse  	
drop table #TinOutType 
drop table #TinvType 



go

drop proc Pr_WhOutItems

go
CREATE proc Pr_WhOutItems      
   @FCltVdCode   varchar(20)      
,  @FWhCode   varchar(20)      
,  @Fwkshopcode   varchar(20)      
,  @FInOutTypeCode   varchar(20)      
,  @FInvName   varchar(20)      
,  @FSLOrdCode   varchar(20)      
,  @FProduceOrdCode   varchar(20)      
,  @FInvTypeCode   varchar(20)      
,  @FColorCode   varchar(20)      
,  @FGoodCode    varchar(20)      
,  @FBeginDate   smalldatetime      
,  @FEndDate     smalldatetime      
,  @FIncludeUnChk  bit      
,  @FEmpCode     varchar(20)      
      
as      

     
--create table #TGLC		 ( FGLCCode			varchar(30) , FGLCName			varchar(30)  ,FDEL bit )	
-- insert into  #TGLC			exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TGLC'
create table #TAuCltVD	 ( FCltVdCode		varchar(30) , FCltVdName		varchar(30)  ,FDEL bit )	
	insert into	 #TAuCltVD		exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','VCltVd'
create table #TCltType	 ( FCltTypeCode		varchar(30) , FCltTypeName		varchar(30)  ,FDEL bit )	
	insert into	 #TCltType	    exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TCltType'	
create table #TVendorType( FVendorTypeCode	varchar(30) , FVendorTypeName	varchar(30)  ,FDEL bit )	
	insert into	 #TVendorType   exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TVendorType'
-- create table #TPriceType ( FPriceTypeCode	varchar(30) , FPriceTypeName	varchar(30)  ,FDEL bit )
--	insert into	 #TPriceType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TPriceType'
create table #TinvType   ( FinvTypeCode		varchar(30) , FinvTypeName		varchar(30)  ,FDEL bit )
	insert into  #TinvType		exec Pr_GetAuthorizedUserData @FEmpCode ,'SalesBasicInfo','TInvType'
create table #TWareHouse ( FWhCode			varchar(30) , FWhName			varchar(30)  ,FDEL bit )	
 	insert into  #TWareHouse	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TWareHouse'
create table #TinOutType ( FinOutTypeCode	varchar(30) , FinOutTypeName	varchar(30)  ,FDEL bit )
	insert into  #TinOutType	exec Pr_GetAuthorizedUserData @FEmpCode,'SalesBasicInfo','TInOutType '

select clt.FCltCode as fCltVdCode , clt.FcltName as FcltVdName   into #TCltVD 
from TClient clt join   #TAuCltVD cltVD on clt.FCltCode = cltVd.FCltVdCode join #TCltType  cltTp on cltTp.FcltTypeCode =  clt. FcltTypeCode
union all 
select vd.FVendorcode	, vd.FVendorName as FcltVdName
from TVendor  vd join   #TAuCltVD cltVD on vd.FVendorcode = cltVd.FCltVdCode join #TVendorType  vdTp on vdTp.FVendorTypeCode =  vd. FVendorTypeCode

      
declare @MonthSpan int       
select @MonthSpan = FParamValue  From TParamsAndValues where  FParamCode='010105'      
if exists( select * from sys_user where EmpID=replace(@FEmpCode,'%','') and isnull( isAdmin, 0) =0 )      
if dateadd(m,-@MonthSpan ,getdate())>@FBeginDate      
set @FBeginDate=dateadd(m,-@MonthSpan ,getdate())      
      
      
      
select         
DL.FinvCode,DL.FinvName,DL.FGoodCode,DL.FproductName,DL.FColorCode,DL.Fprice,      
DL.Fnote,DL.FWhCode,DL.FOutQty,DL.FPackageQty,DL.FQtyitem,DL.FinOutTypeCode,DL.Fdate,      
DL.FInvAlias,DL.FReconciled,DL.FReconcileEmp,DL.FReconcileTime,DL.FSLOrdCode,DL.FProduceOrdCode,      
DL.FPdtInvCode,DL.FPurchOrdCode,DL.Fprice*FOutQty as FAmt, inv.FWidth,inv.FWeight,  M.FwhoutCode,    
 itp.FinOutTypeName , Eot.FempName as FOutEmpLkp ,wh.FWhName ,wsp.FWkShopName,      
 mut.FunitName as FmainunitCodeLkp,Aut.FunitName as FAssistunitCodeLkp,inv.FchgRate,inv.Fchgrate*FoutQty as FassistQty ,invtp.FInvTypeName      
,case when M.Fischk=1 then '¡Ì'else '' end as FIsChk , inv.FgoodCode as FGoodCodelkp ,CltVd.FcltvdName as FCltVdCodeLkp ,M.FOutDate      
,case when M.FFNischk=1 then '¡Ì'else '' end as FFNIsChk ,M.FNote as FMNote      
,ECt.FempName as FcreateEmplkp      
,inv.Fnote as FInvNoteLkp  ,inv.FBrand as FBrandLkp     
into #Tmp      
From TWhOutDL DL      
 join    TWhOutM  M   on M.FwhoutCode=DL.FwhoutCode      
left  join TinOutType itp on itp.FinOutTypeCode=DL.FinOutTypeCode      
left join Temployee  Eot on Eot.FempCode=m.FoutEmp      
left join Temployee  ECt on ECt.FempCode=m.FCreateEmp      
left join TWareHouse wh  on wh.FwhCode=DL.FwhCode      
left join TWorkShop  wsp on wsp.FWkShopCode=DL.FWkShopCode      
left join Tinventory inv on inv.FinvCode=DL.FinvCode      
left    join Tunit      Mut on Mut.Funitcode=Inv.FmainunitCode      
left    join Tunit      Aut on Aut.Funitcode=Inv.FAssistunitCode      
left    join TinvType   invtp on invtp.FinvTypeCode=inv.FinvTypeCode      
left    join (select Fcltcode  as FcltvdCode ,FcltName as FcltvdName  from Tclient union select FvendorCode,FvendorName from Tvendor    ) as CltVd          
        on CltVd.FcltvdCode=M.FcltvdCode      
where isnull(M.FCltVdCode ,'')         like @FCltVdCode      
and   isnull(wh.FwhCode,'')   like @FWhCode      
and   isnull(DL.FWkShopCode,'') like @FWkShopCode      
and   isnull(DL.FinOutTypeCode,'')  like @FInOutTypeCode      
and   isnull(DL.FinvName,'')        like @FInvName      
and   isnull(dl.FSLOrdCode ,'')     like @FSLOrdCode      
and   isnull(dl.FProduceOrdCode ,'')like @FProduceOrdCode       
and   isnull(inv.FInvTypeCode ,'') like @FInvTypeCode      
and   isnull(inv.FcolorCode ,'') like @FColorCode      
and   isnull(inv.FgoodCode ,'') like @FGoodCode      
order by M.FCreateTime desc ,DL.FDate desc       
      
--select * from #tmp      
      
select * from #tmp      
where   FOutDate>=@FBeginDate and    FOutDate<=@FEndDate        
--union all      
--select * from #tmp where   FOutDate<@FBeginDate  and @FIncludeUnChk=1 and  FFNischk =''       
      
      
drop table #tmp
--------
--drop table #TGLC	 	
drop table #TCltVD	
drop table #TAuCltVD 
drop table #TCltType	 	
drop table #TVendorType 
--drop table #TPriceType  
drop table #TWareHouse  	
drop table #TinOutType 
drop table #TinvType       