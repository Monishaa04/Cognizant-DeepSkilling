--Schema creation
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

--Data Insertions
INSERT INTO Accounts VALUES (101, 1, 'Savings', 10000, SYSDATE);
INSERT INTO Accounts VALUES (102, 1, 'Checking', 2000, SYSDATE);
INSERT INTO Accounts VALUES (103, 2, 'Savings', 5000, SYSDATE);
INSERT INTO Accounts VALUES (104, 3, 'Savings', 8000, SYSDATE);
INSERT INTO Accounts VALUES (105, 4, 'Checking', 3000, SYSDATE);

INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-01', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-15', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (3, 'Cathy Lee', 'Analyst', 55000, 'Finance', TO_DATE('2018-10-20', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (4, 'David Kim', 'Support', 40000, 'IT', TO_DATE('2020-01-10', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (5, 'Eva Green', 'HR Executive', 45000, 'HR', TO_DATE('2019-05-05', 'YYYY-MM-DD'));

/*Write a stored procedure ProcessMonthlyInterest that calculates and updates the balance of 
all savings accounts by applying an interest rate of 1% to the current balance.*/
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    FOR acc IN (SELECT AccountID, Balance FROM Accounts WHERE AccountType = 'Savings') LOOP
        UPDATE Accounts
        SET Balance = Balance + (acc.Balance * 0.01),
            LastModified = SYSDATE
        WHERE AccountID = acc.AccountID;

        DBMS_OUTPUT.PUT_LINE('Interest applied for AccountID: ' || acc.AccountID);
    END LOOP;
END;
/

/*Write a stored procedure UpdateEmployeeBonus that updates the salary of 
employees in a given department by adding a bonus percentage passed as a parameter.*/
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    dept_name IN VARCHAR2,
    bonus_percent IN NUMBER
) AS
BEGIN
    FOR emp IN (SELECT EmployeeID, Salary FROM Employees WHERE Department = dept_name) LOOP
        UPDATE Employees
        SET Salary = Salary + (emp.Salary * bonus_percent / 100)
        WHERE EmployeeID = emp.EmployeeID;

        DBMS_OUTPUT.PUT_LINE('Bonus updated for EmployeeID: ' || emp.EmployeeID);
    END LOOP;
END;
/

/*Write a stored procedure TransferFunds that transfers a specified amount from one account
to another, checking that the source account has sufficient balance before making the transfer.*/
CREATE OR REPLACE PROCEDURE TransferFunds (
    from_account IN NUMBER,
    to_account IN NUMBER,
    amount IN NUMBER
) AS
    from_balance NUMBER;
BEGIN
    SELECT Balance INTO from_balance FROM Accounts WHERE AccountID = from_account FOR UPDATE;

    IF from_balance < amount THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient funds in AccountID: ' || from_account);
    ELSE
        UPDATE Accounts
        SET Balance = Balance - amount,
            LastModified = SYSDATE
        WHERE AccountID = from_account;

        UPDATE Accounts
        SET Balance = Balance + amount,
            LastModified = SYSDATE
        WHERE AccountID = to_account;

        DBMS_OUTPUT.PUT_LINE('Transfer of ' || amount || ' from Account ' || from_account || ' to ' || to_account || ' successful.');
    END IF;
END;
/

--Running the procedures
EXEC ProcessMonthlyInterest;
EXEC UpdateEmployeeBonus('IT', 10);
EXEC TransferFunds(101, 102, 1000);
