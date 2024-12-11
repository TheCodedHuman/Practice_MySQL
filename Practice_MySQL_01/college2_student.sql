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

SELECT grade FROM student GROUP BY grade 



