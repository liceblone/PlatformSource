drop proc Pr_SLInvoiceItems
go 
create proc Pr_SLInvoiceItems          
  @FVendorCode  varchar(20)          
, @FInvName  varchar(20)          
, @FInvTypeCode  varchar(20)          
, @FColorCode  varchar(20)          
, @FGoodCode  varchar(20)          
, @FBeginDate  smalldatetime          
, @FEndDate  smalldatetime          
, @FIncludeUnChk  bit          
, @FEmpCode     varchar(20)          
, @FInvoiceNO   varchar(20)  
, @FinvoiceTypeCode varchar(20)        
as          
          
declare @MonthSpan int           
        
if exists( select * from sys_user where EmpID=replace(@FEmpCode,'%','') and isnull( isAdmin, 0) =0 )          
if dateadd(m,-@MonthSpan ,getdate())>@FBeginDate          
set @FBeginDate=dateadd(m,-@MonthSpan ,getdate())          
          
          
select DL.F_ID,M.FCreateEmp,M.FCreateTime,M.FInvoiceDate,        
M.FCltVdCode,M.FSysInvoiceCode,DL.FPrice,DL.FPrice*DL.FQty as FAmt, M.FMNote    ,M.FInvoiceNO     
,M.FTaxRate,M.FTax ,M.FNonTaxAmt    
 ,case when M.FIschk=1 then '¡Ì'else '' end as FIsChk,        
         
DL.FInvCode,DL.FInvName,DL.FGoodCode,DL.FColorCode,DL.FQty, DL.FNote    
-- convert(decimal(19,2),   
--, DL.FPrice*DL.FQty (1- 1/(1+isnull(m.FTaxRate,0)/100) )  as FTaxDL   
,DL.FPrice* DL.FQty *(1- 1/(1+isnull(m.FTaxRate,0)/100)) as FTaxDL   
          
,CltVd.FCltVdName ,Cep.FempName as FCreateEmpLkp, iep.FEmpName as FInvoiceEmpLkp         
,invtp.FInvTypeName            
,inv.Fnote as FInvNoteLkp  ,  inv.FWidth,inv.FWeight  ,CltVd.FisClt 
,ivocTp.FInvoiceTypeName as FInvoiceTypeCodelkp     
into #tmp          
 From TInvoicedM  M          
 join TInvoicedDL DL on M.FSysInvoiceCode=DL.FSysInvoiceCode          
left    join (select Fcltcode  as FcltvdCode ,FcltName as FcltvdName ,1 as FisClt from Tclient union select FvendorCode,FvendorName ,0 as FisClt from Tvendor    ) as CltVd              
        on CltVd.FcltvdCode=M.FcltvdCode          
left join Temployee  Cep on Cep.FempCode=M.FCreateEmp          
left join Temployee  iep on iep.FempCode=M.FInvoiceEmp          
left    join Tinventory inv on inv.FinvCode=DL.FinvCode           
left    join Tunit      mut on mut.Funitcode=inv.FMainUnitCode          
left    join TinvType   invtp on invtp.FinvTypeCode=inv.FinvTypeCode  
left    join TinvoiceType ivocTp on ivocTp.FInvoiceTypeCode=M.FInvoiceTypeCode         
          
where isnull(M.FcltvdCode,'') like @FVendorCode          
and   isnull(DL.FinvName,'')    like @FInvName          
and   isnull(inv.FcolorCode ,'') like @FColorCode          
and   isnull(inv.FgoodCode ,'') like @FGoodCode          
and   isnull(M.FinvoiceTypeCode ,'')   like @FinvoiceTypeCode
and   M.FInvoiceNO  like @FInvoiceNO   
     
order by M.FCreateTime  desc         
          
          
select * from #tmp          
where   FInvoiceDate>=@FBeginDate and    FInvoiceDate<=@FEndDate            
--union all          
--select * from #tmp where   FinDate<@FBeginDate  and @FIncludeUnChk=1 and  FFNischk =''           
          
drop table #tmp
