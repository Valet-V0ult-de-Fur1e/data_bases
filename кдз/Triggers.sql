GO
CREATE TRIGGER DepartmentHR.TriggerEmployeePersonalData ON DepartmentHR.EmployeePersonalData
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted i
				JOIN DepartmentHR.EmployeePersonalData p 
				ON i.FirstName = p.FirstName 
					AND i.MiddleName = p.MiddleName
					AND i.LastName = p.LastName
					AND i.Gender = p.Gender
					AND i.DateBirth = p.DateBirth
					AND i.PassportDetails = p.PassportDetails
					AND i.SNILS = p.SNILS)
		THROW 50001, N'Попытка добавить уже существующего сотрудника', 0
	IF (SELECT COUNT(*) FROM inserted WHERE DATEDIFF(MONTH, DateBirth, GETDATE()) / 12 < 18) > 0
		THROW 50001, N'Попытка добавить сотрудника возрастом меньше 18 лет', 1
	IF (SELECT COUNT(*) FROM inserted WHERE CountChildren < 0) > 0
		THROW 50001, N'Введено некорректное количество детей', 2
END


GO
CREATE TRIGGER DepartmentHR.TriggerEmployeeAbsenteeism ON DepartmentHR.EmployeeAbsenteeism
AFTER INSERT, UPDATE
AS
BEGIN
    IF (SELECT COUNT (*) FROM inserted WHERE  DepartmentHR.getEmployeeInRangeStatus(EmployeeID, StartDate, EndDate) != 'активен') > 0
        THROW 50002, N'Пересечение пропусков', 0
	IF (SELECT COUNT(*) FROM inserted WHERE DATEDIFF(DAY, StartDate, ISNULL(EndDate, StartDate)) < 0) > 0
		THROW 50002, N'Некорректные даты пропуска', 1
END

GO
CREATE TRIGGER DepartmentHR.TriggerEmployeeQualification ON DepartmentHR.EmployeeQualification
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) FROM inserted WHERE DATEDIFF(DAY,(
	SELECT TOP 1 DateBirth FROM DepartmentHR.EmployeePersonalData WHERE DepartmentHR.EmployeePersonalData.EmployeeID = inserted.EmployeeID
	), DateOfConfirmation) < 0) > 0
		THROW 50003, N'Некорректная дата получения квалификации', 0
END


GO
CREATE TRIGGER DepartmentHR.TriggerEmployeeLaborBook ON DepartmentHR.EmployeeLaborBook
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) FROM inserted WHERE DATEDIFF(DAY, DateOfEmployment, ISNULL(DateOfDismissal, GETDATE())) < 0) > 0
		THROW 50004, N'Некорректные даты увольнения/найма', 0
END


GO
CREATE TRIGGER DepartmentHR.TriggerStaffingTableHeader ON DepartmentHR.StaffingTableHeader
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) FROM inserted WHERE DATEDIFF(DAY, BeginningAction, EndingAction) < 0) > 0
		THROW 50005, N'Некорректные даты действия расписания', 0
	IF (SELECT COUNT(*) FROM inserted WHERE Number < 0) > 0
		THROW 50005, N'Некорректный номер расписания', 1
END

GO
CREATE TRIGGER DepartmentHR.TriggerDepartmentHeader ON DepartmentHR.DepartmentHeader
AFTER INSERT, UPDATE
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM inserted i
				JOIN DepartmentHR.DepartmentHeader d 
				ON i.Name = d.Name 
					AND i.Faculty = d.Faculty)
		THROW 50006, N'Попытка добавления к уже существующей кафедры на факультете', 0
END


GO
CREATE TRIGGER DepartmentHR.TriggerOrders ON DepartmentHR.Orders
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) FROM inserted WHERE Number < 0) > 0
		THROW 50007, N'Некорректный номер приказа', 0
	IF (SELECT COUNT(*) FROM inserted WHERE DATEDIFF(DAY,(
		SELECT TOP 1 DateBirth FROM DepartmentHR.EmployeePersonalData WHERE DepartmentHR.EmployeePersonalData.EmployeeID = inserted.EmployeeID
		), DateOfSigning) < 0) > 0
		THROW 50007, N'Некорректная дата приказа', 1
	IF (SELECT COUNT(*) 
		FROM inserted	
		JOIN DepartmentHR.EmployeeQualification 
		ON inserted.EmployeeID = DepartmentHR.EmployeeQualification.EmployeeID
		WHERE DepartmentHR.EmployeeQualification.Rank NOT IN ('дэкан', 'ректор')) > 0
		THROW 50007, N'Пользователь не обладает достаточными полномочиями', 2
END

/*
DROP TRIGGER DepartmentHR.TriggerEmployeePersonalData
DROP TRIGGER DepartmentHR.TriggerEmployeeAbsenteeism
DROP TRIGGER DepartmentHR.TriggerEmployeeLaborBook
DROP TRIGGER DepartmentHR.TriggerEmployeeQualification
DROP TRIGGER DepartmentHR.TriggerStaffingTableHeader
DROP TRIGGER DepartmentHR.TriggerOrders
DROP TRIGGER DepartmentHR.TriggerDepartmentHeader
*/
