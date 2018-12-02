 USE master
RESTORE FILELISTONLY
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\log'
   
   go
   
   USE master
RESTORE DATABASE ERPBasicinfo
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\basic'
   WITH MOVE 'yushipub_dat' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\SysData\ERPBasicinfo.mdf', 
   MOVE 'yushipub_log' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\SysData\ERPBasicinfo_log.ldf',
STATS = 10, REPLACE
 
				 
go

   USE master
RESTORE DATABASE ERPSys
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\sys'
   WITH MOVE 'yushipub_dat' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\SysData\ERPSys.mdf', 
   MOVE 'yushipub_log' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\SysData\ERPSys_log.ldf',
STATS = 10, REPLACE

go

   USE master
RESTORE DATABASE ERPUserData
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\userdata'
   WITH MOVE 'ApparelUserData_Data' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\UserData\ERPUserData.mdf', 
   MOVE 'ApparelUserData_log' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\UserData\ERPUserData_log.ldf',
STATS = 10, REPLACE

go

   USE master
RESTORE DATABASE ERPUserDataLog 
   FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Backup\log'
   WITH MOVE 'BusiSuitUserDataLog' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\UserData\ERPUserDataLog.mdf', 
   MOVE 'BusiSuitUserDataLog_log' TO 'C:\ALL_ENV\æß±¥\ERPJb\DataBase\UserData\ERPUserDataLog_log.ldf',
STATS = 10, REPLACE


   select * from sys_branch							  where isuse=1
   
  
   update sys_branch set ApplicationName='æß±¥≥…±æ∫ÀÀ„œµÕ≥'
   update sys_database set name='’„Ω≠æß±¥≥…±æ∫ÀÀ„' , db='ERPUserData' where code=1
   update sys_database set name='Œ¬÷›æß±¥≥…±æ∫ÀÀ„' , db='ERPUserData' where code=2   
   
   
   select *From T800 
   
   update T800 set f02='ERPBasicinfo' where f01=14
   update T800 set f02='ERPSys' where f01=12
   


