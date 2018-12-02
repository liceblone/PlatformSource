drop proc Pr_ExpensesApportionDLList
go 
CREATE proc Pr_ExpensesApportionDLList      
@FBeginDate smalldatetime,      
@FEndDate   smalldatetime,      
@FCltVdCode varchar(30),      
@FRpCode varchar(30),
@FGlCCode  varchar(30),
@FWHDLFID varchar(50),
@FinvCode varchar(30),
@FinvName varchar(30),
@FColorCode varchar(30),
@FGoodCode varchar(30)
      
as      
    -- select * from TPaymentApportion      
select glc.FGLCName, APTp.FApportionTypeName  ,PayTp.FPayTypeName   ,Vd.FCltVdName ,PayAp.FPaymentApportionCode        
,EChk.FEmpName as  FChkEmplkp ,ECt.FEmpName as  FCreateEmplkp ,ClerkEmp.FEmpName as  FClerkEmplkp        
,Pr.FCreateEmp,Pr.FCreateTime,Pr.FGlCCode,Pr.FPayTypeCode,Pr.FDate as FPrDate,Pr.FClerkEmp,Pr.FNote,Pr.FCltVdCode,Pr.Famt as FPrAmt	 
,Pr.FChkEmp,Pr.FChkTime,Pr.FRpCode 
,PayApDL.FWhDLFID,PayApDL.FBillCode,PayApDL.FinvCode,PayApDL.FInvName,PayApDL.FColorCode,PayApDL.FGoodCode,PayApDL.FMainQty
,PayApDL.Fprice,PayApDL.FAmt,PayApDL.FApportionAmt,PayApDL.FNote as FPayApDLNote,PayApDL.FCltVdCode,PayApDL.FDate,PayApDL.FWhCode
,case when PayAp.FisChk=1 then '¡Ì' else '' end FisChk      
,case when PayAp.FRpCode is not null then '¡Ì' else '' end FApportioned      
,'BillEx' as BillType    ,'FBillCode' as ParameterFLDs ,1055 as FormID  ,'{80ABD574-3465-4E04-9389-4FF9C28EFF83}' as FWindowsFID  
    
from TPayReceive   Pr      
join TExpensesApportion expAp on Pr.FGLCCode=ExpAp.FGLCCode      
join TGLC   GLc on GLC.FGLCCode =pr.FGLCCode      
join TApportionType APTp on APTp.FApportionTypeCode =  expAp.FApportionTypeCode  
join TPaymentApportion   PayAp on Pr.FRpCode=PayAp.FRpCode  
join TPaymentApportionDL PayApDL on PayAp.FPaymentApportionCode =PayApDL.FPaymentApportionCode  
-- select * from TPaymentApportiondl
left join TPayType    PayTp  on PayTp.FPayTypeCode =   pr.FPayTypeCode      
join (      
      select FCltCode as FCltVdCode ,FCltName as FCltVdName from TClient      
      union all      
      select FVendorCode, FVendorName from TVendor      
      )as Vd on Vd.FCltVdCode =  Pr.FCltVdCode      
left join TEmployee ClerkEmp on ClerkEmp.FEmpCode = Pr.FClerkEmp      
left join Temployee  EChk on EChk.FempCode=PR.FChkEmp                  
left join Temployee  ECt on ECt.FempCode=PR.FCreateEmp      
where isnull( expAp.FDEL,0) =0  and isnull(Pr.FisChk,0)=1 and isnull(PayAp.FisChk,0)=1 --and PayAp.FRpCode is null     
and Vd.FCltVdCode   like    @FCltVdCode  
and pr.FDate >= @FBeginDate and pr.FDate <= @FEndDate   +1   
and Pr.FRpCode      like    @FRpCode  
and Pr.FGlCCode     like    @FGlCCode   
and PayApDL.FWHDLFID   like	@FWHDLFID
and PayApDL.FinvCode   like @FinvCode
and PayApDL.FinvName   like @FinvName
and PayApDL.FColorCode like @FColorCode
and PayApDL.FGoodCode  like @FGoodCode


