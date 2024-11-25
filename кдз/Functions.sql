GO 
CREATE FUNCTION DepartmentHR.getEmployeeActiveWorkActualStatus(@EmployeeID INT)
RETURNS CHAR(101)
AS
BEGIN
    DECLARE @EmployeeCountActiveWork INT = 0;
    SELECT @EmployeeCountActiveWork = COUNT(*) 
    FROM DepartmentHR.EmployeeLaborBook
    WHERE DateOfEmployment < GETDATE() AND (GETDATE() < DateOfDismissal OR DateOfDismissal IS NULL) AND EmployeeID = @EmployeeID
    RETURN IIF(@EmployeeCountActiveWork > 0, 'активен', 'не активен')
END


GO 
CREATE FUNCTION DepartmentHR.getEmployeeActiveWorkInRangeStatus(@EmployeeID INT, @RangeStart DATE, @RangeEnd DATE)
RETURNS CHAR(101)
AS
BEGIN
    DECLARE @EmployeeCountActiveWork INT = 0;
    SELECT @EmployeeCountActiveWork = COUNT(*) 
    FROM DepartmentHR.EmployeeLaborBook
    WHERE DateOfEmployment <= @RangeStart AND (@RangeEnd <= DateOfDismissal OR DateOfDismissal IS NULL) AND EmployeeID = @EmployeeID
    RETURN IIF(@EmployeeCountActiveWork > 0, 'активен', 'не активен')
END



GO
CREATE FUNCTION DepartmentHR.getEmployeeActualStatus(@EmployeeID INT)
RETURNS CHAR(101)
AS
BEGIN
    DECLARE @EmployeeReason CHAR(50) = NULL,
    @EmployeeEndDate CHAR(50) = NULL,
    @EmployeeFiredStatus CHAR(101) = DepartmentHR.getEmployeeActiveWorkActualStatus(@EmployeeID);
    SELECT TOP 1 @EmployeeReason = Reason, @EmployeeEndDate = CONVERT(VARCHAR, EndDate, 101) FROM DepartmentHR.EmployeeAbsenteeism
    WHERE StartDate <= GETDATE() AND (EndDate IS NULL OR EndDate >= GETDATE()) AND @EmployeeID = EmployeeID
    ORDER BY StartDate ASC
    IF @EmployeeFiredStatus = 'активен'
    BEGIN
        IF @EmployeeReason IS NULL
            RETURN 'работает'
        RETURN REPLACE(@EmployeeReason, char(32), '') + ' ' + IIF(@EmployeeEndDate IS NULL, 'неопределённый срок', 'до ' + @EmployeeEndDate);
    END
    ELSE
        RETURN @EmployeeFiredStatus
    RETURN @EmployeeFiredStatus
END;


GO
CREATE FUNCTION DepartmentHR.getEmployeeInRangeStatus(@EmployeeID INT, @RangeStart DATE, @RangeEnd DATE)
RETURNS CHAR(101)
AS
BEGIN
    DECLARE @EmployeeReason CHAR(50) = NULL,
    @EmployeeEndDate CHAR(50) = NULL,
    @EmployeeFiredStatus CHAR(101) = DepartmentHR.getEmployeeActiveWorkInRangeStatus(@EmployeeID, @RangeStart, @RangeEnd);
    SELECT TOP 1 @EmployeeReason = Reason, @EmployeeEndDate = CONVERT(VARCHAR, EndDate, 101) FROM DepartmentHR.EmployeeAbsenteeism
    WHERE StartDate >= @RangeStart AND (EndDate IS NULL OR EndDate >= @RangeEnd) AND @EmployeeID = EmployeeID
    ORDER BY StartDate ASC
    IF @EmployeeFiredStatus = 'активен'
    BEGIN
        IF @EmployeeReason IS NULL
            RETURN 'работает'
        RETURN REPLACE(@EmployeeReason, char(32), '') + ' ' + IIF(@EmployeeEndDate IS NULL, 'неопределённый срок', 'до ' + @EmployeeEndDate);
    END
    ELSE
        RETURN @EmployeeFiredStatus
    RETURN @EmployeeFiredStatus
END;


GO
CREATE FUNCTION DepartmentHR.getEmployeeResultPlanSalaryNow(@EmployeeID INT)
RETURNS INT
AS
BEGIN
    DECLARE @EmployeePlanSalary INT = 0;
    SELECT 
    @EmployeePlanSalary = SUM(v.Salary 
        + IIF(elb.AllowanceInPercents IS NULL, 0, IIF(elb.AllowanceInPercents = 1, v.Salary * elb.IndividualAllowance / 100, elb.IndividualAllowance))
        + IIF(sto.AllowanceInPercents IS NULL, 0, IIF(sto.AllowanceInPercents = 1, v.Salary * sto.DepartmentAllowance / 100, sto.DepartmentAllowance))
        + IIF(dv.AllowanceInPercents IS NULL, 0, IIF(dv.AllowanceInPercents = 1, v.Salary * dv.VacancyAllowance / 100, dv.VacancyAllowance)))
    FROM DepartmentHR.EmployeeLaborBook elb
    INNER JOIN DepartmentHR.Vacancy v ON v.VacancyID = elb.VacancyID
    INNER JOIN DepartmentHR.DepartmentVacancies dv ON dv.VacancyID = v.VacancyID
    INNER JOIN DepartmentHR.StaffingTableOptions sto ON sto.DepartmentID = dv.DepartmentID
    WHERE (elb.DateOfDismissal > GETDATE() OR elb.DateOfDismissal IS NULL) AND elb.DateOfEmployment < GETDATE()
    GROUP BY elb.EmployeeID
    HAVING elb.EmployeeID = @EmployeeID
    RETURN @EmployeePlanSalary;
END;


GO
CREATE FUNCTION DepartmentHR.getEmployeeResultVacancyExperienceInRange(@EmployeeID INT, @VacancyID INT, @RangeStart DATE, @RangeEnd DATE)
RETURNS INT
AS
BEGIN
    DECLARE @MonthsRange INT = 0;
    SELECT TOP 1 @MonthsRange = DATEDIFF(MONTH, DateOfEmployment, DateOfDismissal)
    FROM DepartmentHR.EmployeeLaborBook
    WHERE EmployeeID = @EmployeeID AND VacancyID = @VacancyID AND DateOfEmployment <= @RangeStart AND @RangeEnd < DateOfDismissal
    RETURN @MonthsRange
END


GO
CREATE FUNCTION DepartmentHR.getEmployeeResultRealSalaryInRange(@EmployeeID INT, @RangeStart DATE, @RangeEnd DATE)
RETURNS INT
AS
BEGIN
    DECLARE @EmployeePlanSalary INT = 0;
    SELECT 
    @EmployeePlanSalary = SUM(v.Salary 
        + IIF(elb.AllowanceInPercents IS NULL, 0, IIF(elb.AllowanceInPercents = 1, v.Salary * elb.IndividualAllowance / 100, elb.IndividualAllowance))
        + IIF(sto.AllowanceInPercents IS NULL, 0, IIF(sto.AllowanceInPercents = 1, v.Salary * sto.DepartmentAllowance / 100, sto.DepartmentAllowance))
        + IIF(dv.AllowanceInPercents IS NULL, 0, IIF(dv.AllowanceInPercents = 1, v.Salary * dv.VacancyAllowance / 100, dv.VacancyAllowance)))
    FROM DepartmentHR.EmployeeLaborBook elb
    INNER JOIN DepartmentHR.Vacancy v ON v.VacancyID = elb.VacancyID
    INNER JOIN DepartmentHR.DepartmentVacancies dv ON dv.VacancyID = v.VacancyID
    INNER JOIN DepartmentHR.StaffingTableOptions sto ON sto.DepartmentID = dv.DepartmentID
    WHERE (elb.DateOfDismissal > @RangeEnd OR elb.DateOfDismissal IS NULL) AND elb.DateOfEmployment < @RangeStart AND DepartmentHR.getEmployeeResultVacancyExperienceInRange(@EmployeeID, v.VacancyID, @RangeStart, @RangeEnd) > 0 AND DepartmentHR.getEmployeeInRangeStatus(@EmployeeID, @RangeStart, @RangeEnd) = 'работает'
    GROUP BY elb.EmployeeID
    HAVING elb.EmployeeID = @EmployeeID
    RETURN @EmployeePlanSalary;
END;


/*
GO
DROP FUNCTION DepartmentHR.getEmployeeActiveWorkActualStatus
DROP FUNCTION DepartmentHR.getEmployeeActiveWorkInRangeStatus
DROP FUNCTION DepartmentHR.getEmployeeActualStatus
DROP FUNCTION DepartmentHR.getEmployeeInRangeStatus
DROP FUNCTION DepartmentHR.getEmployeeResultPlanSalaryNow
DROP FUNCTION DepartmentHR.getEmployeeResultVacancyExperienceInRange
DROP FUNCTION DepartmentHR.getEmployeeResultRealSalaryInRange
*/