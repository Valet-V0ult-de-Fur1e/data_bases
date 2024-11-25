GO
CREATE VIEW DepartmentHR.EmployeeWorkStatus 
AS
	SELECT
		REPLACE(FirstName, char(32), '') + ' ' + REPLACE(MiddleName, char(32), '')  + ' ' +  REPLACE(LastName, char(32), '') AS FIO,
		DateBirth,
		REPLACE(City, char(32), '') + N', ' + REPLACE(Street, char(32), '') + N' д. ' + REPLACE(HouseNumder, char(32), '') + N' кв. ' + REPLACE(ApartmentNumber, char(32), '') AS Address,
		Phone,
		Mail,
		DepartmentHR.getEmployeeActualStatus(epd.EmployeeID) AS Status,
        DepartmentHR.getEmployeeResultPlanSalaryNow(epd.EmployeeID) AS SalaryPLAN
	FROM DepartmentHR.EmployeePersonalData epd
	INNER JOIN DepartmentHR.EmployeeAddress ea ON ea.EmployeeID = epd.EmployeeID
	INNER JOIN DepartmentHR.EmployeeContacts ec ON ec.EmployeeID = epd.EmployeeID                
	LEFT JOIN DepartmentHR.EmployeeAbsenteeism ead ON ead.EmployeeID = epd.EmployeeID

GO
CREATE VIEW DepartmentHR.VacancyStatus 
AS
SELECT 
	v.Name,
    v.TypeOfEmployment,
    v.Rate,
	COUNT (*) AS CountWorkingEmployeePlan,
	COUNT(*) - (SELECT COUNT(*) FROM DepartmentHR.Vacancy v1
		INNER JOIN DepartmentHR.EmployeeLaborBook elb1 ON v1.VacancyID = elb1.VacancyID
		LEFT JOIN DepartmentHR.EmployeeAbsenteeism ea ON ea.EmployeeID = elb1.EmployeeID
		WHERE v1.Name = v.Name AND v1.TypeOfEmployment = v.TypeOfEmployment AND v1.Rate = v.Rate AND DepartmentHR.getEmployeeActualStatus(elb1.EmployeeID) != 'работает') AS CountWorkingEmployeeNow
FROM DepartmentHR.Vacancy v
INNER JOIN DepartmentHR.EmployeeLaborBook elb ON v.VacancyID = elb.VacancyID
GROUP BY v.Name, v.TypeOfEmployment, v.Rate;


GO
CREATE VIEW DepartmentHR.EmployeeAbsenteeismView
AS
SELECT 
    REPLACE(FirstName, char(32), '') + ' ' + REPLACE(MiddleName, char(32), '')  + ' ' +  REPLACE(LastName, char(32), '') AS FIO,
    Reason,
    StartDate,
    EndDate
FROM DepartmentHR.EmployeeAbsenteeism ea
LEFT JOIN DepartmentHR.EmployeePersonalData epd 
ON ea.EmployeeID = epd.EmployeeID
WHERE EndDate IS NULL OR EndDate > GETDATE()

/*
GO
DROP VIEW DepartmentHR.EmployeeWorkStatus 
DROP VIEW DepartmentHR.VacancyStatus 
DROP VIEW DepartmentHR.EmployeeAbsenteeismView
*/