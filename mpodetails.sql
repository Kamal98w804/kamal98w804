
---To know informaion giving index

select * from memis_live.mpo_employee_info where upper(index_no) like upper('%M002760%')

---Particular information created with indexes created with M

select index_no,employee_name from memis_live.mpo_employee_info where upper(index_no) like upper('M%')


----Total number of indexes created with M

select count(*) from memis_live.mpo_employee_info where upper(index_no) like upper('M%')


------number of female in MPO module

select count(gender) from memis_live.mpo_employee_info where gender=2 and is_deleted=0

-----number of male in MPO module

select count(gender) from memis_live.mpo_employee_info where gender=1 and is_deleted=0

----number of employee where gender title is null

select employee_name,index_no,gender from memis_live.mpo_employee_info where gender is null

----number of teachers who have nids in database

select  count(*) from memis_live.mpo_employee_info where nid is not null

----number of teachers who have mpo_status hold

select count(*) from memis_live.MPO_EMP_SAL_HOLD_UNHOLD

----The holding status of employee

select employee_id,employee_name,dob,index_no,hold_unhold_from from memis_live.MPO_EMP_SAL_HOLD_UNHOLD,memis_live.mpo_employee_info where f_employee_id=employee_id

-----total number of enlisted mpo institute

select count(*) from memis_live.mpo_institute


-----Duplicate nid info


select nid,employee_name,index_no from memis_live.mpo_employee_info where nid in(select nid from memis_live.mpo_employee_info  group by nid having count(*)>1)


------Total number of duplicate nid

select nid,count(*) from memis_live.mpo_employee_info  group by nid having count(*)>1 


-----Search by nid


select nid,employee_name,index_no from memis_live.mpo_employee_info where nid like('4113828364280')


-----Detail Information about holding mpo of employees


select index_no,employee_name,hold_unhold_percent,sal.F_employee_id FROM  memis_live.MPO_EMP_SAL_HOLD_UNHOLD sal,memis_live.MPO_EMPLOYEE_INFO emp_info where sal.F_employee_id=emp_info.EMPLOYEE_ID

--detail informaition less than 18 years

select employee_name,dob,index_no from memis_live.mpo_employee_info where sysdate-dob<18



-----------------The employee less than 40 with paycode 4

select employee_name,dob,index_no,paycode_id from memis_live.mpo_employee_info  where sysdate-dob<40 and paycode_id=4


--The employee goes to retirement in this month


select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and em.dob between TO_DATE ('02/05/1960', 'dd/mm/yyyy') and TO_DATE('01/06/1960','dd/mm/yyyy') and em.is_deleted=0
 left join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  left join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.zila=0) 
 LEFT join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
  LEFT JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 
  

select institutes_no from memis_live.mpo_employee_info where institutes_no is not null



---------------Total number of retired employees in this month

select count(*) from memis_live.mpo_employee_info em,MEMIS_LIVE.MPO_INSTITUTE ins 
where em.f_institute_id=ins.institute_id and em.dob between TO_DATE ('02/12/1959', 'dd/mm/yyyy') and TO_DATE('01/01/1960','dd/mm/yyyy') and em.is_deleted=0

-------------To know total number of employee(active)
select count(*) from memis_live.mpo_employee_info em where is_deleted=0 and is_retired=0 and is_active=1


------------------To know total number of active index no


select employee_name,dob,index_no,paycode_id,ins.institute_id,ins_name,desig_id from memis_live.mpo_employee_info join memis_live.MPO_INSTITUTE ins 
on(mpo_employee_info.f_institute_id=ins.institute_id and mpo_employee_info.is_deleted=0) 
 

-----------------------Total no. of teachers in the mpo

select employee_name,dob,index_no,em.desig_id,is_mpo,paycode_id,desig_name from memis_live.mpo_employee_info em,memis_live.oa_designation des where em.desig_id=DES.DESIG_ID 
and em.is_deleted=0 and em.is_retired=0 and des.is_teacher=1 and em.is_active=1 and paycode_id is not null 



----------------To see enlisted USEO
select user_name,user_full_name,phase_name,inf.BU_NAME,BU.BU_TYPE_NAME from MEMIS_LIVE.OA_SET_APPROVAL_PHASE ap  join MEMIS_LIVE.AUTH_SA_USER usr on(ap.phase_id=usr.user_type and user_type=2 and usr.is_active=1) 
left join MEMIS_LIVE.SYS_BU_INFO inf on(usr.F_BU_ID=inf.BU_ID) left join MEMIS_LIVE.SYS_SET_BU_TYPE bu on(inf.F_BU_TYPE_ID=BU.BU_TYPE_ID)


-------------------To see enlisted DEO

select user_name,user_full_name,phase_name,inf.BU_NAME,BU.BU_TYPE_NAME from MEMIS_LIVE.OA_SET_APPROVAL_PHASE ap  join MEMIS_LIVE.AUTH_SA_USER usr on(ap.phase_id=usr.user_type and user_type=3 and usr.is_active=1) 
left join MEMIS_LIVE.SYS_BU_INFO inf on(usr.F_BU_ID=inf.BU_ID) left join MEMIS_LIVE.SYS_SET_BU_TYPE bu on(inf.F_BU_TYPE_ID=BU.BU_TYPE_ID)



--------------------To see enlisted DD

select user_name,user_full_name,phase_name,inf.BU_NAME,BU.BU_TYPE_NAME from MEMIS_LIVE.OA_SET_APPROVAL_PHASE ap  join MEMIS_LIVE.AUTH_SA_USER usr on(ap.phase_id=usr.user_type and user_type=4 and usr.is_active=1) 
left join MEMIS_LIVE.SYS_BU_INFO inf on(usr.F_BU_ID=inf.BU_ID) left join MEMIS_LIVE.SYS_SET_BU_TYPE bu on(inf.F_BU_TYPE_ID=BU.BU_TYPE_ID)



-------------To see enlisted Inspector Male

select user_name,user_full_name,phase_name,inf.BU_NAME,BU.BU_TYPE_NAME from MEMIS_LIVE.OA_SET_APPROVAL_PHASE ap  join MEMIS_LIVE.AUTH_SA_USER usr on(ap.phase_id=usr.user_type and user_type=5 and usr.is_active=1) 
left join MEMIS_LIVE.SYS_BU_INFO inf on(usr.F_BU_ID=inf.BU_ID) left join MEMIS_LIVE.SYS_SET_BU_TYPE bu on(inf.F_BU_TYPE_ID=BU.BU_TYPE_ID)



-----------------To see enlisted Inspector Female

select user_name,user_full_name,phase_name,inf.BU_NAME,BU.BU_TYPE_NAME from MEMIS_LIVE.OA_SET_APPROVAL_PHASE ap  join MEMIS_LIVE.AUTH_SA_USER usr on(ap.phase_id=usr.user_type and user_type=5 and usr.is_active=1) 
left join MEMIS_LIVE.SYS_BU_INFO inf on(usr.F_BU_ID=inf.BU_ID) left join MEMIS_LIVE.SYS_SET_BU_TYPE bu on(inf.F_BU_TYPE_ID=BU.BU_TYPE_ID)


---------------To see enlisted Institutional Head

select user_name,user_full_name,phase_name,inf.BU_NAME,BU.BU_TYPE_NAME from MEMIS_LIVE.OA_SET_APPROVAL_PHASE ap  join MEMIS_LIVE.AUTH_SA_USER usr on(ap.phase_id=usr.user_type and user_type=1 and usr.is_active=1) 
left join MEMIS_LIVE.SYS_BU_INFO inf on(usr.F_BU_ID=inf.BU_ID) left join MEMIS_LIVE.SYS_SET_BU_TYPE bu on(inf.F_BU_TYPE_ID=BU.BU_TYPE_ID)


----------------To see total active users


select user_name,user_full_name,phase_name,inf.BU_NAME,BU.BU_TYPE_NAME from MEMIS_LIVE.OA_SET_APPROVAL_PHASE ap  join MEMIS_LIVE.AUTH_SA_USER usr on(ap.phase_id=usr.user_type and usr.is_active=1) 
left join MEMIS_LIVE.SYS_BU_INFO inf on(usr.F_BU_ID=inf.BU_ID) left join MEMIS_LIVE.SYS_SET_BU_TYPE bu on(inf.F_BU_TYPE_ID=BU.BU_TYPE_ID)


select eiin,count(eiin)  from memis_live.mpo_institute  group by eiin having count(*)>1



select ins_name,eiin,institute_id from memis_live.mpo_institute 
where eiin in (select eiin from  memis_live.mpo_institute  group by eiin having count(*)>1) order by eiin





--------------------To know the employee of particular institute

select employee_name,dob,index_no,paycode_id,ins.institute_id,ins_name,em.is_deleted,is_retired,em.sub_id,sub_name,em.desig_id,desig_name from memis_live.mpo_employee_info em,MEMIS_LIVE.MPO_INSTITUTE ins,memis_live.oa_subject os,memis_live.oa_designation od 
where em.f_institute_id=ins.institute_id and os.sub_id=em.sub_id and od.desig_id=em.desig_id and INS.EIIN=101372
--index_no like ('%2030238%')
 
 
 ------------------To know the employee of listing indexes
 
 select employee_name,dob,index_no,paycode_id,ins.institute_id,ins_name,em.is_deleted,is_retired,em.sub_id,sub_name,em.desig_id,desig_name from memis_live.mpo_employee_info em,MEMIS_LIVE.MPO_INSTITUTE ins,memis_live.oa_subject os,memis_live.oa_designation od 
where em.f_institute_id=ins.institute_id and os.sub_id=em.sub_id and od.desig_id=em.desig_id 
and upper(em.index_no) like upper('%2018163%')

---------------To know the arrear

 select employee_name,dob,index_no,paycode_id,ins.institute_id,ins_name,em.is_deleted,is_retired,em.sub_id,sub_name,em.desig_id,desig_name,arrear from memis_live.mpo_employee_info em,MEMIS_LIVE.MPO_INSTITUTE ins,memis_live.oa_subject os,memis_live.oa_designation od 
where em.f_institute_id=ins.institute_id and os.sub_id=em.sub_id and od.desig_id=em.desig_id and arrear is not null

---------------To know sum(arrear)

select sum(arrear) from memis_live.mpo_employee_info em 



------------------To know ntrca roll no infor

select employee_name,index_no,ntrca_roll_no,ntrca_passing_year from memis_live.mpo_employee_info em where ntrca_roll_no is not null



------------------To know arrear in online application

select applicant_name,nid,index_no,arrear,app_submit_date from memis_live.oa_application where arrear>=1


---------------To know arrear in online application(not null)

select applicant_name,nid,index_no,arrear,app_submit_date from memis_live.oa_application where arrear is not null




-----------------Total number of applicant in selected date

select count(*) from memis_live.oa_application where app_submit_date between '05-Dec-2019' and sysdate


---------------Applicant details in selected date

select applicant_name,f_map_id,nid,index_no,arrear,app_submit_date from memis_live.oa_application where app_submit_date between '05-Dec-2019' and sysdate and f_map_id=3



--------------Duplicate index

select nid,employee_name,index_no,mp.f_institute_id,ins_name,bank_code from memis_live.mpo_employee_info mp,memis_live.mpo_institute ins where index_no in(select index_no from memis_live.mpo_employee_info  group by index_no having count(*)>1) and mp.f_institute_id=INS.INSTITUTE_ID


-----------------Duplicate index

select  employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,bank_code,ins.institute_id,ins_name,locd.name division,locz.NAME district,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and index_no in(select index_no from memis_live.mpo_employee_info  group by index_no having count(*)>1) 
 left join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  left join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.zila=0) 
 LEFT join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) order by EM.INDEX_NO
  --LEFT JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_
  
  
  
  -------------------Info about ntrca_roll_no
  
  Select * from MEMIS_LIVE.MPO_EMPLOYEE_INFO where upper(ntrca_roll_no) like(upper('31413141'))
  
  Select * from MEMIS_LIVE.MPO_EMPLOYEE_INFO where f_institute_id=2726 and is_retired=1 

----------------To see the list of enlisted Madrasah

select  institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla,eiin from  memis_live.MPO_INSTITUTE                  
                    LEFT JOIN memis_live.SYS_GEO_LOCATION LOC  ON LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID
                  LEFT JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD) 
             order by division,zilla,upazilla

---------------To see the list of Madrasha for a  particular area


select  institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla,eiin from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND locd.name='DHAKA' and LOCD.ZILA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.NAME='DHAKA'and LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA  and loct.name='MODHUKHALI'and LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
               order by division,zilla,upazilla

-------------------------To see the list of Madrash for a  particular Zone


select  institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla,eiin from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND locd.name='CUMILLA' and LOCD.ZILA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA and LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA and LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD) 
              order by division,zilla,upazilla

-------------------------To see the list of Madrash for a particular district

select  institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla,eiin from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND locd.name='BARISHAL' and LOCD.ZILA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.NAME='BHOLA' and LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
               order by division,zilla,upazilla


 
  
  ------------------No. of Dakhil Madrasha in MPO module
  
  Select count(*) from memis_live.mpo_institute where f_ins_type_id=21
  
  
 -----------No of Alim Madrasha in MPO module
  
   Select count(*) from memis_live.mpo_institute where f_ins_type_id=22
   
 --------------No of Fazil Madrasha in MPO module
   
    Select count(*) from memis_live.mpo_institute where f_ins_type_id=23
    
  ----------------No of Kamil Madrasha in MPO module
    
     Select count(*) from memis_live.mpo_institute where f_ins_type_id=24
     
   ---------------Mpo detatils upto selected month
     
     select * from memis_live.mpo_employee_info where ntrca_roll_no is null and first_mpo between '01-Jan-2019' and sysdate 
     
    -------------------List of Kamail Madrasha from MPO module
     
    select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=24)
                  LEFT JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
 
 ----------------------------List of Kamil Madrasha for a paritcular zone in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=24)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
  
 ----------------------------List of Kamil Madrasha for a paritcular district in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=24)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='CHANDPUR' and LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD) 
             order by division,zilla,upazilla
  
  
 ----------------------------List of Kamil Madrasha for a paritcular area in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=24)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='DHAKA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='DHAKA' and LOCZ.UPAZILA_THANA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  locu.name='SHAHALI'and LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
  
  ------------List of Fazil Madrasha from MPO module
  
  select distinct eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from   memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=23)
                  LEFT JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
 
  
  ----------------------------List of Fazil Madrasha for a paritcular zone in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=23)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD) 
             order by division,zilla,upazilla
  
 ----------------------------List of Fazil Madrasha for a paritcular district in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=23)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='CUMILLA' and LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
  
  
 ----------------------------List of Fazil Madrasha for a paritcular area in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCP.NAME paurashava_city,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=23)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='DHAKA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='DHAKA' and LOCZ.UPAZILA_THANA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  locu.name='SHAHALI'and LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD) 
             order by division,zilla,upazilla
  
 
  
  ---------List of Alim Madrasha from MPO module
  
  
   select distinct eiin, institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from   memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=22)
                  LEFT JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD) 
             order by division,zilla,upazilla
 
 ----------------------------List of Alim Madrasha for a paritcular zone in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=22)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
  
 ----------------------------List of Alim Madrasha for a paritcular district in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=22)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='CUMILLA' and LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
  
  
 ----------------------------List of Alim Madrasha for a paritcular area in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=22)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='DHAKA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='DHAKA' and LOCZ.UPAZILA_THANA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  locu.name='MOHAMMADPUR'and LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla  
   
  -------------List of Dakhil Madrasha from MPO module
  
  select distinct eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from   memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=21)
                  LEFT JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             LEFT JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
 
  ----------------------------List of Dakhil Madrasha for a paritcular zone in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=22)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
  
 ----------------------------List of Dakhil Madrasha for a paritcular district in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=21)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='CUMILLA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='CUMILLA' and LOCZ.UPAZILA_THANA = 0 )
             --LEFT JOIN SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD) 
             order by division,zilla,upazilla
  
  
 ----------------------------List of Dakhil Madrasha for a paritcular area in MPO module
 
 select eiin,institute_id,ins_name,locd.name division,LOCZ.NAME zilla,LOCt.NAME upazilla from  memis_live.MPO_INSTITUTE                  
                     JOIN memis_live.SYS_GEO_LOCATION LOC  ON (LOC.GEO_NO  = MPO_INSTITUTE.F_GEO_ID and MPO_INSTITUTE.f_ins_type_id=21)
                   JOIN memis_live.SYS_GEO_LOCATION LOCD ON ( LOCD.DIVISION = LOC.DIVISION AND LOCD.ZILA = 0  and locd.name='DHAKA')
              JOIN memis_live.SYS_GEO_LOCATION LOCZ ON ( LOCZ.DIVISION = LOC.DIVISION AND LOCZ.ZILA = LOC.ZILA AND locz.name='DHAKA' and LOCZ.UPAZILA_THANA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  locu.name='MOHAMMADPUR'and LOCU.CITYCORP_PAURASAVA = 0 )
              JOIN memis_live.SYS_GEO_LOCATION LOCP ON ( LOCP.DIVISION = LOC.DIVISION AND LOCP.ZILA = LOC.ZILA AND  LOCP.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCP.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND LOCP.UNION_WARD = 0 )
             JOIN memis_live.SYS_GEO_LOCATION LOCT ON ( LOCT.DIVISION = LOC.DIVISION AND LOCT.ZILA = LOC.ZILA  AND LOCT.UPAZILA_THANA = LOC.UPAZILA_THANA AND LOCT.CITYCORP_PAURASAVA = LOC.CITYCORP_PAURASAVA AND  LOCT.UNION_WARD = LOC.UNION_WARD)
              order by division,zilla,upazilla
 



----To see list of teachers in Dakhil Madrasha(MPO module)


select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=21 and em.is_deleted=0 and is_retired=0 --and em.is_active=1
 left join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  left join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.zila=0) 
 LEFT join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
  LEFT JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

----To see list of teachers in Alim  Madrasha(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=22 and em.is_deleted=0 and is_retired=0 
 left join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  left join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.zila=0) 
 LEFT join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
  LEFT JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

 
  ----To see list of teachers in Fazil  Madrasha(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=23 and em.is_deleted=0 and is_retired=0
 left join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  left join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.zila=0) 
 LEFT join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
  LEFT JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 


 ----To see list of teachers in Kamil  Madrasha(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=24 and em.is_deleted=0 and is_retired=0
 left join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  left join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.zila=0) 
 LEFT join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
  LEFT JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

--------------To see list of teachers in dakhil Madrasha for a particular zone(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=21 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

-----------------To see list of teachers in dakhil Madrasha for a particular district(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=21 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 


-------------------To see list of teachers in dakhil Madrasha for a particular area(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=21 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND locu.name='DEMRA' and LOCU.CITYCORP_PAURASAVA = 0 ) 
 

--------------To see list of teachers in alim Madrasha for a particular zone(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=22 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

----------------To see list of teachers in alim Madrasha for a particular district(MPO module)
select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=22 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

-------------------To see list of teachers in alim Madrasha for a particular area(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=22 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND locu.name='DEMRA' and LOCU.CITYCORP_PAURASAVA = 0 ) 


--------------To see list of teachers in Fazil Madrasha for a particular zone(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=23 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

 ----------------To see list of teachers in Fazil Madrasha for a particular district(MPO module)
select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=23 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

-------------------To see list of teachers in Fazil Madrasha for a particular area(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=23 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND locu.name='DEMRA' and LOCU.CITYCORP_PAURASAVA = 0 ) 

 
--------------To see list of teachers in Kamil Madrasha for a particular zone(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=24 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='CUMILLA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

----------------To see list of teachers in Kamil Madrasha for a particular district(MPO module)
select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=24 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 


-------------------To see list of teachers in Fazil Madrasha for a particular area(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and ins.f_ins_type_id=24 and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND locu.name='DEMRA' and LOCU.CITYCORP_PAURASAVA = 0 ) 

----To see list of teachers in all enlisted  Madrasha(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and em.is_deleted=0 and is_retired=0
 left join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  left join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.zila=0) 
 LEFT join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
  LEFT JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 

------------To see list of teachers in all enlisted Madrasha for partiular zone(MPO module)


select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 


----------------To see list of teachers in all enlisted Madrasha for particular district(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND  LOCU.CITYCORP_PAURASAVA = 0 ) 
 
----------------------To see list of teachers in all enlisted madrasha for particular area(MPO module)

select employee_name,dob,index_no,paycode_id,em.is_deleted,is_retired,f_ins_type_id,ins.institute_id,ins_name,locd.name division,locz.NAME district,LOCU.name upazila,em.is_active from memis_live.mpo_employee_info em  join MEMIS_LIVE.MPO_INSTITUTE ins 
on(em.f_institute_id=ins.institute_id) and em.is_deleted=0 and is_retired=0
  join memis_live.sys_geo_location loc on(INS.F_GEO_ID=LOC.GEO_NO)
  join memis_live.sys_geo_location locd on(loc.Division=locd.division and locd.name='DHAKA' AND locd.zila=0) 
  join memis_live.sys_geo_location locz on(locz.DIVISION=loc.DIVISION and locz.ZILA=loc.ZILA and locz.name='DHAKA' and locz.UPAZILA_THANA=0) 
   JOIN  memis_live.SYS_GEO_LOCATION LOCU ON ( LOCU.DIVISION = LOC.DIVISION AND LOCU.ZILA = LOC.ZILA AND LOCU.UPAZILA_THANA = LOC.UPAZILA_THANA AND locu.name='DEMRA' and LOCU.CITYCORP_PAURASAVA = 0 ) 
 
-------------------------------To know BED scale info in mpo module


 select employee_name,dob,index_no,paycode_id,bed_scale_date from memis_live.mpo_employee_info  where is_deleted=0 and is_retired=0 and bed_scale_date between '01-Jul-2018' and '31-Aug-2019' 
 
 
 
 ----------------------------To know detailed information about BED scale in mpo module
 
 
 select info.employee_name,info.dob,info.index_no,paycode_id,bed_scale_date,rpt.basic,rpt.month_increment,pay_month,fin_year from memis_live.mpo_employee_info info,memis_live.monthly_mpo_report rpt where  info.is_deleted=0 and info.is_retired=0 and
  upper(info.index_no)=upper(rpt.index_no) and rpt.pay_month='4' and info.bed_scale_date between '01-Jul-2018' and '30-Sep-2019' and month_increment>0 and fin_year='2020' and basic>=16000 
  
  
  
  ---------------------------To know information about dakhil madrasha salary(MPO module)
  
  select mpr.ins_name,mpr.ins_bank_acc,mpr.index_no,mpr.employee_name,dob,emp_bank_acc,subject,
  ins_bank_name,basic,house_rent,medical_allowance,month_increment,welfare_trust,retired_benifit,
  sal_da_hrent_medical,grant_for_each_month,net_amt_for_the_month,pay_code,pscale,pay_month,
  fin_year,division_name,zila_name,upazila_thana_name,arrear  
   from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=21 
  
  
  ---------------------------To know information about alim madrasha salary(MPO module)
  
  select mpr.* from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=22
  
  ---------------------------To know information about fazil madrasha salary(MPO module)
  
  select mpr.* from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=23
  
  
  ---------------------------To know information about kamil madrasha salary
  
  select mpr.* from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=24
  
  
  --------------------------------Total pay for all institute
  
  select count(*),sum(grant_for_each_month-(welfare_trust+retired_benifit)) net_salary,sum(arrear) arrear
   from memis_live.monthly_mpo_report mpr where fin_year='2020' and pay_month='5' --and arrear is not null
  
  -----------------------------Total pay for dakhil madrasha(mpo module)
  
   select sum(grant_for_each_month-(welfare_trust+retired_benifit)) net_salary,sum(arrear) arrear
    from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=21 
  
  -----------------------------Total pay for alim madrasha(mpo module)
  
  select sum(grant_for_each_month-(welfare_trust+retired_benifit)) net_salary,sum(arrear) arrear
    from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=22 
  
  
  --------------------------Total pay for fazil madrasha(mpo module)
  
   select sum(grant_for_each_month-(welfare_trust+retired_benifit)) net_salary,sum(arrear) arrear
    from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=23
  
  
  ---------------------------Total pay for kamil madrasha(mpo module)
  
   select sum(grant_for_each_month-(welfare_trust+retired_benifit)) net_salary,sum(arrear) arrear
    from memis_live.monthly_mpo_report mpr,MEMIS_LIVE.MPO_INSTITUTE ins where fin_year='2020' and pay_month='5' 
  and MPR.INSTITUTE_ID=INS.INSTITUTE_ID and ins.f_ins_type_id=24
  
  
  
  
  
  --------------------------------To see application status
  
  select f_institute_id,applicant_name,fathers_name,mothers_name,nid,dob,ins_name,eiin,app_type_name,app_status_name,phase_name,app_approve_date,app_submit_date                  
  from memis_live.oa_application oap,memis_live.mpo_institute ins,memis_live.oa_set_app_status aps,memis_live.oa_set_app_type apt,
  memis_live.oa_set_approval_phase app where INS.INSTITUTE_ID=OAP.F_INSTITUTE_ID and OAP.F_MAP_ID=apt.app_type_id 
  and oap.f_app_status_id=APS.APP_STATUS_ID and OAP.PHASE_ID=APP.PHASE_ID and oap.is_deleted=0 and eiin=108852
  
  
  select oap.applicant_name,oap.fathers_name,oap.mothers_name,mpo.nid,oap.dob,ins_name,eiin,app_type_name,app_status_name,phase_name,app_approve_date,app_submit_date                  
  from memis_live.oa_application oap,memis_live.mpo_institute ins,memis_live.oa_set_app_status aps,memis_live.oa_set_app_type apt,
  memis_live.oa_set_approval_phase app,memis_live.mpo_employee_info mpo where INS.INSTITUTE_ID=OAP.F_INSTITUTE_ID and ins.institute_id=mpo.f_institute_id and OAP.F_MAP_ID=apt.app_type_id 
  and oap.f_app_status_id=APS.APP_STATUS_ID and OAP.PHASE_ID=APP.PHASE_ID and oap.is_deleted=0 and ins.eiin=108852 and mpo.F_app_status_id=7
  
  
  
    
  
  
  
  
  
  
  