drop proc Pr_MonthEndClose
go 

CREATE  proc Pr_MonthEndClose                              
@abortstr varchar(200) output,                              
@worningstr varchar(200) output,                              
@FMonth   smalldatetime ,                              
@FisClosed  bit        ,                      
@FEmpCode varchar(20)                         
as                              
begin                              
--1.set or clear isclose flag                              
--2.Update warehouse cost                        
--3.   
                     
                              
if @FisClosed =1                              
 set @FisClosed=0                              
else                              
 set @FisClosed =1                              
                              
  set @abortstr=''                              
  set @worningstr=''       
                         
declare  @FBeginMonth smalldatetime                            
select @FBeginMonth = convert(smalldatetime, FParamValue) From TParamsAndValues where FParamCode='01050202' 


if exists(select * from TMonthEndClose where fmonth=@FMonth and FisClosed= @FisClosed )                      
begin            
   set   @abortstr=' ����ˢ������!'                              
   return 0              
end                      
if @FisClosed=1                         
   if @FMonth>getdate()                              
   begin                              
       set @abortstr=' ���ܶ�δ���·ݽ����½�,ֻ�ܶԵ�ǰ�·ݻ���ʷ�·ݽ����½�!'                              
        return 0                              
   end              
            
if exists(select * from TMonthEndClose where fmonth<@FMonth and FisClosed=0)                              
begin                              
 set @abortstr='֮ǰ�·�δ�½ᣬ���ܶԵ�ǰ�·ݽ����½�!'   +char (10)+ (select top 1 convert(varchar(7),fMonth, 121) from TMonthEndClose where fmonth< @FMonth and FisClosed=0)+'δ�½�'                          
        return 0                              
end                              
                      
if @FisClosed=0                              
if exists( select * from TMonthEndClose where fmonth>@FMonth and FisClosed=1)                              
begin                              
 set @abortstr='������з��½ᣬ��������δ�����Ѿ��½���·ݿ�ʼ!'                              
        return 0                              
end                              
                    
                     
if exists( select *From TParamsAndValues where FParamCode='01050201'  and FParamValue=1)                    
if  @FisClosed=1                  
begin             -- select * from TInvCostAccounting                  
   -- declare @FMonth smalldatetime   set @FMonth='2013-1-1'            
   declare @IO table (F_ID varchar(300) ,FWhCode varchar(50) , FChkTime smalldatetime ,FFnisChk bit)                 
   insert into @IO                          
   select    inDL.F_ID ,inM.FwhCode  ,inM.FChkTime,inM.FFnisChk              
   From Twhin inM                                                                       
   join Twhindl inDL   on inM.FWhinCode=inDL.FWhinCode                
   left join TWareHouse wh   on Wh.FWhCode=inM.FWhCode and wh.FNeedCostAccounting=1                        
   where inM.FisChk=1  and   dbo.Fn_MonthEqual (inM.FChkTime,@FMonth) =1               
   union all                                                                              
   select    OutDL.F_ID    , OutM.FwhCode , outM.FChkTime , outM.FFnisChk               
   from TwhoutM   OutM                                                                      
   join TwhOutdl  OutDL on OutM.FWhOutCode=OutDL.FWhOutCode                                                               
   join Tinventory inv on inv.FinvCode=OutDL.FinvCode               
   left join TWareHouse wh   on Wh.FWhCode=OutM.FWhCode and wh.FNeedCostAccounting=1                                                                 
   w
here OutM.FisChk=1 and   dbo.Fn_MonthEqual (OutM.FChkTime,@FMonth) =1                  
           
   if   exists ( select * from TMonthEndClose where fmonth=@FMonth and isnull(FisClosed,0)=1)          
   begin        
    if exists ( select * from @IO io left join  TInvCostAccounting Invcost on Invcost.F_ID= io.F_ID where dbo.Fn_MonthEqual (io.FChkTime,@FMonth) =1   and (Invcost.F_ID is null or isnull( FisAccounted,0)=0 )  )                
    begin   -- select 1            
   set @abortstr='�г�����¼δ����'                
   return 0       
    end                
    if exists(  select * from @IO where isnull(FFnisChk,0)=0 )              
    begin              
   set @abortstr='�г�����¼����δ���'         
   return 0                   
    end              
   end        
   if exists(select 1 from  TMtrLStorageHis where Fmonth=@Fmonth and isnull( Fischk ,0)=0 ) and @FBeginMonth<> @Fmonth             
   begin                
     set @abortstr='������˴����ĩ����'                
     return 0                
   end                 
 /*              
     --ȷ��ÿ���ֿ��Ѻ���              
     if not exists (select distinct stg.FMonth, stg.FWhCode from  TMtrLStorageHis stg                     
                  where year(fMonth) =year( @FMonth)  and isnull( FisChk,0)=1 )                    
  --  if  (select distinct FMonth from  TMtrLStorageHis stg )<=@FMonth                  
    begin                  
    set @abortstr=' ���ȶ�['+ convert(varchar(4),year(@FMonth)) +'��'+convert(varchar(2),month(@FMonth)) +'��]������к��㣡'                              
    return 0                              
    end                    
                
    select * from TMtrLStorageHis                  
    select * from TInvCostAccounting               
                    
  */                   
end                    
                               
                      
     begin tran                 
        if  @FisClosed=1                  
        begin                   
      /*    
      --�����޳���⣬ȡ�����½�����              
       insert into TMtrLStorageHis               
       (FCreateEmp,FCreateTime ,FMonth,FStorage,FStoragePkgQty,FInvCode,FWhCode, FAvgPrice,  FIsChk,FChkTime,FChkEmp,FAmt)              
       select               
       FCreateEmp,getdate() ,@Fmonth,FStorage,FStoragePkgQty,FInvCode,FWhCode, FAvgPrice,  FIsChk,getdate() ,FChkEmp,FAmt              
       from  TMtrLStorageHis where Fmonth=dateadd(m,-1,@Fmonth) and      
         not exists(select * from TInvCostAccounting io       
                    where  io.Fwhcode=TMtrLStorageHis.FwhCode       
     and io.FInvCode=TMtrLStorageHis.FInvCode       
     and Fmonth=@Fmonth  )         
                        
                        
        --�г����ȡ������ϸ              
             
        insert into TMtrLStorageHis                
        (FMonth,FInvCode,FWhCode,FAvgPrice,FStorage,FStoragePkgQty,FAmt,FIsChk,FChkTime,FChkEmp)                
        select                 
        FMonth,FInvCode,FWhCode, FBalanceAmt/FBalanceQty ,FBalanceQty,FBalancePkgQty, FBalanceAmt,FIsAccounted, getdate() ,FAccountEmp                
        from TInvCostAccounting where FisLastRow=1 and FMonth=@FMonth   and FBalanceQty>0   
         */             
         update TMtrLStorageHis set Fischk=1,FchkTime=Getdate(),FChkEmp=@FEmpCode where FMonth=@FMonth   
   end              
  else              
  begin    --	 select convert(smalldatetime,FParamValue ),convert(varchar(20),getdate(),121) From TParamsAndValues where FParamCode='01050202'   
      if @FBeginMonth=@FMonth     
         update TMtrLStorageHis set FisChk=1 where FMonth=@FBeginMonth 
      else 
	     delete TMtrLStorageHis where FMonth>=@FMonth      
      delete TInvCostAccounting where FMonth>=@FMonth     
                  
  end              
                   
                   
---1.set or clear @isClosed                            
       update     
 TMonthEndClose                               
       set         FisClosed       =case when @FisClosed=1 then      1        else 0  end ,                                 
                   FClsEmp  =case when @FisClosed=1 then @FEmpCode    else '' end ,                              
                   FClsTime     =case when @FisClosed=1 then getdate()     else null end                               
       where year( @FMonth)=year(fMonth) and Month(@FMonth)=month(fMonth)                                
                        
/*                      
           if    exists( select * from TMonthEndClose where year( @FMonth)=year(fMonth) and Month(@FMonth)=month(fMonth) and FisClosed=1 )                      
                   and ( select count(*) from TMonthEndClose  where  FisClosed=1 )=1                      
           begin                      
             insert into   TInvCostAccounting                      
             (FInvCode,FOriPrice,FQty      ,FDate,FWhCode,FMonth , FIsChk,FChkTime,FChkEmp,F_ID  )                      
             select                        
             M.FinvCode,  M.FAvgPrice,M.FStorage,dateadd(month,-1,@FBeginMonth )    ,  M.FWhCode  , dateadd(month,-1,@FBeginMonth )  ,1,getdate(), @FEmpCode, newid()                      
             from TMtrLStorage M where FWhCode like @FWhCode  and M.FStorage<>0                      
           end                        
*/              
     commit tran                            
if @@error<>0                            
begin                            
rollback                            
    set @abortstr=' �½���� ��'                              
        return 0                              
end                             
                            
return 1                              
                 
end 
