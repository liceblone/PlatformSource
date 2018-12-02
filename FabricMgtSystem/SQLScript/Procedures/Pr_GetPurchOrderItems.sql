drop proc Pr_GetPurchOrderItems
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
  
as  
  
  
select M.FPurchOrdCode,M.FPurchTypeCode,M.FPurchDate,Dl.FRequestDate ,M.FcltCode,  
M.FNote as FMnote,M.FChkEmp, M.FChkTime,  M.FPrincipalEmp,epp.FempName as FPrincipalEmpLkp  
,case when M.FisChk=1 then '¡Ì' else '' end as FisChk  
,case when DL.FisCls =1 then '¡Á'  else '' end as FIsCls , DL.FPurchPrice*DL.FPurchQty  as FAmt   
  
,invtp.FinvTypename    
,DL.FInvAlias  ,DL.FinvCode,DL.FPurchPrice,DL.FPurchQty,DL.FNote,M.FvendorCode ,DL.Finqty ,DL.FPchsRtnOutQty , DL.FPurchQty - isnull ( DL.Finqty ,0) + isnull ( DL.FPchsRtnOutQty ,0) as FpchsOrdBalanceQty  
  
,vd.FvendorName as FvendorCodelkp ,Inv.FinvName,inv.FColorCode,inv.FgoodCode,inv.FWidth,inv.Fweight ,inv.FproductName ,inv.FNote as FInvNotelkp  
,Clt.FCltName as FcltCodelkp  
,ut.FunitName  as FMainunitCodelkp  
,M.FContractNo ,M.FCounterSign  
 From TPurchaseOrder  M  
join  TPurchaseOrdDL  DL on M.FPurchOrdCode=DL.FPurchOrdCode  
join  Tinventory     inv on DL.FinvCOde=inv.FinvCode  
left join TinvType invtp on invtp.FinvTypeCode=inv.FinvTypeCode  
left join Tvendor   vd   on Vd.FVendorCode=M.FVendorCOde  
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
(	isnull( dl.FisCls ,0)=0 and @FUnClosed=1 )  
  
order by M.FCreateTime desc
