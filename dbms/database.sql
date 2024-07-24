CREATE TABLE Degree (--
    degree_id NUMBER PRIMARY KEY,
    degree_name VARCHAR2(100)
);

CREATE TABLE Courses (--
    course_id NUMBER PRIMARY KEY,
	course_name VARCHAR2(100),
    degree_id NUMBER,
    CONSTRAINT fk_course FOREIGN KEY (degree_id) REFERENCES Degree(degree_id)
);

CREATE TABLE Student (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    username VARCHAR(10),
    password VARCHAR(100),
    email VARCHAR2(100),
    is_active NUMBER default 1, 
    is_admin NUMBER default 0,
    degree_id NUMBER,
    session_id NUMBER,
    CONSTRAINT fk_session FOREIGN KEY (degree_id) REFERENCES Degree(degree_id),
    CONSTRAINT fk_degree FOREIGN KEY (session_id) REFERENCES sessions(session_id)
);



CREATE TABLE student_phone(
    student_id NUMBER,
    phone_number NUMBER,
    CONSTRAINT stu_p FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Admin (--
    admin_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    username VARCHAR(10),
    password VARCHAR(100),
    is_active NUMBER default 1, 
    is_admin NUMBER default 0
);

CREATE TABLE admin_phone(
    admin_id NUMBER,
    phone_number NUMBER,
    CONSTRAINT adm_p FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);


CREATE TABLE Notice ( --
    notice_id NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    content VARCHAR2(4000),
    date_posted DATE
);

CREATE TABLE Student_Leave (--
    leave_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20) default 'Waiting',
    reason VARCHAR2(400),
    CONSTRAINT fk_student_leave FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


CREATE TABLE Student_Feedback (--
    feedback_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    feedback_content VARCHAR2(4000),
    date_submitted DATE,
    CONSTRAINT fk_student_feedback FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


CREATE TABLE sessions (--
    session_id NUMBER PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    degree_id NUMBER,
    CONSTRAINT c_fs FOREIGN KEY degree_id REFERENCES Degree(degree_id) 
);


-- PROCEDURE , TRIGGER , FUNCTION
----------------------------------------------------------

-- function for current date

CREATE OR REPLACE FUNCTION get_current_date RETURN DATE IS
    submited_date DATE;
BEGIN
    SELECT SYSDATE INTO submited_date FROM DUAL;
    RETURN submited_date;
END;
/

-- Sequence for generating course_id values
CREATE SEQUENCE degree_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a degree with automatically generated degree_id
CREATE OR REPLACE PROCEDURE create_degree (
    p_name IN VARCHAR2
)
IS 
BEGIN
    INSERT INTO Degree (degree_id, degree_name) 
    VALUES (degree_seq.NEXTVAL,p_name);
END;
/


-- Sequence for generating notice_id values
CREATE SEQUENCE notice_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a notice with automatically generated notice_id
CREATE OR REPLACE PROCEDURE create_notice (
    title IN VARCHAR2,
    content IN VARCHAR2
)
IS
    submited_date DATE;
BEGIN 
    submited_date := get_current_date();
    INSERT INTO Notice (notice_id, title, content, date_posted) 
    VALUES (notice_seq.NEXTVAL, title, content, submited_date);
END;
/

    
-- Sequence for generating course_id values
CREATE SEQUENCE course_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a subject with automatically generated subject_id
CREATE OR REPLACE PROCEDURE create_course (
    course_name IN VARCHAR2,
    degree_id IN NUMBER
)
IS
BEGIN 
    INSERT INTO Courses(course_id, course_name,degree_id) 
    VALUES (course_seq.NEXTVAL, course_name, degree_id);
END;
/

-- Sequence for generating session_id values
CREATE SEQUENCE sessions_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a session with automatically generated session_id
CREATE OR REPLACE PROCEDURE create_session (
    start_date IN DATE,
    end_date IN DATE,
    degree_id IN NUMBER
)
IS
BEGIN 
    INSERT INTO sessions (session_id,  start_date, end_date,degree_id) 
    VALUES (sessions_seq.NEXTVAL,  start_date, end_date,degree_id);
END;
/



CREATE SEQUENCE admin_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
-- Procedure to create admin without admin_id parameter

CREATE OR REPLACE PROCEDURE create_admin (
    name IN VARCHAR2,
    email IN  VARCHAR2,
    username IN VARCHAR,
    password IN VARCHAR,
    phone IN VARCHAR
       
)
IS
BEGIN 
    INSERT INTO Admin(admin_id, name, email,username,password,is_active,is_admin) 
    VALUES (admin_seq.NEXTVAL,name,email,username,password,1,1);

	INSERT INTO admin_phone(admin_id, phone_number) 
    VALUES (admin_seq.CURRVAL, phone);

END;
/

-- Trigger to ensure that the admin_id is automatically generated
CREATE OR REPLACE TRIGGER trg_admin_id_auto_generate
BEFORE INSERT ON Admin
FOR EACH ROW
BEGIN
    IF :NEW.admin_id IS NULL THEN
        SELECT admin_seq.NEXTVAL INTO :NEW.admin_id FROM DUAL;
    END IF;
END;
/

----------------------------------------------------------------------    

    
-- Sequence for generating student_id values
CREATE SEQUENCE student_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create student without student_id parameter
CREATE OR REPLACE PROCEDURE create_student (
    name IN VARCHAR2,
    email IN VARCHAR2,
    username IN VARCHAR,
    password IN VARCHAR,
    degree_id IN NUMBER,
    phone IN VARCHAR2,
    session_id IN NUMBER
)
IS
BEGIN 
    INSERT INTO Student (student_id, name, email, degree_id,session_id) 
    VALUES (student_seq.NEXTVAL, name, email, degree_id,session_id);
    
    INSERT INTO student_phone (student_id, phone_number) 
    VALUES (student_seq.CURRVAL, phone);
END;
/

-- Trigger to ensure that the student_id is automatically generated
CREATE OR REPLACE TRIGGER trg_student_id_auto_generate
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    IF :NEW.student_id IS NULL THEN
        SELECT student_seq.NEXTVAL INTO :NEW.student_id FROM DUAL;
    END IF;
END;
/


-- Sequence for generating leave_id values
CREATE SEQUENCE student_leave_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create student leave without leave_id parameter
CREATE OR REPLACE PROCEDURE create_leave (
    student_id IN NUMBER,
    start_date IN DATE,
    end_date IN DATE,
    reason IN VARCHAR2
)
IS
BEGIN 
    INSERT INTO Student_Leave (leave_id, student_id, start_date, end_date, reason,status) 
    VALUES (student_leave_seq.NEXTVAL, student_id, start_date, end_date, reason,'waiting'
    );
END;
/

-- Trigger to ensure that the leave_id is automatically generated
CREATE OR REPLACE TRIGGER trg_leave_id_auto_generate
BEFORE INSERT ON Student_Leave
FOR EACH ROW
BEGIN
    IF :NEW.leave_id IS NULL THEN
        SELECT student_leave_seq.NEXTVAL INTO :NEW.leave_id FROM DUAL;
    END IF;
END;
/


-- Sequence for generating feedback_id values
CREATE SEQUENCE student_feedback_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;


-- Procedure to create student feedback without feedback_id parameter
CREATE OR REPLACE PROCEDURE create_feedback (
    student_id NUMBER,
    feedback_content VARCHAR2
)
IS
    submited_date DATE;
BEGIN 
    submited_date := get_current_date();
    INSERT INTO Student_Feedback (feedback_id, student_id, feedback_content, date_submitted) 
    VALUES (student_feedback_seq.NEXTVAL, student_id, feedback_content, submited_date);
END;
/

-- Trigger to ensure that the feedback_id is automatically generated
CREATE OR REPLACE TRIGGER trg_feedback_id_auto_generate
BEFORE INSERT ON Student_Feedback
FOR EACH ROW
BEGIN
    IF :NEW.feedback_id IS NULL THEN
        SELECT student_feedback_seq.NEXTVAL INTO :NEW.feedback_id FROM DUAL;
    END IF;
END;
/
    
EXEC create_degree('computer science');
EXEC create_degree('Robotics');
EXEC create_degree('Mechanical');

EXEC create_course('physics',1);
EXEC create_course('maths',1);
EXEC create_course('physics',2);
EXEC create_course('maths',2);

EXEC create_session(TO_DATE('2 JUL 2022', 'DD MON YYYY'),TO_DATE('2 JUN 2026', 'DD MON YYYY'),1);

EXEC create_admin('Arshdeep','arshdeep@palial','A','bpass','20384758782');
EXEC create_admin('Arsh','palial@arshdeep','B','apss','23498188374');

EXEC create_student('A','A@gmail.com','Ar','ASD',1,'1234567890',1);
EXEC create_student('B','B@gmail.com','Br','ASD',2,'197131730',1);
EXEC create_student('C','C@gmail.com','Br','ASD',1,'2911287131',1);
EXEC create_student('D','D@gmail.com','Cr','ASD',2,'2911357131',1);
EXEC create_student('E','E@gmail.com','Dr','ASD',2,'2971511131',1);
EXEC create_student('F','F@gmail.com','Er','ASD',1,'2971387131',1);


EXEC create_feedback(1,'good project');
EXEC create_feedback(2,'vvvgood project');
EXEC create_feedback(2,'vvgood project');
EXEC create_feedback(5,'vgood project');


EXEC create_leave(1,TO_DATE('23 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(2,TO_DATE('20 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(2,TO_DATE('12 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(3,TO_DATE('9 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(5,TO_DATE('13 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');


EXEC create_notice('NOTICE','CONTENT');
EXEC create_notice('NOTICE','CONTENT');
EXEC create_notice('NOTICE','CONTENT');
EXEC create_notice('NOTICE','CONTENT');


SELECT * FROM Student;
SELECT * FROM student_phone;
SELECT * FROM Student_Leave;
SELECT * FROM Student_Feedback;
SELECT * FROM Notice;
SELECT * FROM sessions;
SELECT * FROM Degree;
SELECT * FROM Courses;
SELECT * FROM Admin;
