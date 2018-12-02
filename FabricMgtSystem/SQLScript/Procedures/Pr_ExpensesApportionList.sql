drop proc Pr_ExpensesApportionList
go 
CREATE proc Pr_ExpensesApportionList    
@FBeginDate smalldatetime,    
@FEndDate   smalldatetime,    
@FCltVdCode varchar(30),    
@FOnyUnChk  bit    
    
as    
    -- select * from TPaymentApportion    
select glc.FGLCName, APTp.FApportionTypeName  ,PayTp.FPayTypeName   ,Vd.FCltVdName ,PayAp.FPaymentApportionCode      
,EChk.FEmpName as  FChkEmplkp ,ECt.FEmpName as  FCreateEmplkp ,ClerkEmp.FEmpName as  FClerkEmplkp      
,Pr.FCreateEmp,Pr.FCreateTime,Pr.FGlCCode,Pr.FPayTypeCode,Pr.FDate,Pr.FClerkEmp,Pr.FNote,Pr.FCltVdCode,Pr.Famt    
,case when PayAp.FisChk=1 then '¡Ì' else '' end FisChk    
,case when PayAp.FRpCode is not null then '¡Ì' else '' end FApportioned    
,Pr.FChkEmp,Pr.FChkTime,Pr.FRpCode    
from TPayReceive   Pr    
join TExpensesApportion expAp on Pr.FGLCCode=ExpAp.FGLCCode    
join TGLC   GLc on GLC.FGLCCode =pr.FGLCCode    
join TApportionType APTp on APTp.FApportionTypeCode =  expAp.FApportionTypeCode    
left join TPaymentApportion  PayAp on Pr.FRpCode=PayAp.FRpCode    
left join TPayType    PayTp  on PayTp.FPayTypeCode =   pr.FPayTypeCode    
join (    
      select FCltCode as FCltVdCode ,FCltName as FCltVdName from TClient    
      union all    
      select FVendorCode, FVendorName from TVendor    
      )as Vd on Vd.FCltVdCode =  Pr.FCltVdCode    
left join TEmployee ClerkEmp on ClerkEmp.FEmpCode = Pr.FClerkEmp    
left join Temployee  EChk on EChk.FempCode=PR.FChkEmp                
left join Temployee  ECt on ECt.FempCode=PR.FCreateEmp    
where isnull( expAp.FDEL,0) =0  and isnull(Pr.FisChk,0)=1 --and PayAp.FRpCode is null   
and Vd.FCltVdCode   like  @FCltVdCode
and   
(   
   (pr.FDate >= @FBeginDate and pr.FDate <= @FEndDate   +1 and @FOnyUnChk=0 )   
or   
  (@FOnyUnChk=1 and ( PayAp.FRpCode is null  or isnull(PayAp.FisChk,0)=0)  )  
)  
           
           
