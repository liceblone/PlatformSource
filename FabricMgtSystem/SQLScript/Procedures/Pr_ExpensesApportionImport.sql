drop proc Pr_ExpensesApportionImport
go 
CREATE proc Pr_ExpensesApportionImport      
@FinvName varchar(30),      
@FColorCode varchar(30),      
@FGoodCode varchar(30),      
@FBeginDate smalldatetime,    
@FEndDate smalldatetime,    
@FRpCode varchar(30),    
@FWhCode varchar(30)      
as      
      
--FCltVdCode,FDate,FWhincode,FWhDLFID,FinvCode,FinvName,FColorCode,FgoodCode,FMainQty,FPrice,FAmt       
       
      
select Vd.FCltVdCode,Vd.FCltVdName,m.FinDate as FDate, m.FinoutTypeCode, ioTp.FinoutTypeName ,dl.FWhincode ,dl.FWhincode as FbillCode      
,dl.F_ID as FWhDLFID ,dl.FinvCode,dl.FinvName,DL.FColorCode,Dl.FgoodCode   ,Wh.FWhName   ,m.FWhCode      
,dl.FMainQty,dl.FPrice, dl.FMainQty*dl.FPrice   as FAmt       
from Twhin m       
join Twhindl dl on m.FwhinCode=dl.FWhinCode      
join TPayReceive Pr on M.FVendorcode=Pr.Fcltvdcode      
join TinOutType ioTp on ioTp.FinoutTypeCode=m.FinoutTypeCode      
join Tinventory inv on inv.FinvCode=DL.FinvCode      
join (      
     select  FCltCode as FCltVdCode,FCltName as FCltVdName  from TClient      
     union       
     select FVendorCode , FVendorName from TVendor      
     )as Vd on  Vd.FCltVdCode= M.FVendorCode      
join Twarehouse  wh on wh.FWhCode=m.FWhCode         
where   -- pr.FRpCode   = @FRpCode   and        
m.FisChk=1  and isnull(FisExpenses, 0) = 0   
and   m.FInDate >=isnull( (select max(FMonth)from TInvCostAcctMonthEndClose where FisClosed =1) ,  (select  FParamValue From TParamsAndValues where FParamCode= '01050202') )  
and   inv.FinvName like @FinvName      
and   isnull(inv.FColorCode, '') like @FColorCode      
and   isnull(inv.FGoodCode, '')  like @FGoodCode 
and   m.FWhCode                  like @FWhCode     
and   m.FInDate>=@FBeginDate    
and   m.FInDate<=@FEndDate+1    
  
  
