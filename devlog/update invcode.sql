  
 

select stinv.* 
from stUserData.dbo.TInventory stInv
join  salesUserData.dbo.TInventory slInv on stinv.FInvCode =slinv.FInvCode
  order by stinv.FInvCode

 select FnewInvCode, * from stUserData.dbo.TInventory where Fnewinvcode is not null  ;

---
alter table stUserData.dbo.TInventory add FNewInvCode varchar(30) ;

update stUserData.dbo.TInventory
set FNewInvCode=slinv.FInvCode 
from stUserData.dbo.TInventory stInv
join  salesUserData.dbo.TInventory slInv on stinv.FinvName=slinv.FinvName
 and stinv.FcolorCode =slinv.FColorCode  and stinv.FGoodCode =slinv.FGoodCode
  
 ---  update stUserData.dbo.TInventory  set FnewInvCode =null ; 
 
 declare @i int 
 set @i=3788
 update stUserData.dbo.TInventory 
 set FnewInvCode ='Inv0000'+CONVERT(varchar(30),@i) ,@i=@i+1 where Fnewinvcode is null     ;
 
 select FnewInvCode, * from stUserData.dbo.TInventory where right ( Fnewinvcode,4)>'3787'  ;

select name+',',* from syscolumns where OBJECT_NAME(id)='Tinventory' ;

select * into Tinventory20120306 from SalesUserData.dbo.Tinventory

select * from Tinventory
--- 5371
insert into SalesUserData.dbo.Tinventory
(F_ID,FPhoneticize,FInvCode,FInvName,FGoodCode,FBrand,FProductName,FColorCode,FNeedBom,FImage,
FNeedPreProcess,FBeSaled,FBeOutSource,FMainUnitCode,FAssistUnitCode,FGeneralMtrl,FSafetyStock,
FDEL,FInvTypeCode,FNote,FChgRate,FCreateEmp,FcreateTime,FLstEditEmp,FLstEditTime,FisMtrL,
FcltCode,FWeight,FWidth,FSalePrice,FMinPackingUnit)    --- FNewInvCode

select 
F_ID,FPhoneticize,FNewInvCode ,FInvName,FGoodCode,FBrand,FProductName,FColorCode,FNeedBom,FImage,
FNeedPreProcess,FBeSaled,FBeOutSource,FMainUnitCode,FAssistUnitCode,FGeneralMtrl,FSafetyStock,
FDEL,FInvTypeCode,FNote,FChgRate,FCreateEmp,FcreateTime,FLstEditEmp,FLstEditTime,FisMtrL,
FcltCode,FWeight,FWidth,FSalePrice,FMinPackingUnit
from  stUserData.dbo.TInventory where right ( Fnewinvcode,4)>'3787'  ;

-- 2163
select stinv.* 
from stUserData.dbo.TInventoryOri stInv
join salesUserData.dbo.TInventory slInv on stinv.FnewInvCode =slinv.FInvCode

create view TInventory
as
select 
F_ID,FPhoneticize, FinvCode  ,FInvName,FGoodCode,FBrand,FProductName,FColorCode,FNeedBom,FImage,
FNeedPreProcess,FBeSaled,FBeOutSource,FMainUnitCode,FAssistUnitCode,FGeneralMtrl,FSafetyStock,
FDEL,FInvTypeCode,FNote,FChgRate,FCreateEmp,FcreateTime,FLstEditEmp,FLstEditTime,FisMtrL,
FcltCode,FWeight,FWidth,FSalePrice,FMinPackingUnit
from  salesUserData.dbo.TInventory  ;


go
--  update tables


  
  select 'update '+object_name(col.id)+' set '+col.name+'=stinv.FNewInvCode from '+
  +object_name(col.id)+' D join   stUserData.dbo.TInventoryOri stinv on D.'+col.name+'=stinv.FinvCode ;'
  ,object_name(col.id) ,* 
from syscolumns col
join sysobjects tbl on object_name(col.id) =tbl.name
where tbl.xtype='u' and upper(col.Name) like '%INVCODE%'
order by object_name(col.id)

 go
 
 update TBOM set FinvCode=stinv.FNewInvCode from TBOM D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TBOMDL set FInvCode=stinv.FNewInvCode from TBOMDL D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TBOMDL set FChdinvCode=stinv.FNewInvCode from TBOMDL D join   stUserData.dbo.TInventoryOri stinv on D.FChdinvCode=stinv.FinvCode ;
update TCltMtrLPrice set FinvCode=stinv.FNewInvCode from TCltMtrLPrice D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TInternalSaleDL set FinvCode=stinv.FNewInvCode from TInternalSaleDL D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TInvAvgPriceHistory set FInvCode=stinv.FNewInvCode from TInvAvgPriceHistory D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TInvCostAccounting set FInvCode=stinv.FNewInvCode from TInvCostAccounting D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update Tinventory20120306 set FInvCode=stinv.FNewInvCode from Tinventory20120306 D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TMtrLStorage set FinvCode=stinv.FNewInvCode from TMtrLStorage D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TMtrLStorageHis set FInvCode=stinv.FNewInvCode from TMtrLStorageHis D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TMtrLStorageHis20130101 set FInvCode=stinv.FNewInvCode from TMtrLStorageHis20130101 D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TPdtWhinDL set FinvCode=stinv.FNewInvCode from TPdtWhinDL D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TPdtWhOutDL set FinvCode=stinv.FNewInvCode from TPdtWhOutDL D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TProduceOrdDL set FInvCode=stinv.FNewInvCode from TProduceOrdDL D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TPurchaseAppDL set FInvcode=stinv.FNewInvCode from TPurchaseAppDL D join   stUserData.dbo.TInventoryOri stinv on D.FInvcode=stinv.FinvCode ;
update TPurchaseOrdDL set FinvCode=stinv.FNewInvCode from TPurchaseOrdDL D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TSaleOrderDL set FInvCode=stinv.FNewInvCode from TSaleOrderDL D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TSplBOMDL set FinvCode=stinv.FNewInvCode from TSplBOMDL D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TUnitChangeRate set FInvCode=stinv.FNewInvCode from TUnitChangeRate D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TVdMtrLPrice set FinvCode=stinv.FNewInvCode from TVdMtrLPrice D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TWhinDL set FinvCode=stinv.FNewInvCode from TWhinDL D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TWhinDL set FPdtInvCode=stinv.FNewInvCode from TWhinDL D join   stUserData.dbo.TInventoryOri stinv on D.FPdtInvCode=stinv.FinvCode ;
update TWhMoveDL set FInvCode=stinv.FNewInvCode from TWhMoveDL D join   stUserData.dbo.TInventoryOri stinv on D.FInvCode=stinv.FinvCode ;
update TWhOutDL set FinvCode=stinv.FNewInvCode from TWhOutDL D join   stUserData.dbo.TInventoryOri stinv on D.FinvCode=stinv.FinvCode ;
update TWhOutDL set FPdtInvCode=stinv.FNewInvCode from TWhOutDL D join   stUserData.dbo.TInventoryOri stinv on D.FPdtInvCode=stinv.FinvCode ;
update TWkProc set FMInvCode=stinv.FNewInvCode from TWkProc D join   stUserData.dbo.TInventoryOri stinv on D.FMInvCode=stinv.FinvCode ;



select FnewInvCode ,* from TInventoryOri ;

select