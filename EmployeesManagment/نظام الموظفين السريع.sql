-- ����� ����� �������� (�������)
CREATE DATABASE EBSEmployeeDB;
GO
USE EBSEmployeeDB;
GO

/* ���� ������ (������) */
CREATE TABLE Branches (
    BranchID INT IDENTITY(1,1) PRIMARY KEY,
    BranchName NVARCHAR(100) NOT NULL
);

/* ���� ����� �������� */
CREATE TABLE Statuses (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName NVARCHAR(50) NOT NULL
);

/* ���� �������� */
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeNumber NVARCHAR(50) NOT NULL UNIQUE,
    FullName NVARCHAR(150) NOT NULL,
    BranchID INT NOT NULL,
    StatusID INT NOT NULL,
    HireDate DATE NULL,
    Position NVARCHAR(100) NULL,
    CONSTRAINT FK_Employees_Branches FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Employees_Statuses FOREIGN KEY (StatusID)
        REFERENCES Statuses(StatusID) ON UPDATE CASCADE ON DELETE NO ACTION
);

/* ���� ����� ����� ������ */
CREATE TABLE EmployeePhones (
    PhoneID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    PhoneNumber NVARCHAR(25) NOT NULL,
    PhoneType NVARCHAR(25) NULL,
    CONSTRAINT FK_Phones_Employees FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

/* ���� ������� ������ (����� ������) */
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARBINARY(MAX) NOT NULL,
    PasswordSalt VARBINARY(128) NOT NULL,
    Role NVARCHAR(20) NOT NULL DEFAULT N'User', -- Admin | User
    EmployeeID INT NULL,
    CONSTRAINT FK_Users_Employees FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);

/* ������ ����� */
INSERT INTO Branches (BranchName) VALUES (N'��� ������'),(N'��� ���');
INSERT INTO Statuses (StatusName) VALUES (N'���'),(N'�����'),(N'������');