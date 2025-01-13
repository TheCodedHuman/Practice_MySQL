# Here we are forging college_2 database for practice

# creation and usage of database
CREATE DATABASE IF NOT EXISTS college_2;	-- we gave if not exists <database_name> here
USE college_2;


# creation of table
CREATE TABLE IF NOT EXISTS student(			-- we can give if not exists for things like table name too to not throw error
	rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(20)
);


# insertion of values
INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "Anil", 78, "C", "Pune"),
(102, "Bhumika", 93, "A", "Mumbai"),
(103, "Chetan", 85, "B", "Mumbai"),
(104, "Dhruv", 96, "A", "Delhi"),
(105, "Emanual", 12, "F", "Delhi"),
(106, "Farah", 82, "B", "Delhi");


# selecting/showing specific values
SELECT * FROM student;
SELECT name, marks FROM student;
SELECT DISTINCT city FROM student;			-- Unique values


/*
@ point to remember:
where is a condition but, 
{keys(primary, foreign ), default, check} are constraints 
[constraints = bounding criteria = specific criteria on which something should work and some should not]

single-line comment -> `--` or # at starting
multi-line comment -> /*  content	/*
/*



-- using where condition (we can give single as well as multiple conditions by AND)
-- here, using two or more conditions is called clubbing
SELECT * 
FROM student
WHERE marks > 80;

SELECT * FROM student WHERE city = "Mumbai";
SELECT * FROM student WHERE marks > 80 AND city = "Mumbai";


/* we can use operators in mysql too with where CLAUSE 
arithmetic , comparison, logical, bitwise */

-- like here if we used modulus (%) which is modulus (remainder) operator
SELECT *
FROM student 
WHERE marks%10 > 100;

-- here we used != which is not equal to
SELECT *
FROM student
WHERE marks != 85;


-- now we using logical operators
# and
SELECT * FROM student WHERE marks > 80 AND city = 'Mumbai';
SELECT * FROM student WHERE marks > 80 OR city = 'Mumbai';
SELECT * FROM student WHERE marks BETWEEN 80 AND 90;							-- 80 and 90 are included
SELECT * FROM student WHERE city IN ('Delhi', 'Mumbai', 'Gurgaon'); 			-- observe that Gurgaon was isn't even there, still we can give it in condition of IN
SELECT * FROM student WHERE city IN ('Faridabad', 'Gurgaon');
SELECT * FROM student WHERE city NOT IN ('Delhi', 'Mumbai');					-- reversed condition of IN 	student NOT living in Mumbai or Delhi
SELECT * FROM student WHERE marks > 75 LIMIT 3;									-- if we only need 3 students from top


-- order by CLAUSE -> Ascending or Descending
SELECT * FROM student ORDER BY city;											-- ASC [ascending is default]
SELECT * FROM student ORDER BY marks ASC;
SELECT * FROM student ORDER BY marks DESC LIMIT 3								-- for example, if we need first 3 toppers in class by combination of descending and limit


-- aggregate refers to giving conclusion by input of several values (for example, they are like functions having something that we simply do in python) 
SELECT SUM(marks) FROM student;
SELECT MIN(marks) FROM student;
SELECT MAX(marks) FROM student;
SELECT AVG(marks) FROM student;
SELECT COUNT(rollno) FROM student;



-- Group by CLAUSE
/*
this clause groups rows that have the same values into summary
It collects data from multiple records and groups the result by one or more columns
we generally use aggregate functions with group by clause
*/

SELECT city FROM student GROUP BY city;
SELECT city, count(rollno) FROM  student GROUP BY city;
SELECT city, name, count(rollno) FROM  student GROUP BY city;										-- will give error 1055
SELECT city, name, count(rollno) FROM  student GROUP BY city, name;

SELECT city, avg(marks) FROM  student GROUP BY city;							-- this grouped Mumbai, Delhi, Pune

# for average marks in each city in ascending order
SELECT city, avg(marks), count(rollno) 
FROM student 
GROUP BY city 
ORDER BY avg(marks) DESC;	-- observe we used avg(marks) and not marks solely but we can use city here too


-- how many students got specific grades
SELECT grade, count(rollno) FROM student GROUP BY grade;
SELECT grade, count(rollno) FROM student GROUP BY count(rollno) ORDER BY grade;							-- rollno are different so grouping can't be done on it, so it will throw error
SELECT grade, count(rollno) FROM student GROUP BY grade ORDER BY count(rollno);
SELECT grade, count(rollno) FROM student GROUP BY grade ORDER BY grade;


-- sometimes we can't use where sometimes, so we can use having in group by CLAUSE
SELECT city FROM student GROUP BY city;
SELECT city, count(rollno) FROM student GROUP BY city;
SELECT city, count(rollno) FROM student GROUP BY city WHERE max(marks) > 90;							-- this will also throw error due to usage of where in group by CLAUSE
SELECT city, count(rollno) FROM student GROUP BY city HAVING max(marks) > 90;



/*
# the general order of writing such clauses so that things work efficiently and effectively
SELECT <columns>
FROM <table_name>
WHERE <condition>
GROUP BY <columns>
HAVING <condition>
ORDER BY <columns> DESC
LIMIT <value>
*/


SELECT city
FROM student
WHERE grade = 'A'
GROUP BY city
HAVING max(marks) >= 93
ORDER BY city DESC;


# update query/statement/keyword
-- let's say if want grade  'A' to become 'outstanding' => 'O')
UPDATE student SET grade = "O" WHERE grade = 'A';					-- Doing this soleley will tell us that we using safe mode

SET SQL_SAFE_UPDATES = 0;											-- this option is present to stop us from doing such changes that may harm unintentionally
UPDATE student SET grade = "O" WHERE grade = 'A';					-- now we can run this effortlessly

SELECT marks, grade FROM student;

UPDATE student
SET marks = 82, grade = 'B'
WHERE rollno = 105;

UPDATE student
SET grade = 'B'
WHERE marks BETWEEN 80 and 90;

UPDATE student
SET marks = marks + 1;

UPDATE student						-- did this to demonstrate emanual's data
SET marks = 12
where rollno = 105;


# delete query/statement/keyword
-- let's say if we want to delete data of student who have marks < 33
-- just like we use insert to INSERT in ROWS, we use DELETE to delete ROWS 
########## ALWAYS PERFORM DELETION OF ANYTHING WITH RESPONSIBILITY
DELETE FROM student
WHERE marks < 33;

SELECT * FROM student;


 /*the below query/command deletes complete data from the database
SET SQL_SAFE_UPDATES = 0;
DELETE FROM student; 
SET SQL_SAFE_UPDATES = 1; */





# more information about foreign keys
SHOW TABLES;
SELECT * FROM student;

CREATE TABLE IF NOT EXISTS dept(
	id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS teacher(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT, 								-- First we have to create a column that we can furhter use for foreign key
    FOREIGN KEY (dept_id) REFERENCES dept(id)	-- then we have to assign that column in foreign key; then we have to connect that column to another table (here dept and in that id)
);

-- ON DELETE CASCADE				
-- ON UPDATE CASCADE						-- If we write these two lines too then the changes done in parent table (here dept) then the changes for deletion (due to ON DELETE CASCADE) and on updatation (due to ON UPDATE CASCADE) will be AUTOMATICALLY done (may work like a power but needs to be performed responsibly, as something is getting automated in another table)
# this is called change cascading 

INSERT INTO dept
VALUES
(101, "Maths"),
(102, "Science");

INSERT INTO teacher
VALUES
(101, "Adam", 101),
(102, "Eve", 102);

SELECT * FROM dept;
SELECT * FROM teacher;

UPDATE dept
SET id = 101
WHERE id = 102;

# here error came because I didn't used on update, delete cascade thing, so I have to drop table and recreate that; althought we have code above

DROP TABLE IF EXISTS teacher;

CREATE TABLE IF NOT EXISTS teacher(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT, 								-- First we have to create a column that we can furhter use for foreign key
    FOREIGN KEY (dept_id) REFERENCES dept(id)	-- then we have to assign that column in foreign key; then we have to connect that column to another table (here dept and in that id)
    ON DELETE CASCADE				
	ON UPDATE CASCADE
);


# Insert values into dept
INSERT INTO dept
VALUES
(101, "Maths"),
(102, "Science");

# Insert values into teacher
INSERT INTO teacher
VALUES
(101, "Adam", 101),
(102, "Eve", 102);

# Show tables and data
SHOW TABLES;
SELECT * FROM dept;
SELECT * FROM teacher;

# Update dept id
UPDATE dept
SET id = 103
WHERE id = 101;

# Show updated data
SELECT * FROM dept;
SELECT * FROM teacher;

UPDATE dept
SET id = 108
WHERE id = 102;

-- so whenever you use foreign keys, always think once about cascading


/* From here we are discussing about ALTER command / table modification queries
we know that schema is design of a table and when we want to change this design/structure
we use ALTER command

In design,  the columns, their datatype and constraints modification are focused*/

SELECT * FROM student;
DESCRIBE student;

ALTER TABLE student
ADD COLUMN age INT;

ALTER TABLE student
DROP COLUMN age;


-- Here we are also using DEFAULT keyword 
ALTER TABLE student
ADD COLUMN age INT NOT NULL DEFAULT 19; 

ALTER TABLE student
MODIFY COLUMN age VARCHAR(2);

INSERT INTO student 
VALUES
(107, "Gargi", 68, 100);				# will throw error as we didn't gave grade, but giving age value wasn't even required

ALTER TABLE student
CHANGE AGE stu_age int;					# now we can enter 3 character 100 age

INSERT INTO student
(rollno, name, marks, stu_age)
VALUES
(107, "Gargi", 68, 100);				# will throw error as we used age VARCHAR(2) but here 100 has 3 characters

ALTER TABLE student
RENAME TO stu;							# by this we can change the TABLE name

ALTER TABLE stu
RENAME TO student;							# by this we can change the TABLE name

ALTER TABLE student
CHANGE name full_name VARCHAR(50);

ALTER TABLE student
DROP COLUMN stu_age;

DELETE FROM student
WHERE marks < 80;

SET SQL_SAFE_UPDATES = 0;		# remember we need to use these commands
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE student
DROP COLUMN grade; 

SELECT * FROM student;

CREATE TABLE here_we_using_truncate
(name varchar(5));

INSERT INTO here_we_using_truncate
VALUES
("fsdfd"), ("dfdgd"), ("dgfgd"), ("fdgdf"), ("dfgsf");

SELECT * FROM here_we_using_truncate;			# use this after below command too, and observe that name columns existed, but DROP would've deleted table taken each and every data

TRUNCATE TABLE here_we_using_truncate;

/*
Key Differences: DROP vs DELETE
Scope: DROP affects the entire table or database, while DELETE affects specific rows.

Reversibility: DROP is permanent and cannot be undone, while DELETE can be reversed if part of a transaction.

Structure: DROP removes the table structure, while DELETE only removes data, leaving the structure intact.
*/


 -- From here we are practicing JOINS