select ' alter table  '+name+'      add FSYSCurUserDBName varchar(60) ;' From sysobjects where xtype='u' 

select ' update '+name+'   set  FSYSCurUserDBName=''BusiSuitUserData'' ;' From sysobjects where xtype='u' 
 
 