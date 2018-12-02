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
        
as        
        
select        
M.FSlOrdCode,  M.FSignEmp, sgnEmp.FEmpName as FSignEmpLkp , M.FSignDate, M.FContractNo ,       
M.FCltCode, clt.Fcltname , sltp.FSLTypeName, M.FSLTypeCode,  M.FNote as FMNote ,        
case when M.FisChk =1 then '¡Ì' else '' end as FIsChk ,        
case when DL.FisCls =1   then '¡Á' else '' end as FIsCls ,        
        
inv.FinvName, inv.FGoodCode, inv.FProductName,inv.Fnote as FInvNote, ut.FunitName,invtp.FinvTypeName,        
Dl.FOrdQty -DL.FQtyCompletion  as FPdcRestQty, Dl.FOrdQty as FMainQty ,   DL.FOrdQty - isnull (DL.FOutQty ,0) + isnull ( DL.FSLRtnInQty ,0) as FSLOrdBalanceQty,        
        
DL.F_ID,DL.FInvCode,DL.FDeliveryDate,DL.FOrdPrice,DL.FNote,DL.FInvName,DL.FGoodCode,DL.FProductName,DL.FPrdcPLCode,DL.FMainUnitCode,        
DL.FOrdQty,DL.FcolorCode,DL.FOutQty,DL.FQtyCompletion,DL.FSLRtnInQty,DL.FOrdPrice*DL.FOrdQty as FAmt        
        
     From TSaleOrder   M        
     join TSaleOrderDL DL on M.FSLOrdCode=DL.FSLOrdCode        
left     join Tclient      clt on clt.Fcltcode=m.Fcltcode        
left     join Tinventory   inv    on inv.FInvCode =DL.FInvCode        
left join Temployee    sgnEmp on sgnEmp.Fempcode=M.FSignEmp        
left join TSaleType    sltp   on sltp.FSlTypeCode=M.FSLTypeCode        
left join Tunit        ut     on ut.FunitCode =inv.FMainUnitCode        
left    join TinvType   invtp on inv.FinvTypeCode=invtp.FinvTypeCode        
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
