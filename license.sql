Select parameter name, value
from v$option 
order by 2 desc, 1;



select * from v$license;



select banner from v$version where BANNER like '%Edition%';



select name,value,description from v$parameter where name like 'license%';





select decode(count(*), 0, 'No', 'Yes') RAC
from ( select 1 
       from v$active_instances 
       where rownum = 1 );