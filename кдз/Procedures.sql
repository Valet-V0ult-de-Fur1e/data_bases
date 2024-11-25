GO
CREATE PROCEDURE DepartmentHR.ShowEmployeesStaffingTableInfo 
	@TableID INT
AS
	SELECT 
		epd.FirstName,
		epd.MiddleName,
		epd.LastName,
		epd.DateBirth,
		dh.Faculty,
		dh.Name,
		v.Name,
		v.TypeOfEmployment,
        v.Rate,
		v.Salary,
        sth.BeginningAction,
		CASE sto.AllowanceInPercents
			WHEN 0 THEN sto.DepartmentAllowance
			WHEN 1 THEN v.Salary * sto.DepartmentAllowance / 100
			ELSE 0
		END AS DepartmentAllowanceS,
		CASE dv.AllowanceInPercents
			WHEN 0 THEN dv.VacancyAllowance
			WHEN 1 THEN v.Salary * dv.VacancyAllowance / 100
			ELSE 0
		END AS VacancyAllowanceS,
		CASE elb.AllowanceInPercents
			WHEN 0 THEN elb.IndividualAllowance
			WHEN 1 THEN v.Salary * elb.IndividualAllowance / 100
			ELSE 0
		END AS IndividualAllowanceS,
		(v.Salary + CASE dv.AllowanceInPercents
			WHEN 0 THEN dv.VacancyAllowance
			WHEN 1 THEN v.Salary * dv.VacancyAllowance / 100
			ELSE 0
		END + CASE elb.AllowanceInPercents
			WHEN 0 THEN elb.IndividualAllowance
			WHEN 1 THEN v.Salary * elb.IndividualAllowance / 100
			ELSE 0
		END + CASE elb.AllowanceInPercents
			WHEN 0 THEN elb.IndividualAllowance
			WHEN 1 THEN v.Salary * elb.IndividualAllowance / 100
			ELSE 0
		END) AS Salary,
        DepartmentHR.getEmployeeInRangeStatus(epd.EmployeeID, sth.BeginningAction, sth.EndingAction) AS Status,
        DepartmentHR.getEmployeeActiveWorkInRangeStatus(epd.EmployeeID, sth.BeginningAction, sth.EndingAction) AS WorkStatus
	FROM DepartmentHR.StaffingTableOptions sto
    INNER JOIN DepartmentHR.StaffingTableHeader sth
    ON sth.StaffingTableID = sto.StaffingTableID
	INNER JOIN DepartmentHR.DepartmentHeader dh
	ON sto.DepartmentID = dh.DepartmentID
	INNER JOIN DepartmentHR.DepartmentVacancies dv
	ON dh.DepartmentID = dv.DepartmentID
	INNER JOIN DepartmentHR.Vacancy v
	ON v.VacancyID = dv.VacancyID
	INNER JOIN DepartmentHR.EmployeeLaborBook elb
	ON elb.VacancyID = v.VacancyID
	INNER JOIN DepartmentHR.EmployeePersonalData epd
	ON elb.EmployeeID = epd.EmployeeID
	WHERE sto.StaffingTableID = @TableID

 
GO
CREATE PROCEDURE DepartmentHR.AddNewEmpoyee 
	@FirstName NCHAR(50), 
	@MiddleName NCHAR(50), 
	@LastName NCHAR(50), 
	@Gender BIT,
	@DateBirth DATE, 
	@PassportDetails NCHAR(10), 
	@SNILS NCHAR(11), 
	@InMarriage BIT, 
	@CountChildren INT,
	@Phone NCHAR(11),
	@Mail NCHAR(50),
	@City NCHAR(50),
	@Street NCHAR(50),
	@HouseNumder NCHAR(10),
	@ApartmentNumber NCHAR(10)
AS
BEGIN
	INSERT INTO DepartmentHR.EmployeePersonalData(FirstName, MiddleName, LastName, Gender, DateBirth, PassportDetails, SNILS, InMarriage, CountChildren)
	VALUES(@FirstName, @MiddleName, @LastName, @Gender, @DateBirth, @PassportDetails, @SNILS, @InMarriage, @CountChildren);
	DECLARE @EmployeeNewID INT;
	SELECT TOP 1 @EmployeeNewID = EmployeeID FROM DepartmentHR.EmployeePersonalData
	WHERE FirstName = @FirstName AND MiddleName = @MiddleName AND LastName = @LastName AND PassportDetails = @PassportDetails AND @SNILS = SNILS
	INSERT INTO DepartmentHR.EmployeeContacts (EmployeeID, Phone, Mail)
	VALUES (@EmployeeNewID, @Phone, @Mail);
	INSERT INTO DepartmentHR.EmployeeAddress(EmployeeID, City, Street, HouseNumder, ApartmentNumber)
	VALUES (@EmployeeNewID, @City, @Street, @HouseNumder, @ApartmentNumber);
END

GO
CREATE PROCEDURE DepartmentHR.FireEmployee 
    @PassportDetails NCHAR(10), 
	@SNILS NCHAR(11), 
	@VacancyID INT = NULL
AS
BEGIN
    DECLARE @EmployeeID INT;
    SELECT TOP 1 @EmployeeID = EmployeeID 
    FROM DepartmentHR.EmployeePersonalData
    WHERE PassportDetails = @PassportDetails AND SNILS = @SNILS
	UPDATE DepartmentHR.EmployeeLaborBook
	SET DateOfDismissal = GETDATE()
	WHERE VacancyID = ISNULL(@VacancyID, VacancyID) AND @EmployeeID = EmployeeID
END

/*
DROP PROCEDURE DepartmentHR.AddNewEmpoyee
DROP PROCEDURE DepartmentHR.ShowEmployeesStaffingTableInfo
DROP PROCEDURE DepartmentHR.FireEmployee
*/