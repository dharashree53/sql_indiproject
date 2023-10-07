create database students;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    DateOfBirth DATE,
    Address VARCHAR(255)
);


CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100),
    DurationInWeeks INT
);

CREATE TABLE Enrollments (
    EnrollmentID INT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE
);

CREATE TABLE Assignments (
    AssignmentID INT,
    CourseID INT,
    AssignmentName VARCHAR(100),
    MaxScore INT,
    Deadline DATE
);
CREATE TABLE Grades (
    GradeID INT,
    EnrollmentID INT,
    AssignmentID INT,
    Score INT
);

INSERT INTO Students (StudentID, FirstName, LastName, Email, DateOfBirth, Address)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', '1990-01-01', '123 Main St'),
(2, 'Alice', 'Johnson', 'alice.johnson@example.com', '1992-05-12', '789 Elm St'),
  (3, 'Bob', 'Smith', 'bob.smith@example.com', '1991-09-20', '567 Pine St'),
  (4, 'Eva', 'Brown', 'eva.brown@example.com', '1993-03-08', '890 Cedar St'),
  (5, 'Michael', 'Miller', 'michael.miller@example.com', '1990-11-15', '456 Birch St'),
  (6, 'Sophia', 'Clark', 'sophia.clark@example.com', '1994-07-03', '234 Maple St'),
  (7, 'Daniel', 'Taylor', 'daniel.taylor@example.com', '1992-02-18', '789 Oak St'),
  (8, 'Olivia', 'Anderson', 'olivia.anderson@example.com', '1995-04-26', '567 Cedar St'),
  (9, 'James', 'White', 'james.white@example.com', '1993-10-12', '890 Elm St'),
  (10, 'Emily', 'Harris', 'emily.harris@example.com', '1991-12-05', '123 Pine St');

-- Inserting values into Courses table

INSERT INTO Courses (CourseID, CourseName, Instructor, DurationInWeeks)
VALUES 
  (201, 'Web Development Fundamentals', 'Professor Williams', 10),
  (202, 'Introduction to Data Science', 'Professor Davis', 12),
  (203, 'Graphic Design Basics', 'Professor Moore', 8),
  (204, 'Marketing Strategies', 'Professor Johnson', 6),
  (205, 'Mobile App Development', 'Professor Smith', 14),
  (206, 'Business Ethics', 'Professor Brown', 8),
  (207, 'Creative Writing Workshop', 'Professor Taylor', 10),
  (208, 'Introduction to Psychology', 'Professor White', 12),
  (209, 'Environmental Science', 'Professor Anderson', 10),
  (210, 'Digital Marketing Trends', 'Professor Harris', 6);


-- Inserting values into Enrollments table

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate)
VALUES 
  (1, 1, 201, '2023-01-15'),
  (2, 2, 202, '2023-02-01'),
  (3, 3, 203, '2023-02-10'),
  (4, 4, 204, '2023-03-05'),
  (5, 5, 205, '2023-03-20'),
  (6, 6, 206, '2023-04-02'),
  (7, 7, 207, '2023-04-15'),
  (8, 8, 208, '2023-05-01'),
  (9, 9, 209, '2023-05-10'),
  (10, 10, 210, '2023-06-01');
-- Inserting values into Assignments table

INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, MaxScore, Deadline)
VALUES 
  (1, 201, 'Introduction to SQL', 100, '2023-04-30'),
  (2, 202, 'Data Analysis Project', 150, '2023-05-15'),
  (3, 203, 'Graphic Design Portfolio', 120, '2023-04-20'),
  (4, 204, 'Marketing Case Study', 80, '2023-05-10'),
  (5, 205, 'Mobile App Prototype', 200, '2023-06-01');

-- Inserting values into Grades table

INSERT INTO Grades (GradeID, EnrollmentID, AssignmentID, Score)
VALUES 
  (1, 1, 1, 90),
  (2, 2, 2, 130),
  (3, 3, 3, 110),
  (4, 4, 4, 75),
  (5, 5, 5, 180),
  (6, 6, 1, 95),
  (7, 7, 2, 140),
  (8, 8, 3, 115),
  (9, 9, 4, 82),
  (10, 10, 5, 190);
	



--- 1 Get students enrolled in a specific course
SELECT Students.*
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
WHERE Enrollments.CourseID = 201;


--- 2 Get enrollment details with student names
SELECT Enrollments.EnrollmentID, Students.FirstName, Students.LastName, Courses.CourseName
            FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID;


--- 3 Get courses with their average durations
SELECT CourseName, AVG(DurationInWeeks) AS AverageDuration
FROM Courses
GROUP BY CourseName;


--- 4 Get the number of courses each instructor is teaching:
SELECT Instructor, COUNT(*) AS CourseCount
FROM Courses
GROUP BY Instructor;


--- 5 Get students and their enrolled courses:
SELECT Students.FirstName, Students.LastName, GROUP_CONCAT(Courses.CourseName) AS EnrolledCourses
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Students.StudentID;


--- 6 Get the course with the highest duration:
SELECT * FROM Courses ORDER BY DurationInWeeks DESC LIMIT 1;

--- 7  Get courses with a duration greater than 8 weeks and taught by 'Professor Williams'
SELECT *
 FROM Courses WHERE DurationInWeeks > 8 AND Instructor = 'Professor Williams';






 # 8 Get assignments with scores above the average
SELECT Assignments.AssignmentID, AssignmentName, Grades.Score
FROM Assignments
LEFT JOIN Grades ON Assignments.AssignmentID = Grades.AssignmentID
WHERE Grades.Score > (SELECT AVG(Score) FROM Grades);


# 9 Get assignments and the number of students who completed them
SELECT Assignments.AssignmentID, AssignmentName, COUNT(DISTINCT Grades.EnrollmentID) AS CompletedStudents
FROM Assignments
LEFT JOIN Grades ON Assignments.AssignmentID = Grades.AssignmentID
GROUP BY Assignments.AssignmentID, AssignmentName;


# 10 Get courses with a specific word in the course name, regardless of case
SELECT * FROM Courses WHERE LOWER(CourseName) LIKE '%data%';



# 11 Get courses without an instructor
SELECT * FROM Courses WHERE Instructor IS NULL;




# 12 Get the students who have submitted assignments with a score above 90
SELECT Students.StudentID, FirstName, LastName
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Grades ON Enrollments.EnrollmentID = Grades.EnrollmentID
WHERE Grades.Score > 90
GROUP BY Students.StudentID, FirstName, LastName;


# 13 Insert a new assignment and grade:
INSERT INTO Assignments (AssignmentID, CourseID, AssignmentName, MaxScore, Deadline)
VALUES (6, 301, 'Regression Analysis', 120, '2023-08-15');
INSERT INTO Grades (GradeID, EnrollmentID, AssignmentID, Score)
VALUES (11, 11, 6, 105);



#14 Get distinct assignment IDs with their associated course IDs
SELECT DISTINCT Assignments.AssignmentID, CourseID
FROM Assignments
JOIN Grades ON Assignments.AssignmentID = Grades.AssignmentID;

#15 Assign a label to courses based on their durations:
SELECT CourseName, 
       CASE 
           WHEN DurationInWeeks > 10 THEN 'Long Course'
           WHEN DurationInWeeks > 5 THEN 'Medium Course'
           ELSE 'Short Course'
       END AS CourseLabel
FROM Courses;

# 16 Calculate the total duration of all course
SELECT SUM(DurationInWeeks) AS TotalDuration
FROM Courses;


#17 Get courses with durations between 8 and 12 weeks
SELECT *
FROM Courses
WHERE DurationInWeeks BETWEEN 8 AND 12;

#18 Get students first and last names with an alias for the full name:
SELECT FirstName, LastName, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Students;


#19 Get assignments with an alias for the status based on the deadline
SELECT AssignmentName, 
       CASE 
           WHEN Deadline >= CURDATE() THEN 'On Time'
           ELSE 'Late'
       END AS SubmissionStatus
FROM Assignments;

#20 Find the instructor with the highest average course duration
SELECT Instructor, AVG(DurationInWeeks) AS AvgDuration
FROM Courses
GROUP BY Instructor
ORDER BY AvgDuration DESC
LIMIT 1;

#21 Get a list of unique assignment IDs along with the maximum score for each assignment
SELECT AssignmentID, AssignmentName, MAX(DISTINCT Score) AS MaxScore
FROM Grades
GROUP BY AssignmentID, AssignmentName;


#22 Identify students with an email from a specific domain
SELECT FirstName, LastName, 
       CASE 
           WHEN Email LIKE '%@example.com' THEN 'Example.com User'
           ELSE 'Other Domain User'
       END AS EmailCategory
FROM Students;

#23 Update the address for a specific student (e.g., StudentID = 1)
UPDATE Students SET Address = '456 Oak St' WHERE StudentID = 1;
Select * from students;



# 24 Get students who have enrolled in more than one course
SELECT StudentID, COUNT(CourseID) AS CourseCount
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(CourseID) > 1;


#25 Get the number of enrollments per month:
SELECT MONTH(EnrollmentDate) AS EnrollmentMonth, COUNT(*) AS EnrollmentCount
FROM Enrollments
GROUP BY EnrollmentMonth
ORDER BY EnrollmentMonth;