update TActuallyTailed  set FPrdcPLCode=B.FPrdcPLCode
from TActuallyTailed A
join TProductPlan  B on A.FSLOrdCode=B.FSLOrdCode and A.FInvCode=B.FInvCode and A.FDeliveryDate=B.FDeliveryDate


truncate table TReworkRec