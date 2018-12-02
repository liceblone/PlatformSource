drop proc Pr_CltVdPayReceiveItems
go 
CREATE proc Pr_CltVdPayReceiveItems    
@FbeginDate smalldatetime,                                                                      
@FendDate   smalldatetime,                                                                      
@FCltTypeCode varchar(20),                                                                      
@FCltVdCode   varchar(20),    
@FOnyUnChk       bit   ,
@FisClt bit 
as    
   select     
   PR.F_ID,  PR.FCreateTime,PR.FGlCCode,PR.FDate,PR.FClerkEmp    
   ,PR.FNote,PR.FCltVdCode,PR.FisClt,PR.FBillCode    
   ,PR.Famt,PR.FChkTime,PR.FRpCode,PR.FQty,PR.FReconcileTime --,PR.FReconcileEmp    
   , case when PR.FReconciled=1 then '¡Ì'else '' end as FReconciled     
   , case when PR.Fischk=1 then '¡Ì'else '' end as FIsChk     
   ,CltVd.FCltVdName      
   ,GLC.FGLCName    
   ,EChk.FEmpName as  FChkEmplkp    
   ,ECt.FEmpName as  FCreateEmplkp    
   ,ClerkEmp.FEmpName as  FClerkEmplkp    
   into #tmp    
   From TPayReceive   PR    
   left join (    
    select FcltCode as FCltVdCode,FCltName as FCltVdName,FCltTypeCode from Tclient  where FCltTypeCode like @FCltTypeCode    
    union all    
    select FvendorCode ,FvendorName,FvendorTypeCode                   from Tvendor  where FvendorTypeCode like @FCltTypeCode    
   ) CltVd on CltVd.FCltVdCode=PR.FCltVdCode    
   left join   TGLC   GLC on GLC.FGLCCode=PR.FGLCCode    
   left join Temployee  EChk on EChk.FempCode=PR.FChkEmp        
   left join Temployee  ECt on ECt.FempCode=PR.FCreateEmp     
   left join Temployee  ClerkEmp on ClerkEmp.FempCode=PR.FClerkEmp    
       
       
      
select * from #tmp        
where (@FOnyUnChk=1  and Fischk ='')     
or    (@FOnyUnChk=0   and Fdate>=@FbeginDate and FDate<@FendDate+1)   
    
drop table #tmp



