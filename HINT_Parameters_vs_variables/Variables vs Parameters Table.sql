-- Create the Customer tablelazy left
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50),
    JoinDate DATE
);

-- Insert sample data
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, City, Country, JoinDate) VALUES
(1, 'Alice', 'Smith', 'alice@example.com', 'New York', 'USA', '2023-01-15'),
(2, 'Bob', 'Johnson', 'bob@example.com', 'London', 'UK', '2023-02-20'),
(3, 'Carol', 'Lee', 'carol@example.com', 'Sydney', 'Australia', '2023-03-05'),
(4, 'David', 'Kim', 'david@example.com', 'Seoul', 'South Korea', '2023-04-10'),
(5, 'Eva', 'Müller', 'eva@example.com', 'Berlin', 'Germany', '2023-05-25'),
(6, 'Frank', 'Wright', 'frank@example.com', 'Toronto', 'Canada', '2023-06-01'),
(7, 'Grace', 'Hopper', 'grace@example.com', 'San Francisco', 'USA', '2023-06-15'),
(8, 'Hannah', 'Brown', 'hannah@example.com', 'Dublin', 'Ireland', '2023-07-05'),
(9, 'Ian', 'Taylor', 'ian@example.com', 'Auckland', 'New Zealand', '2023-07-20'),
(10, 'Jack', 'Wilson', 'jack@example.com', 'Cape Town', 'South Africa', '2023-08-01'),
(11, 'Karen', 'Davis', 'karen@example.com', 'Paris', 'France', '2023-08-15'),
(12, 'Leo', 'Martin', 'leo@example.com', 'Rome', 'Italy', '2023-09-01'),
(13, 'Mia', 'Clark', 'mia@example.com', 'Madrid', 'Spain', '2023-09-15'),
(14, 'Nina', 'Lopez', 'nina@example.com', 'Mexico City', 'Mexico', '2023-10-01'),
(15, 'Oscar', 'Garcia', 'oscar@example.com', 'Buenos Aires', 'Argentina', '2023-10-15'),
(16, 'Paul', 'Walker', 'paul@example.com', 'Los Angeles', 'USA', '2023-11-01'),
(17, 'Quinn', 'Evans', 'quinn@example.com', 'Chicago', 'USA', '2023-11-15'),
(18, 'Rachel', 'Green', 'rachel@example.com', 'Manchester', 'UK', '2023-12-01'),
(19, 'Sam', 'White', 'sam@example.com', 'Vancouver', 'Canada', '2023-12-15'),
(20, 'Tina', 'Black', 'tina@example.com', 'Melbourne', 'Australia', '2023-12-25');

SELECT * FROM Customer;


-- || Standard approach with @variables |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Declare variables
DECLARE @Country     VARCHAR(50) = 'USA';
DECLARE @NamePattern VARCHAR(50) = '%A%';
DECLARE @StartDate   DATE = '2023-01-01';
DECLARE @MidDate     DATE = '2023-06-01';
DECLARE @RecentDate  DATE = '2023-12-31';

-- Query using LIKE, IN, and CASE with variables
SELECT 
     *
    ,CASE 
         WHEN JoinDate < @MidDate THEN 'Early Adopter'
         WHEN JoinDate BETWEEN @MidDate AND @RecentDate THEN 'Mid-Year Joiner'
         ELSE 'Recent Joiner'
     END AS JoinCategory
FROM Customer
WHERE 1 = 1
  AND Country = @Country
  AND FirstName LIKE @NamePattern
  AND JoinDate >= @StartDate
ORDER BY JoinDate DESC;



-- || approach without variables |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Create a temporary ONE ROW (!) TABLE to hold parameters
DROP TABLE IF EXISTS #prm;
SELECT 
    CAST('USA'        AS VARCHAR(50) )         AS Country,
    CAST('%A%'        AS VARCHAR(50) )         AS NamePattern,
    CAST('2023-01-01' AS DATE        )         AS StartDate,
    CAST('2023-06-01' AS DATE        )         AS MidDate,
    CAST('2023-12-31' AS DATE        )         AS RecentDate
INTO #prm;


-- Query using values from the #prm table
SELECT 
     c.*
    ,CASE 
         WHEN JoinDate < p.MidDate  THEN 'Early Adopter'
         WHEN JoinDate BETWEEN p.MidDate AND p.RecentDate THEN 'Mid-Year Joiner'
         ELSE 'Recent Joiner'
     END AS JoinCategory
FROM Customer       c 
CROSS JOIN #prm     p   --works as lazy left JOIN (as far as have only 1 row)
WHERE 1 = 1
  AND c.Country = p.Country
  AND c.FirstName LIKE (p.NamePattern)
  AND c.JoinDate >= p.StartDate
ORDER BY JoinDate DESC;

-- Optional: Drop the temp table if needed
-- DROP TABLE #prm;


