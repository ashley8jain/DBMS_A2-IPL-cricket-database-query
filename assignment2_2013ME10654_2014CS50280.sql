CREATE TABLE student (
  student_id varchar(50) PRIMARY KEY,
  name varchar(50) NOT NULL
);
CREATE TABLE teacher (
  teacher_id varchar(50) PRIMARY KEY,
  name varchar(50) NOT NULL
);
CREATE TABLE course (
  course_id varchar(50) PRIMARY KEY,
  name varchar(150) NOT NULL
);
CREATE TABLE section (
  section_number char(1),
  course_id varchar(50) REFERENCES course ON DELETE CASCADE,
  CONSTRAINT valid_section CHECK (section_number in ('A','B','C','D')),
  CONSTRAINT course_section_pk PRIMARY KEY(section_number,course_id)
);
CREATE TABLE registers (
  student_id varchar(50) REFERENCES student ON DELETE CASCADE,
  course_id varchar(50) REFERENCES course ON DELETE CASCADE,
  CONSTRAINT registers_pk PRIMARY KEY(student_id,course_id)
);
CREATE TABLE teaches (
  teacher_id varchar(50) REFERENCES teacher ON DELETE CASCADE,
  course_id varchar(50) REFERENCES course ON DELETE CASCADE,
  CONSTRAINT teaches_pk PRIMARY KEY(teacher_id,course_id)
);
