/* 
-- Optional t create
CREATE DATABASE AirFlow_Import
go
*/
USE AirFlow_Import
go
/*
--STEP1 -- THIS TABLE PERMANANT ONE
Create table StartwarsPeople
(
	Name  varchar(100), 
	Height int, 
	Mass int,
	Hair_Color varchar(50), 
	Skin_Color varchar(50), 
	Eye_Color varchar(50),
	Birth_Year int, 
	Gender Varchar(50),
	Homeworld varchar(200),
	films varchar(1000), 
	species varchar(1000), 
	vehicles varchar(1000),
	starships varchar(1000), 
	created varchar(1000),
	edited varchar(1000),
	url varchar(1000)
)
*/
--STEP2 -- Creating Table for Inserting JSON Data
Create table #StartwarsPeople
(
	Name  varchar(100), 
	Height int, 
	Mass int,
	Hair_Color varchar(50), 
	Skin_Color varchar(50), 
	Eye_Color varchar(50),
	Birth_Year varchar(50), 
	Gender Varchar(50),
	Homeworld varchar(200),
	films varchar(1000), 
	species varchar(1000), 
	vehicles varchar(1000),
	starships varchar(1000), 
	created varchar(1000),
	edited varchar(1000),
	url varchar(1000)
)

--STEP3 -- IMPORT THE DOWNLOADED JSON DATA TO TABLE
--i -- Import through Open rowset
Declare @Starwarspeople varchar(max)
Select @Starwarspeople= 
		BulkColumn
		from openrowset (BUlk 'E:\ABBBBBB_NEW_TASK_TRY\STAR_WARS_API.json',SINGLE_BLOB) JSON 

/*SINGLE BLOB will reads a file as varbinary(max)*/

select @Starwarspeople as STARTWARS_PEOPLE

--ii -- Insert into StartwarsPeople table from JSON Data
IF ( ISJSON (@Starwarspeople)=1)
	BEGIN 
	PRINT 'JSON FILE IS VALID'

	INSERT INTO #StartwarsPeople 
	select * from openjson (@Starwarspeople , '$.@Starwarspeople.results')
	WITH(Name  varchar(100) '$.name', 
	Height int '$.height', 
	Mass int '$.mass',
	Hair_Color varchar(50) '$.hair_color', 
	Skin_Color varchar(50) '$.skin_color', 
	Eye_Color varchar(50) '$.eye_color',
	Birth_Year varchar(50) '$.birth_year',
	Gender Varchar(50) '$.gender',
	Homeworld varchar(200) '$.homeworld',
	films varchar(1000) '$.films', 
	species varchar(1000) '$.species',
	vehicles varchar(1000) '$.vehicles',
	starships varchar(1000) '$.starships',
	created varchar(1000) '$.created',
	edited varchar(1000) '$.edited',
	url varchar(1000) '$.url' 
	)

	END
ELSE
	BEGIN
		PRINT 'JSON File is Invalid'
	END


--STEP4
Select Name,Height,Mass,Hair_Color,Skin_Color,Eye_Color,Replace(Birth_Year,'BBY','') as Birth_Year,Gender,
Homeworld,films,species,vehicles,starships,created,edited,url into #Tempinsert from #StartwarsPeople
--STEP5 (RECENT AGE CHARACTER WILL BE IN FIRST ROW)
INSERT INTO StartwarsPeople
select * from #Tempinsert order by Birth_Year asc

drop table #StartwarsPeople;
