drop proc Pr_CltVdARItems
go 

--exec Pr_CltVdARItems '2013-08-08 00:00:00','2013-08-08 00:00:00','%','%',0  
  
CREATE proc Pr_CltVdARItems    
@FbeginDate smalldatetime,                                                                      
@FendDate   smalldatetime,                                                                      
@FCltTypeCode varchar(20),                                                                      
@FCltVdCode   varchar(20),    
@FOnyUnChk       bit	 ,
@FisClt bit 
as    
   select     
   AR.F_ID,  AR.FCreateTime,AR.FGlCCode,AR.FDate,AR.FClerkEmp    
   ,AR.FNote,AR.FCltVdCode,AR.FisClt,AR.FBillCode,AR.FisSys,AR.FModalType    
   ,AR.FFormID,AR.Famt,AR.FChkTime,AR.FShRpCode,AR.FQty,AR.FReconcileTime --,AR.FReconcileEmp    
   ,AR.FTaxRate,AR.FInvoiceAmt,AR.FTax    
   , case when AR.FReconciled=1 then '¡Ì'else '' end as FReconciled     
   , case when AR.Fischk=1 then '¡Ì'else '' end as FIsChk     
   ,CltVd.FCltVdName      
   ,GLC.FGLCName    
   ,EChk.FEmpName as  FChkEmplkp    
   ,ECt.FEmpName as  FCreateEmplkp    
   ,ClerkEmp.FEmpName as  FClerkEmplkp    
   into #tmp    
   From TPayReceiveAble  AR    
   left join (    
    select FcltCode as FCltVdCode,FCltName as FCltVdName,FCltTypeCode from Tclient where FCltTypeCode like @FCltTypeCode    
    union all    
    select FvendorCode ,FvendorName,FvendorTypeCode                   from Tvendor where FvendorTypeCode like @FCltTypeCode    
   ) CltVd on CltVd.FCltVdCode=AR.FCltVdCode    
   left join   TGLC   GLC on GLC.FGLCCode=AR.FGLCCode    
   left join Temployee  EChk on EChk.FempCode=AR.FChkEmp        
   left join Temployee  ECt on ECt.FempCode=AR.FCreateEmp     
   left join Temployee  ClerkEmp on ClerkEmp.FempCode=AR.FClerkEmp    
       
       
      
select * from #tmp        
where (@FOnyUnChk=1  and Fischk ='' )   
or    (@FOnyUnChk=0   and Fdate>=@FbeginDate and FDate<@FendDate+1)   
    
    
drop table #tmp  
  
