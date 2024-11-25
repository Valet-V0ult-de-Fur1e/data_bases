CREATE SCHEMA DepartmentHR


CREATE TABLE DepartmentHR.EmployeePersonalData (
	EmployeeID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FirstName NCHAR(50) NOT NULL,
	MiddleName NCHAR(50) NOT NULL,
	LastName NCHAR(50) NOT NULL,
	Gender BIT NOT NULL,
	DateBirth DATE NOT NULL,
	PassportDetails NCHAR(10) NULL,
	SNILS NCHAR(11) NULL,
	InMarriage BIT NOT NULL,
	CountChildren INT NOT NULL
)


CREATE TABLE DepartmentHR.DepartmentHeader (
	DepartmentID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name NCHAR(100) NOT NULL,
	Faculty NCHAR(100) NOT NULL
)


CREATE TABLE DepartmentHR.Vacancy (
	VacancyID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name NCHAR(50) NOT NULL,
	TypeOfEmployment NCHAR(100) NOT NULL,
	Salary FLOAT NOT NULL,
	Rate FLOAT NOT NULL,
	WorkingGroup NCHAR(50) NOT NULL
)


CREATE TABLE DepartmentHR.Orders (
	OrderID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.EmployeePersonalData(EmployeeID),
	Number INT NOT NULL,
	DateOfSigning DATE NOT NULL
)


CREATE TABLE DepartmentHR.StaffingTableHeader (
	StaffingTableID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Number INT NOT NULL,
	DateCompilation DATE NOT NULL,
	BeginningAction DATE NOT NULL,
	EndingAction DATE NOT NULL,
	OrderID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.Orders(OrderID)
)


CREATE TABLE DepartmentHR.StaffingTableOptions (
	StaffingTableID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.StaffingTableHeader(StaffingTableID),
	DepartmentID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.DepartmentHeader(DepartmentID),
	DepartmentAllowance FLOAT NULL,
	AllowanceInPercents BIT NULL
)


CREATE TABLE DepartmentHR.EmployeeQualification (
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.EmployeePersonalData(EmployeeID),
	AcademicDegree NCHAR(100) NOT NULL,
	Rank NCHAR(100) NULL,
	DateOfConfirmation DATE NOT NULL,
	Name NCHAR(100) NOT NULL
)


CREATE TABLE DepartmentHR.EmployeeLaborBook (
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.EmployeePersonalData(EmployeeID),
	VacancyID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.Vacancy(VacancyID),
	DateOfEmployment DATE NOT NULL,
	DateOfDismissal DATE NULL,
	IndividualAllowance FLOAT NULL,
	AllowanceInPercents BIT NULL
)


CREATE TABLE DepartmentHR.EmployeeContacts (
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.EmployeePersonalData(EmployeeID),
	Phone NCHAR(11) NOT NULL,
	Mail NCHAR(50) NOT NULL,
)


CREATE TABLE DepartmentHR.EmployeeAddress (
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.EmployeePersonalData(EmployeeID),
	City NCHAR(50) NOT NULL,
	Street NCHAR(50) NOT NULL,
	HouseNumder NCHAR(10) NOT NULL,
	ApartmentNumber NCHAR(10) NOT NULL,
)


CREATE TABLE DepartmentHR.EmployeeAbsenteeism (
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.EmployeePersonalData(EmployeeID),
	Reason NCHAR(300) NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NULL,
)


CREATE TABLE DepartmentHR.DepartmentVacancies (
	DepartmentID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.DepartmentHeader(DepartmentID),
	VacancyID INT NOT NULL FOREIGN KEY REFERENCES DepartmentHR.Vacancy(VacancyID),
	VacancyAllowance FLOAT NULL,
	AllowanceInPercents BIT NULL
)