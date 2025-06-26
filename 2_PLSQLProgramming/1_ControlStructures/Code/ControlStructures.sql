-- Schema Creation
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Data Insertions
INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1950-05-15', 'YYYY-MM-DD'), 12000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 8000, SYSDATE);
INSERT INTO Customers VALUES (3, 'Mark Taylor', TO_DATE('1962-03-10', 'YYYY-MM-DD'), 3000, SYSDATE);
INSERT INTO Customers VALUES (4, 'Lucy Brown', TO_DATE('1975-09-25', 'YYYY-MM-DD'), 15000, SYSDATE);
INSERT INTO Customers VALUES (5, 'Emily White', TO_DATE('1955-12-01', 'YYYY-MM-DD'), 11000, SYSDATE);


INSERT INTO Loans VALUES (1, 1, 5000, 6, SYSDATE, ADD_MONTHS(SYSDATE, 24));
INSERT INTO Loans VALUES (2, 2, 3000, 7, SYSDATE, SYSDATE +28);
INSERT INTO Loans VALUES (3, 3, 2000, 6.5, SYSDATE, SYSDATE + 14);
INSERT INTO Loans VALUES (4, 4, 8000, 5.5, SYSDATE, SYSDATE + 25); 
INSERT INTO Loans VALUES (5, 5, 10000, 6.2, SYSDATE, ADD_MONTHS(SYSDATE, 18));

/*Write a PL/SQL block that loops through all customers, checks their age,
and if they are above 60, apply a 1% discount to their current loan interest 
rates.*/
BEGIN
    FOR cust IN (SELECT * FROM Customers) LOOP
        IF MONTHS_BETWEEN(SYSDATE, cust.DOB)/12 > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = cust.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Discount applied for CustomerID: ' || cust.CustomerID);
        END IF;
    END LOOP;
END;
/

/*Write a PL/SQL block that iterates through all customers and sets a flag
IsVIP to TRUE for those with a balance over $10,000.*/
ALTER TABLE Customers ADD IsVIP VARCHAR2(5);

BEGIN
    FOR cust IN (SELECT * FROM Customers) LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = cust.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Customer ' || cust.CustomerID || ' marked as VIP.');
        END IF;
    END LOOP;
END;
/

/*Write a PL/SQL block that fetches all loans due in the next 30 days
and prints a reminder message for each customer.*/
BEGIN
    FOR loan IN (
        SELECT l.LoanID, l.EndDate, c.Name
        FROM Loans l JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate <= SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || loan.LoanID || 
                             ' for ' || loan.Name || 
                             ' is due on ' || TO_CHAR(loan.EndDate, 'DD-MON-YYYY'));
    END LOOP;
END;
/

