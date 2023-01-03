DROP TABLE IF EXISTS Offer;
DROP TABLE IF EXISTS EmploymentHistory;
DROP TABLE IF EXISTS MilitaryService;
DROP TABLE IF EXISTS Education;
DROP TABLE IF EXISTS ProfessionalReferences;
DROP TABLE IF EXISTS Application;
DROP TABLE IF EXISTS Applicant;
DROP TABLE IF EXISTS JobPosting;
DROP TABLE IF EXISTS HotelManager;
DROP TABLE IF EXISTS HumanResources;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS MiHotel;
CREATE TABLE MiHotel(
	HotelID		INT NOT NULL,
	Street		VARCHAR(50) NOT NULL, 
	City		VARCHAR(50) NOT NULL,  
	State		CHAR(2) NOT NULL,
    Zip			INT NOT NULL, 
    PhoneNumber	VARCHAR(12) NOT NULL,
CONSTRAINT MiHotelPK PRIMARY KEY(HotelID));

CREATE TABLE Employees(
	EmployeeID	INT NOT NULL,
    FirstName	VARCHAR(25) NOT NULL, 
    LastName	VARCHAR(25) NOT NULL,
    DateHired	DATE NOT NULL,
    EmployeeType	CHAR(2) NOT NULL,
    Username	VARCHAR(25) NOT NULL,
    Password	VARCHAR(25) NOT NULL,
    Email		VARCHAR(60) NOT NULL,
    HotelID		INT NOT NULL,
CONSTRAINT EmployeesPK PRIMARY KEY(EmployeeID),
CONSTRAINT EmployeesFK FOREIGN KEY(HotelID) REFERENCES MiHotel(HotelID),
CONSTRAINT EmployeeTypeYNValues CHECK (EmployeeType IN ('HR', 'HM')));

CREATE TABLE HumanResources(
	HRID	INT NOT NULL,
CONSTRAINT HumanResourcesPK PRIMARY KEY (HRID),
CONSTRAINT HumanResourcesFK FOREIGN KEY (HRID) REFERENCES Employees (EmployeeID));

CREATE TABLE HotelManager(
	ManagerID	INT NOT NULL,
CONSTRAINT HotelManagerPK PRIMARY KEY(ManagerID),
CONSTRAINT HotelManagerFK FOREIGN KEY(ManagerID) REFERENCES Employees(EmployeeID));

CREATE TABLE JobPosting(
	PostingID	INT NOT NULL,
    HotelID		INT NOT NULL,
    HRID		INT NOT NULL,
    PositionTitle	VARCHAR(25) NOT NULL,
    PositionDescription	VARCHAR(100) NOT NULL,
CONSTRAINT JobPostingPK PRIMARY KEY (PostingID),
CONSTRAINT JobPostingFK1 FOREIGN KEY(HotelID) REFERENCES MiHotel(HotelID),
CONSTRAINT JobPostingFK2 FOREIGN KEY(HRID) REFERENCES HumanResources(HRID));

CREATE TABLE Applicant(
	ApplicantID				INT NOT NULL,
    Email					VARCHAR(40) NOT NULL,
    Password				VARCHAR(20) NOT NULL,
    FirstName				VARCHAR(30) NOT NULL,
    MiddleName				VARCHAR(30),
    LastName				VARCHAR(30) NOT NULL,
    PrevNameYN				CHAR(1) NOT NULL,
    BirthDate				DATE NOT NULL,
    HomeAddress				VARCHAR(50) NOT NULL,
    AptNumber				VARCHAR(10),
    City					VARCHAR(50) NOT NULL,
    State					CHAR(2) NOT NULL,
    Zip						INT NOT NULL,
    TelephoneNbr			VARCHAR(12) NOT NULL,
    TimetoCall				VARCHAR(20) NOT NULL,
    Over18YN				CHAR(1) NOT NULL,
	ProveEligibleWorkUSYN	CHAR(1) NOT NULL,
    ConvictedCrimeYN		CHAR(1) NOT NULL,
    ConvictionExplanation	VARCHAR(200),
    ValidLicenseYN			CHAR(1) NOT NULL,
    LicenseState			CHAR(2),
    LicenseNumber			VARCHAR(15),
    ProfDesignations		VARCHAR(100),
    ForeignSpeak			VARCHAR(30),
    ForeignWriteRead		VARCHAR(30),
    CurrentEmployeeYN		CHAR(1) NOT NULL,
    PreviousEmployeeYN		CHAR(1) NOT NULL,
    PrevEmpHireDate			DATE,
    PrevEmpEndDate			DATE,
    PrevEmpLocation			VARCHAR(30),    
CONSTRAINT Applicant PRIMARY KEY (ApplicantID),
CONSTRAINT PrevNameYNValues CHECK (PrevNameYN IN ('N', 'Y')),
CONSTRAINT Over18YNValues CHECK (Over18YN IN ('N', 'Y')),
CONSTRAINT ProveEligibleWorkUSYNValues CHECK (ProveEligibleWorkUSYN IN ('N', 'Y')),
CONSTRAINT ConvictedCrimeYNValues CHECK (ConvictedCrimeYN IN ('N', 'Y')),
CONSTRAINT ValidLicenseYNValues CHECK (ValidLIcenseYN IN ('N', 'Y')),
CONSTRAINT CurrentEmployeeYNValues CHECK (CurrentEmployeeYN IN ('N', 'Y')),
CONSTRAINT PreviousEmployeeYNValues CHECK (PreviousEmployeeYN IN ('N', 'Y')));

CREATE TABLE Application(
	ApplicationID	INT NOT NULL,
    ApplicantID		INT NOT NULL,
    PostingID		INT NOT NULL,
    ManagerID		INT NOT NULL,
    SubmissionDate	DATE NOT NULL,
	DateYouCanStart	DATE NOT NULL,
    PayRateDesired	DECIMAL(8,2) NOT NULL, #Pay rate indicates annual salary or hourly equivalent
    WhereHeard		VARCHAR(100) NOT NULL,
    WorkLocation	VARCHAR(50) NOT NULL,
    DaysTimesAvail	VARCHAR(62) NOT NULL,
    ApplicationStatus	CHAR(2),
CONSTRAINT ApplicationPK PRIMARY KEY (ApplicationID),
CONSTRAINT ApplicationFK1 FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
CONSTRAINT ApplicationFK2 FOREIGN KEY (PostingID) REFERENCES JobPosting(PostingID),
CONSTRAINT ApplicationFK3 FOREIGN KEY (ManagerID) REFERENCES HotelManager(ManagerID),
CONSTRAINT ApplicationStatusYNValues CHECK (ApplicationStatus IN ('AC', 'RE')));

CREATE TABLE ProfessionalReferences(
	ReferenceID			INT NOT NULL,
    ReferenceName		VARCHAR(50) NOT NULL,
    Relationship		VARCHAR(50) NOT NULL,
    Occupation		    VARCHAR(50) NOT NULL,
    YearsKnown			INT NOT NULL,
	PhoneNumber		    VARCHAR(12) NOT NULL,
    OtherInfo			VARCHAR(200),
    Initials			VARCHAR(3)NOT NULL,
    ApplicantID			INT NOT NULL,
CONSTRAINT ProfessionalReferencesPK PRIMARY KEY (ReferenceID),
CONSTRAINT ProfessionalReferencesFK FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID));

CREATE TABLE Education(
			EducationID VARCHAR(25) NOT NULL,
            EducationLevel VARCHAR(25) NOT NULL,
            SchoolName VARCHAR(50) NOT NULL,
            Location VARCHAR(25) NOT NULL,
            YearsCompleted VARCHAR(100) NOT NULL,
            GraduatedYN CHAR(1) NOT NULL,
            Concentration VARCHAR(50),
            ApplicantID	INT NOT NULL,
CONSTRAINT EducationPK PRIMARY KEY (EducationID),
CONSTRAINT EducationFK FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID),
CONSTRAINT GraduatedYNValues CHECK (GraduatedYN IN ('N', 'Y')));

CREATE TABLE MilitaryService(
	MilitaryID			INT NOT NULL,
    ServiceHistoryYN	VARCHAR(1) NOT NULL,
    StartDate			DATE,
    EndDate				DATE,
    Branch				VARCHAR(11),
    Rank				VARCHAR(30),
    NationalGuardYN		VARCHAR(1),
    ApplicantID			INT NOT NULL,
CONSTRAINT MilitaryServicePK PRIMARY KEY(MilitaryID),
CONSTRAINT MilitaryServiceFK FOREIGN KEY(ApplicantID) REFERENCES Applicant(ApplicantID),
CONSTRAINT ServiceHistoryYNValues CHECK (ServiceHistoryYN IN ('N', 'Y')),
CONSTRAINT NationalGuardYNValues CHECK (NationalGuardYN IN ('N', 'Y')));

CREATE TABLE EmploymentHistory(
	HistoryID				INT NOT NULL,
    HireDate				DATE,
	LeaveDate				DATE,
    Employer				VARCHAR(50),
    PositionName			VARCHAR(50),
    PositionDescription 	VARCHAR(200),
    SupervisorName	        VARCHAR(30),
    SupervisorPhone		    VARCHAR(12),
    ReasonForLeaving		VARCHAR(200),
    ApplicantID			    INT NOT NULL,
CONSTRAINT EmploymentHistoryPK PRIMARY KEY(HistoryID),
CONSTRAINT EmploymentHistoryFK FOREIGN KEY(ApplicantID)  REFERENCES Applicant(ApplicantID));

CREATE TABLE Offer(
	OfferID			INT NOT NULL,
    ApplicationID	INT NOT NULL,
    ManagerID		INT NOT NULL,
    HRID			INT NOT NULL,
    FTorPT			CHAR(2) NOT NULL,
    StartDate		DATE NOT NULL,
    PayRate			DECIMAL(8,2) NOT NULL, #Pay rate indicates annual salary or hourly equivalent
    OfferAcceptedYN	CHAR(1),
CONSTRAINT OfferPK PRIMARY KEY(OfferID),
CONSTRAINT OfferFK1 FOREIGN KEY(ApplicationID) REFERENCES Application(ApplicationID),
CONSTRAINT OfferFK2 FOREIGN KEY(ManagerID) REFERENCES HotelManager(ManagerID),
CONSTRAINT OfferFK3 FOREIGN KEY(HRID) REFERENCES HumanResources(HRID),
CONSTRAINT FTorPTYNValues CHECK (FTorPT IN ('FT', 'PT')),
CONSTRAINT OfferAcceptedYNValues CHECK (OfferAcceptedYN IN ('N', 'Y')));

#MiHotel
insert into MiHotel values (1, '618 Loftsgordon Hill', 'Detroit', 'MI', '48206', '810-851-8053');
insert into MiHotel values (2, '79 Golden Leaf Lane', 'Lansing', 'MI', '48217', '313-968-3781');
insert into MiHotel values (3, '02127 Melrose Pass', 'St. Ignace', 'MI', '48930', '517-542-3464');

#Employees
insert into Employees values (1, 'Eryn', 'Hugonnet', '2017-03-02', 'HM', 'ehugonnet0', 'Zp7fuf', 'ehugonnet0@businessinsider.com', 1);
insert into Employees values (2, 'Korey', 'Saller', '2018-10-07', 'HR', 'ksaller1', 'GH1Rpw2p7CmQ', 'ksaller1@github.com', 1);
insert into Employees values (3, 'Thain', 'McKendo', '2018-11-08', 'HR', 'tmckendo2', 'KX6GouKBtfjY', 'tmckendo2@ucoz.ru', 1);
insert into Employees values (4, 'Eliot', 'Baskwell', '2022-02-02', 'HR', 'ebaskwell3', 'HwWedNhM3Ui', 'ebaskwell3@over-blog.com', 1);
insert into Employees values (5, 'Irwin', 'Mumbray', '2020-04-07', 'HM', 'imumbray4', 'gLuPdac2o4c', 'imumbray4@1und1.de', 2);
insert into Employees values (6, 'Dalia', 'Loughren', '2019-02-17', 'HR', 'dloughren5', 'Cj0j3y', 'dloughren5@cyberchimps.com', 1);
insert into Employees values (7, 'Bonita', 'Hosier', '2017-06-09', 'HR', 'bhosier6', 'Bc79LY5F', 'bhosier6@privacy.gov.au', 1);
insert into Employees values (8, 'Sindee', 'Truman', '2021-02-25', 'HM', 'struman7', '0VZ8uj', 'struman7@bluehost.com', 3);

#HumanResources
insert into HumanResources values (2);
insert into HumanResources values (3);
insert into HumanResources values (4);
insert into HumanResources values (6);
insert into HumanResources values (7);

#HotelManager
insert into HotelManager values (1);
insert into HotelManager values (5);
insert into HotelManager values (8);

#JobPosting
insert into JobPosting values (1, 1, 2, 'Housekeeping', 'Responsible for maintaining rooms');
insert into JobPosting values (2, 1, 2, 'Housekeeping', 'Responsible for maintaining rooms');
insert into JobPosting values (3, 1, 2, 'Reception', 'Responsible for front desk');
insert into JobPosting values (4, 1, 3, 'Reception', 'Responsible for front desk');
insert into JobPosting values (5, 1, 3, 'Janitor', 'Responsible for custodial duty');
insert into JobPosting values (6, 2, 4, 'Housekeeping', 'Responsible for maintaining rooms');
insert into JobPosting values (7, 2, 4, 'Housekeeping', 'Responsible for maintaining rooms');
insert into JobPosting values (8, 2, 4, 'Housekeeping', 'Responsible for maintaining rooms');
insert into JobPosting values (9, 2, 6, 'Housekeeping', 'Responsible for maintaining rooms');
insert into JobPosting values (10, 2, 6, 'Reception', 'Responsible for front desk');
insert into JobPosting values (11, 3, 6, 'Reception', 'Responsible for front desk');
insert into JobPosting values (12, 3, 6, 'Reception', 'Responsible for front desk');
insert into JobPosting values (13, 3, 7, 'Janitor', 'Responsible for custodial duty');
insert into JobPosting values (14, 3, 7, 'Housekeeping', 'Responsible for maintaining rooms');
insert into JobPosting values (15, 3, 7, 'Housekeeping', 'Responsible for maintaining rooms');

#Applicant
insert into Applicant values (1, 'jmahy0@reverbnation.com', '2NBnXUXF1l', 'Alice', 'Jehu', 'Mahy', 'N', '2003-07-07', '5932 South Avenue', 33, 'Detroit', 'MI', '48242', '313-916-0547', 'Morning', 'Y', 'Y', 'N', null, 'Y', 'MI', 'M652-344-91', null, 'Spanish', 'Spanish', 'N', 'N', null, null, null);
insert into Applicant values (2, 'cchestney1@redcross.org', 'I7E0J8x7', 'Alfy', 'Catha', 'Chestney', 'N', '2000-07-24', '4396 Evergreen Crossing', 34, 'Grand Rapids', 'MI', '49505', '616-458-7398', 'Evening', 'Y', 'Y', 'N', null, 'Y', 'MI', 'C342-111-91', null, null, null, 'N', 'N', null, null, null);
insert into Applicant values (3, 'tgoldberg2@ucla.edu', 'vTZox3E', 'Vina', 'Timmie', 'Goldberg', 'N', '1977-04-21', '0530 Tennyson Crossing', 37, 'Lansing', 'MI', '48912', '517-763-9680', 'Afternoon', 'Y', 'Y', 'N', null, 'Y', 'MI', 'G652-444-11', null, 'Spanish', 'Spanish', 'N', 'N', null, null, null);
insert into Applicant values (4, 'gcazin3@census.gov', 'myqUC89', 'Jimmie', 'Gerrie', 'Cazin', 'N', '1996-12-02', '4333 Delladonna Point', 5, 'Muskegon', 'MI', '49444', '231-283-4237', 'Morning', 'Y', 'Y', 'Y', 'Petty theft at 18, expunged', 'Y', 'MI', 'C852-124-31', null, null, null, 'N', 'N', null, null, null);
insert into Applicant values (5, 'opearmine4@mashable.com', 'K4VT4VqFZ3', 'Megen', 'Ophelie', 'Pearmine', 'N', '1992-10-27', '1434 Toban Lane', 129, 'Detroit', 'MI', '48232', '313-596-4563', 'Morning', 'Y', 'Y', 'N', null, 'Y', 'MI', 'P552-234-86', null, null, null, 'N', 'N', null, null, null);

#Application
insert into Application values (1, 1, 1, 1, '2022-06-16', '2022-06-27', 25000, 'Friend', 'Detroit', 'TH-SU', 'RE');
insert into Application values (2, 2, 5, 1, '2022-05-09', '2022-06-27', 45000, 'Employee', 'Detroit', 'M-F', 'AC');
insert into Application values (3, 3, 10, 5, '2022-04-16', '2022-07-04', 65000, 'Internet', 'Lansing', 'M-F', 'AC');
insert into Application values (4, 4, 11, 5, '2022-05-22', '2022-06-27', 65000, 'Friend', 'Lansing', 'M-F', 'AC');
insert into Application values (5, 5, 13, 8, '2022-05-30', '2022-07-11', 70000, 'Friend', 'St. Ignace', 'M-F', 'AC');

#ProfessionalReferences
insert into ProfessionalReferences values (1, 'Robert Baker', 'Friend', 'Salesman', 5, '286-154-7863', null, 'AJM', 1);
insert into ProfessionalReferences values (2, 'Steven Whitaker', 'Former Supervisor', 'Business Owner', 3, '313-645-3796', null, 'ACC', 2);
insert into ProfessionalReferences values (3, 'Jamel Deen', 'Former Professor', 'Professor', 2, '461-725-3387', null, 'VTG', 3);
insert into ProfessionalReferences values (4, 'Clarence Tully', 'Former Supervisor', 'Hotel Manager', 2, '896-155-9089', null, 'JGC', 4);
insert into ProfessionalReferences values (5, 'Lois Lane', 'Former Supervisor', 'Head of Sanitation', 1, '157-579-6930', null, 'MOP', 5);

#Education
insert into Education values (1, 'High School', 'Davis High School', 'Alvaiázere', '4', 'Y', null, 1);
insert into Education values (2, 'High School', 'Toretto High School', 'Panacan', 4, 'Y', null, 2);
insert into Education values (3, 'Masters', 'Central Michigan University', 'Mount Pleasant', 4, 'Y', 'Hospitality', 3);
insert into Education values (4, 'Bachelors', 'Michigan State University', 'East Lansing', 4, 'Y', 'Business Administration', 4);
insert into Education values (5, 'High School', 'Lansing High School', 'Lansing', 4, 'Y', null, 5);

#MilitaryService
insert into MilitaryService values (1, 'N', null, null, null, null, null, 1);
insert into MilitaryService values (2, 'N', null, null, null, null, null, 2);
insert into MilitaryService values (3, 'Y', '2015-04-14', '2018-05-01', 'Army', 'Corporal', 'N', 3);
insert into MilitaryService values (4, 'N', null, null, null, null, null, 4);
insert into MilitaryService values (5, 'N', null, null, null, null, null, 5);

#EmploymentHistory
insert into EmploymentHistory values (1, '2020-01-10', '2022-01-25', 'Uptown Cleaning', 'Cleaner', 'Mobile Cleaning Service', 'Danielle Gomez', '194-409-6027', 'Moved to new area', 1);
insert into EmploymentHistory values (2, '2020-09-27', '2022-11-01', 'Wendys', 'Cook', 'Food preparation', 'Alex Robinson', '325-325-8867', 'Seeking new opportunity', 2);
insert into EmploymentHistory values (3, '2015-10-15', '2022-03-29', 'Best Western', 'Lead Reception', 'Reception desk supervisor', 'David Grey', '803-224-8163', 'Relocated to new city', 3);
insert into EmploymentHistory values (4, '2020-08-15', '2021-12-27', 'Nanny Solutions', 'Nanny', 'Childcare and supervision', 'Erin Hart', '497-156-1216', 'Company went out of business', 4);
insert into EmploymentHistory values (5, '2021-08-02', '2016-04-28', 'Lansing School District', 'Sanitation Worker', 'Cleaning services at Lansing Middle School', 'Darnel Carlson', '962-207-8456', 'Unsatisfactory hours', 5);

#Offer
insert into Offer values (1, 2, 1, 2, 'FT', '2022-07-04', 45000, 'Y');
insert into Offer values (2, 3, 5, 3, 'FT', '2022-07-04', 65000, 'Y');
insert into Offer values (3, 4, 5, 4, 'FT', '2022-06-27', 65000, 'Y');
insert into Offer values (4, 5, 8, 7, 'FT', '2022-07-11', 45000, 'Y');