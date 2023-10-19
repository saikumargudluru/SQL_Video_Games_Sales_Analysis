--CREATED DATABASE
create database end_sql_capstone_1;
use end_sql_capstone_1;

-- TO IMPORTED DATASET INTO SQL I USE THIS STEPS
/* 
step-1:select database   which  you  created database.
step-2:then right click on database and select  task  and it show options in that options select import fiat file  and then import dataset  into sql */

--TO FETECH TABLE VG_SALES USING SELECT STATEMENT--
select * from vg_sales;

--DID SOME CLEANING AND CHANGE N/A WITH NULL
update vg_sales
set year=null where year='n/a';

--CHANGE DATATYPE VARCHAR TO INT
alter table vg_sales
alter column year int ;

--DELETE NULLS  FROM TABLE 
delete from vg_sales
where year is null;

--TOP 5 SELLING GAMES AROUND GLOBAL
select games_name,global_sales from
(select name as games_name,global_sales,dense_rank() over(order by global_sales desc)rnk from vg_sales)t1
where rnk<=5;

--DISTRIBUTION OF SALES BY COUNTRY WISE
select sum(na_sales) as north_america,sum(eu_sales) as europe,sum(jp_sales) as japan,sum(other_sales)as other_countries  from vg_sales;

--MOST POPULAR PLATFORM AROUND GLOBAL
select platform as most_popular_platform from
(select platform,sum(global_sales)as total_sales,dense_rank() over(order by sum(global_sales) desc)rk   from vg_sales group by platform)t2
where rk = 1;

--TOTAL SALES BY PLATFORMS FOR THIS I USED STORTED PROCEDURE
create procedure total_sales_of_platform
as
begin
select platform,sum(global_sales)as total_sales from vg_sales
group by platform
end;

--TO FETECH THE TOTAL_SALES_OF_PLATFORM USING EXCE AND PROCEDURE_NAME
exec  total_sales_of_platform;

--TOTAL SALES BY PUBLISHER FOR THIS I USED STORTED PROCEDURE
create procedure total_sales_of_publisher
as
begin
select publisher,sum(global_sales)as total_sales from vg_sales
group by publisher
end;

--TO FETECH THE TOTAL_SALES_OF_PLATFORM USING EXCE AND PROCEDURE_NAME
exec total_sales_of_publisher;

--AVERAGE_SALES PER GAME for this i USED STORTED PROCEDURE
create procedure avg_sales
as
begin
select name as games_name,avg(global_sales) as average_sales from  vg_sales
group by name
end;
--TO FETECH THE AVERAGE_SALES PER GAME USING EXCE AND PROCEDURE_NAME
exec avg_sales;

--FIND HIGHEST AND LOWEST  SALES FOR GAME FOR THIS I USED STORTED PROCEDURE
create procedure highest_lowest_sales
as
begin
select  name as games_name ,max(global_sales)as highest_sales,min(global_sales)as lowest_sales from vg_sales
group by name
end;
--TO FETECH THE AVERAGE_SALES PER GAME USING EXCE AND PROCEDURE_NAME
exec highest_lowest_sales;

--HIGHEST NUMBER OF PUBLISHER AVALIABLE FOR WHICH GAME TITLE
select top 1  count(publisher)as number_of_publisher_for_this_game_title ,name as game_title from vg_sales
group by name,publisher
order by  count(publisher) desc;

-------END------------------------------------------------------------------------------------------------------------------










