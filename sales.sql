CREATE DATABASE Sales;

CREATE TABLE Contact (
  ContactID       INT AUTO_INCREMENT  NOT NULL, 
  FirstName       VARCHAR(40)         NOT NULL,
  MiddleName      VARCHAR(40),
  LastName        VARCHAR(40)         NOT NULL,
  EmailAddress    TEXT                NOT NULL,
  Phone           TEXT,

  CONSTRAINT Pk_Contact_ContactID PRIMARY KEY (ContactID)
);

CREATE TABLE Employee (
  EmployeeID      INT AUTO_INCREMENT  NOT NULL,
  LoginID         INT                 NOT NULL,
  ManagerID       INT                 NOT NULL,
  BirthDate       DATE                NOT NULL,
  HireDate        DATE                NOT NULL,
  SalariedFlag    DECIMAL,
  VacationHours   INT                 NOT NULL,
  SickLeaveHours  INT                 NOT NULL,
  CurrentFlag     INT                 NOT NULL,
  ContactID       INT                 NOT NULL, 

  CONSTRAINT Pk_Employee_EmployeeID PRIMARY KEY (EmployeeID),
  CONSTRAINT Fk_Employee_ContactID  FOREIGN KEY (ContactID) REFERENCES Contact(ContactID)
);

CREATE TABLE SalesPerson (
  SalesPersonID   INT AUTO_INCREMENT  NOT NULL,
  SalesQuota      DECIMAL             NOT NULL,
  Bonus           DECIMAL             NOT NULL,
  SalesYTD        DATE                NOT NULL,
  SalesLastYear   DATE                NOT NULL,
  EmployeeID      INT                 NOT NULL,

  CONSTRAINT Pk_SalesPerson_SalesPersonID PRIMARY KEY (SalesPersonID),
  CONSTRAINT Fk_SalesPerson_EmployeeID  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE SalesOrder (
  SalesOrderID        INT AUTO_INCREMENT  NOT NULL,
  OrderDate           DATE                NOT NULL,
  Status              INT                 NOT NULL,
  OnlineOrderFlag     TEXT                NOT NULL,
  AccountNumber       INT                 NOT NULL,
  TaxAmt              DECIMAL,
  TotalDue            DECIMAL,
  SalesPersonID       INT                 NOT NULL,

  CONSTRAINT Pk_SalesOrder_SalesOrderID PRIMARY KEY (SalesOrderID),
  CONSTRAINT Fk_SalesOrder_SalesPersonID FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(SalesPersonID)
);