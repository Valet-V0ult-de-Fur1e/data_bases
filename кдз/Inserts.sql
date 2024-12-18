INSERT INTO DepartmentHR.EmployeePersonalData (FirstName, MiddleName, LastName, Gender, DateBirth, PassportDetails, SNILS, InMarriage, CountChildren)
VALUES ('����', '��������', '������', 1, '1950-01-01', '4536789123', '09876543210', 0, 0),
('�����', '���������', '�������', 0, '1980-02-02', '3498765412', '56789012345', 1, 1),
('ϸ��', '��������', '�������', 1, '1984-03-03', '9874563210', '78945632109', 0, 0),
('�����', '��������', '���������', 0, '2001-04-04', '6754321987', '45678901234', 0, 1),
('���������', '�������������', '�������', 1, '1999-05-05', '8764531290', '32167894567', 1, 2),
('�����', '����������', '��������', 0, '1975-06-06', '5439871620', '12345678901', 0, 0),
('�������', '����������', '��������', 1, '1959-07-07', '7658943210', '98765432109', 1, 3),
('����', '���������', '���������', 0, '1984-08-08', '4327896510', '65432178945', 0, 0),
('������', '���������', '�������', 1, '1977-09-09', '9015673289', '78956732190', 0, 0),
('�������', '����������', '��������', 0, '1987-10-10', '8976542130', '45678901234', 1, 1);

INSERT INTO DepartmentHR.DepartmentHeader (Name, Faculty)
VALUES
('������� �������������� ���������� � ��������������� ����������', '��������� ���������������� � �������������� ����������'),
('������� ������� ������', '��������� ������������ ����');


INSERT INTO DepartmentHR.Vacancy (Name, TypeOfEmployment, Salary, Rate, WorkingGroup)
VALUES
('�������������', '�������� �������', 150000, 1.0, '�������������'),
('�������������', '���', 91000, 0.5, '�������������'),
('�������������', '�����������', 100000, 1.0, '�������������'),
('������� �������������', '���', 80000, 0.5, '�������������'),
('������� ������� ���������', '�������� �������', 200000, 1.0, '�������������'),
('������� ������� ���������', '�������� �������', 90000, 1.0, '����������� ��������'),
('�����������', '�������� �������', 130000, 1.0, '����������� ��������'),
('�������� ������', '�������� �������', 160000, 1.0, '����������� ��������'),
('������� �� �����������������', '�������� �������', 140000, 1.0, '����������� ��������'),
('�����-�������������', '�����������', 50000, 0.25, '�������������'),
('��������� �������������', '�������� �������', 70000, 1.0, '����������� ��������'),
('���������� �� �������������� �����������', '�������� �������', 100000, 1.0, '����������� ��������'),
('�����', '�������� �������', 300000, 1.0, '�������������'),
('����������� ������', '�������� �������', 250000, 1.0, '�������������');

INSERT INTO DepartmentHR.EmployeeLaborBook (EmployeeID, VacancyID, DateOfEmployment, DateOfDismissal, IndividualAllowance, AllowanceInPercents)
VALUES
(1, 1, '1980-09-04', NULL, 20000, 0),
(1, 13, '1970-08-10', NULL, 5000, 0),
(2, 3, '2005-01-05', NULL, 20, 1),
(3, 5, '2010-07-12', '2023-07-01', 1000, 0),
(4, 2, '2023-08-04', NULL, 5, 1),
(4, 6, '2024-01-02', NULL, 2000, 0),
(5, 7, '2022-05-06', NULL, 9000, 0),
(6, 8, '2000-01-11', NULL, 20, 1),
(7, 9, '1985-01-01', NULL, 20000, 0),
(7, 10, '1982-12-11', '2005-08-12', 20000, 0),
(8, 2, '2015-01-03', NULL, 4000, 0),
(9, 3, '2013-09-01', NULL, 15, 1),
(9, 12, '2010-02-09', NULL, 200, 0),
(10, 14, '1999-10-01', NULL, 700, 0),
(10, 1, '2000-05-04', '2020-04-01', 5000, 0);

INSERT INTO DepartmentHR.DepartmentVacancies (DepartmentID, VacancyID, VacancyAllowance, AllowanceInPercents)
VALUES 
(1, 1, 5, 1),
(1, 2, 12, 1),
(1, 5, NULL, NULL),
(1, 7, NULL, NULL),
(1, 8, NULL, NULL),
(1, 9, NULL, NULL),
(1, 13, NULL, NULL),
(1, 14, 3, 1),
(2, 4, NULL, NULL),
(2, 10, NULL, NULL),
(2, 11, NULL, NULL),
(2, 6, NULL, NULL),
(2, 5, 2, 1),
(2, 5, NULL, NULL),
(2, 13, 2, 1),
(2, 3, NULL, NULL),
(2, 12, 2, 1),
(2, 14, 5, 1);

INSERT INTO DepartmentHR.EmployeeQualification (EmployeeID, AcademicDegree, Rank, DateOfConfirmation, Name)
VALUES
(1, '������', NULL, '1980-08-02', '������-�������������� �����'),
(2, '��������', NULL, '2010-07-01', '������-�������������� �����'),
(7, '������', NULL, '1981-08-02', '������������ ����� �����');

INSERT INTO DepartmentHR.Orders (EmployeeID, Number, DateOfSigning)
VALUES
(1, 232344, '2023-02-05')

INSERT INTO DepartmentHR.StaffingTableHeader (Number, DateCompilation, BeginningAction, EndingAction, OrderID)
VALUES
(13, '2023-02-04', '2023-03-01', '2023-04-01', 1);

INSERT INTO DepartmentHR.StaffingTableOptions (StaffingTableID, DepartmentID, DepartmentAllowance, AllowanceInPercents)
VALUES
(1, 1, 10, 1),
(1, 2, NULL, NULL);

INSERT INTO DepartmentHR.EmployeeContacts (EmployeeID, Phone, Mail)
VALUES
(1, '79012345678', 'ivan.petrov@example.com'),
(2, '98765432109', 'maria.ivanova@example.com'),
(3, '34345678910', 'alexander.smirnov@example.com'),
(4, '23234567890', 'elena.sokolova@example.com'),
(5, '45456789123', 'dmitry.nikolaev@example.com'),
(6, '56567891234', 'anna.vasilyeva@example.com'),
(7, '67678912345', 'sergey.romanov@example.com'),
(8, '88885678910', 'tatyana.zakharova@example.com'),
(9, '09996543210', 'oleg.kuznetsov@example.com'),
(10, '12129876543', 'petr.sidorov@example.com');

INSERT INTO DepartmentHR.EmployeeAddress(EmployeeID, City, Street, HouseNumder, ApartmentNumber)
VALUES
(1, '������', '�������� �����', '15', '3'),
(2, '������', '��������� ��������', '24', '5'),
(3, '������', '����������� �����', '96', '7'),
(4, '������', '�������� ����', '123', '8'),
(5, '������', '��������� �����', '43', '6'),
(6, '������', '����������������� ����������', '1', '2'),
(7, '������', '����������� ��������', '32', '4'),
(8, '������', '������������� ��������', '56', '9'),
(9, '������', '������� ��������', '26', '1'),
(10, '������', '������� �������', '21', '3');

INSERT INTO DepartmentHR.EmployeeAbsenteeism (EmployeeID, Reason, StartDate, EndDate)
VALUES 
(1, '������������ ������', '2022-07-01', '2022-08-01'),
(2, '������ �� ����� �� ��������', '2024-11-15', NULL),
(4, '������', '2022-11-15', '2025-11-15'),
(9, '����������', '2024-11-01', '2024-12-01');
