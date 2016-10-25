

/**
	Create Table members with six fields
	Primary key = member_id
	Foreign key = member_priviledge
	Unique = username
*/
CREATE TABLE members (
	member_id INTEGER PRIMARY KEY AUTOINCREMENT,
	member_priviledge NOT NULL,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	username TEXT NOT NULL,
	registration_date DATE,
    FOREIGN KEY (member_priviledge) REFERENCES priviledges (member_priviledge) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT username_unique UNIQUE (username)
)


/**
	Create Table priviledge with two fields
	Primary key = member_priviledge
	Unique = priviledge_name
*/
CREATE TABLE priviledges (
	member_priviledge INTEGER PRIMARY KEY AUTOINCREMENT,
	priviledge_name TEXT NOT NULL,
	CONSTRAINT priviledge_name_unique UNIQUE (priviledge_name)
)

--Create index on username of the member table 
CREATE UNIQUE INDEX username_index
  ON members (username);

--Create index on priviledge_name field of the priviledges table 
CREATE UNIQUE INDEX priviledge_name_index
  ON priviledges (priviledge_name);
  
  

/**
	Populating the priviledges table
	I assumed four priviledges
	1. Admin with id = 1
	2. Editor with id = 2
	3. Writer with id = 3
	4. Reader with id = 4
*/
INSERT INTO priviledges ('priviledge_name')
	VALUES ('Admin'),
           ('Editor'),
           ('Writer'),
           ('Reader');
	

/**
	Populating the members table with four rows
	and ensuriing each member/row has a different member_priviledge
	to mirrow our four available priviledges
*/
INSERT INTO members (first_name, last_name, username, member_priviledge, registration_date)
	VALUES ('Joshua','Udensi','AJUdensi', 1, date('now')),
	('Michael','Faniyan','MickeyMouse',2,date('now')),
	('Cynthia','Davies','Cinty123', 3,date('now')),
	('Musa','Paul','theMuse',4,date('now'));


--Below are just sample select statements to request data from our database

--This one utilizes the INNER JOIN command
--This will select all user's nicely with their priviledge
SELECT members.member_id, members.first_name, members.last_name, members.username, members.registration_date, priviledges.priviledge_name 
	FROM members INNER JOIN priviledges ON priviledges.member_priviledge = members.member_priviledge

--This one utilizes the INNER JOIN command with a comparison operator (less than)
--This will select only the Admin and Editor
SELECT members.username, members.member_id, priviledges.priviledge_name 
	FROM members INNER JOIN priviledges ON priviledges.member_priviledge = members.member_priviledge 
	WHERE priviledges.member_priviledge < 3


--This one utilizes the INNER JOIN command with a comparison operator (OR and equal to)
--This will select only the Admin and the Reader
SELECT members.username, members.member_id, priviledges.priviledge_name 
	FROM members INNER JOIN priviledges ON priviledges.member_priviledge = members.member_priviledge 
	WHERE priviledges.member_priviledge = 1 OR priviledges.member_priviledge = 4


--Creating a VIEWS for existing members
CREATE VIEW existing_members AS SELECT members.member_id, members.first_name, members.last_name, members.username, members.registration_date, priviledges.priviledge_name
	FROM members INNER JOIN priviledges ON 
	priviledges.member_priviledge = members.member_priviledge

/** 
	Assuming we have a large database.
	The VACUUM command will help reclaim unused spaces back to the operating system
*/
VACUUM;


--Time to free up your memory if we have taken significant space on disk

--Delete member where member_priviledge = 4
DELETE FROM members WHERE member_priviledge = 4

--Drop/delete the members table
DROP TABLE IF EXISTS members;

--Drop/delete the priviledges table
DROP TABLE IF EXISTS priviledges;


--Drop/delete the existing_members views
DROP VIEW IF EXISTS existing_members;


/*
	Thank You
*/