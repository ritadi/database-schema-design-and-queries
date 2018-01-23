DROP SCHEMA IF EXISTS resume_interview_posting CASCADE;
CREATE SCHEMA resume_interview_posting;
SET search_path TO resume_interview_posting;

-- The possible values of a skill type
CREATE TYPE skilltype as ENUM('SQL','Scheme','Python','R','Latex');

-- The possible values of a degree level
CREATE TYPE degreelevel as ENUM('certificate','undergraduate','professional','masters','doctoral');

-- A resume with all the info
CREATE TABLE Resume(
  rID integer PRIMARY KEY,
  summary varchar(100)
);

-- A candidate name showed up in a resume
CREATE TABLE Name(
  rID integer REFERENCES Resume,
  forename varchar(15) NOT NULL,
  surname varchar(15) NOT NULL,
  honorific varhar(15) NOT NULL,
  title varchar(25)
);

-- A bunch of info of a candidate
CREATE TABLE Identification(
  rID integer REFERENCES Resume,
  name varchar(30) REFERENCES Name,
  DOB varchar(15) NOT NULL,
  citizenship varchar(30) NOT NULL,
  address varchar(100) NOT NULL,
  telephone varchar(15) NOT NULL,
  email varchar(50) NOT NULL
);

-- A education history
CREATE TABLE Education(
  rID integer REFERENCES Resume,
  name varchar(30) REFERENCES Identification,
  degreeName varchar(50) NOT NULL,
  institution varchar(30) NOT NULL,
  major varchar(30) NOT NULL,
  minor varchar(30),
  honours boolean DEFAULT False,
  edu_startDate timestamp NOT NULL,
  edu_endDate timestamp NOT NULL,
  degree_level degreelevel NOT NULL,
);

-- Working Experiences a candidate had
CREATE TABLE Experience(
  rID integer REFERENCES Resume,
  name varchar(30) REFERENCES Identification,
  where varchar(25) NOT NULL,
  title varchar(25) NOT NULL,
  pos_startDate timestamp NOT NULL,
  pos_endDate timestamp NOT NULL,
  description varchar(100)
);

--The possible values of the level
CREATE DOMAIN level AS smallint
   DEFAULT NULL
   CHECK (VALUE > 0 AND VALUE < 6);

-- Skills that a candidate has
CREATE TABLE Skills(
  rID integer REFERENCES Resume,
  what skilltype NOT NULL,
  skill_level level NOT NULL
);

-- A question descriptor
CREATE TABLE Question(
  qID interger PRIMARY KEY,
  question varchar(100) NOT NULL
);

-- A job posting
CREATE TABLE Posting(
  pID integer NOT NULL,
  position varchar(20) NOT NULL,
  reqskill_what skilltype NOT NULL,
  reqskill_level level NOT NULL,
  reqskill_importance level NOT NULL,
  qID interger REFERENCES Question,
  PRIMARY KEY (pID,qID)
);

-- An interviewer's info
CREATE TABLE Interviewer(
  sID interger PRIMARY KEY,
  forename varchar(15) NOT NULL,
  surname varchar(15) NOT NULL,
  honorific varhar(15) NOT NULL,
  title varchar(25)
);

--The possible values of the scores
CREATE DOMAIN score AS smallint
   DEFAULT NULL
   CHECK (VALUE >= 0 AND VALUE <= 100);

-- An answer
CREATE TABLE Answer(
  qID integer REFERENCES Posting,
  answer varchar(200)
);

-- An accessment
CREATE TABLE Accessment(
  answer varchar(200) REFERENCES Answer,
  techProficiency score,
  communication score,
  enthusiasm score,
  collegiality score
);

-- An interview
CREATE TABLE Interview(
  rID integer REFERENCES Resume,
  pID integer REFERENCES Posting,
  sID integer REFERENCES Interviewer,
  date DATE NOT NULL,
  time TIME NOT NULL,
  location varchar(20) NOT NULL
);






