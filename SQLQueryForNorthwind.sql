/*
Northwind.db

zad.1
Zapytanie zwracające, jako jedno pole o nazwie EmployeeName,
imię i nazwisko pracowników mieszkających w Londynie.
Zwrócone dane posortuj rosnąco tylko wg nazwiska.
(4 os., ostatni: Suyama)

zad.2
Zapytanie zwracające imiona i nazwiska pracowników obsługujących region zachodni.
Dane posortuj rosnąco wg nazwiska.
(2 os.: King, Suyama)

zad.3
Zapytanie zwracające liczbę pracowników obsługujących terytorium Nowego Jorku.
Pole nazwij NewYorkEmployee
(1)

zad.4
Zapytanie zwracające nazwy produktów i ich koszt z zamówienia nr 11005.
Zwrócone nazwy posortuj rosnąco.
(2 rekordy, koszt: 36, 550)

zad.5
Zapytanie zwracające liczbę zamówień klienta VINET,
które obsługiwał pracownik Andrew Fuller.
(2)

zad.6
Zapytanie zwracające łączny jednostkowy koszt produktów z kategorii "przyprawy".
Pole to nazwij CondimentCategoryCost.
(276,75)

zad.7
Zapytanie zwracające średni jednostkowy koszt produktu z kategorii "napoje".
(~38)

zad.8
Zapytanie zwracające łączny koszt wszystkich produktów z kategorii "owoce morza",
pozostających aktualnie w magazynie, dla dostawcy Tokyo Traders.
(40)

zad.9
Napisz funkcję tabelaryczną prostą (inline table-valued function)
zwracającą nazwy produktów dostarczanych przez wybranego dostawce,
podając jego ID jako parametr.

zad.10
Napisz skalarną funkcję użytkownika (scalar-valued user-defined function)
zwracającą łączny koszt zamówienia, podając jego ID, jako parametr
*/


/*******************************************************************************************************************************************************/

/*
zad.1
Zapytanie zwracające, jako jedno pole o nazwie EmployeeName,
imię i nazwisko pracowników mieszkających w Londynie.
Zwrócone dane posortuj rosnąco tylko wg nazwiska.
(4 os., ostatni: Suyama)
*/

/*******************************/

-- SELECT ColName1, ColName2, ...
-- FROM TabName --SourceName
-- WHERE logical
-- GROUP BY ColName, ...
-- HAVING logical
-- ORDER BY ColName --DESC - SORTOWANIE MALEJĄCE / ASC - SORTOWANIE ROSĄCE (Jest Automatycznie, mozna nie wpisywać! kluczowe slowo 'ASC' - ale wpisać  ORDER BY ColName)

/*******************************/

select * from Employees 

--ODP 1.0
select FirstName +  ' ' + LastName as  EmployeeName
from Employees 
where City like 'London' 
Order by LastName asc


--ODP 1.1
SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName -- /CONCAT(colName0, ' ' ,colName1) as colNameMix01/ - TO JEST FUNC() KTOREA POŁĄCZA TABELI W JEDNĄ 
FROM Employees
WHERE City LIKE 'London' 
ORDER BY LastName ASC


--ODP 1.2
SELECT CONCAT(FirstName,' ',LastName) AS EmployeeName
FROM [dbo].[Employees]
WHERE City LIKE 'London' 
ORDER BY LastName ASC

/*******************************************************************************************************************************************************/



/*
zad.2
Zapytanie zwracające imiona i nazwiska pracowników obsługujących region zachodni.
Dane posortuj rosnąco wg nazwiska.
(2 os.: King, Suyama)
*/

SELECT * FROM Employees 
SELECT * FROM EmployeeTerritories
SELECT * FROM Territories
SELECT * FROM Region


--ODP 2.0
SELECT DISTINCT FirstName, LastName -- DISTINCT прибрати дублікатні рядки з результатів запиту
FROM Employees e
	INNER JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
		INNER JOIN Territories t ON et.TerritoryID = t.TerritoryID
			INNER JOIN Region r ON t.RegionID = r.RegionID
WHERE R.RegionDescription LIKE 'W%'
ORDER BY e.LastName


--ODP 2.1
SELECT DISTINCT e.FirstName, e.LastName -- DISTINCT прибрати дублікатні рядки з результатів запиту
FROM Employees e
	INNER JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
		INNER JOIN Territories t ON et.TerritoryID = t.TerritoryID
			INNER JOIN Region r ON t.RegionID = r.RegionID
WHERE R.RegionDescription = 'Western'                                         
ORDER BY e.LastName ASC


--ODP 2.2
SELECT DISTINCT e.FirstName, e.LastName -- DISTINCT прибрати дублікатні рядки з результатів запиту
FROM [dbo].[Employees] e
	 JOIN [dbo].[EmployeeTerritories] et ON e.EmployeeID = et.EmployeeID
		 JOIN [dbo].[Territories] t ON et.TerritoryID = t.TerritoryID
			 JOIN [dbo].[Region] r ON t.RegionID = r.RegionID
WHERE R.RegionDescription = 'Western'                                         
ORDER BY e.LastName ASC

/*******************************************************************************************************************************************************/

/*
zad.3
Zapytanie zwracające liczbę pracowników obsługujących terytorium Nowego Jorku.
Pole nazwij NewYorkEmployee
(1)
*/

SELECT * FROM Employees 
SELECT * FROM EmployeeTerritories
SELECT * FROM Territories

--ODP 3.0
SELECT COUNT( DISTINCT e.LastName) as Count_Employees --COUNT() LICZNIK POL W TABLICY
FROM Employees e 
	JOIN EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
		JOIN Territories t ON et.TerritoryID = t.TerritoryID
WHERE t.TerritoryDescription = 'New York'

/*******************************************************************************************************************************************************/

/*
zad.4
Zapytanie zwracające nazwy produktów i ich koszt z zamówienia nr 11005.
Zwrócone nazwy posortuj rosnąco.
(2 rekordy, koszt: 36, 550)
*/

SELECT * FROM Products
SELECT * FROM [Order Details]

SELECT p.ProductName, (od.UnitPrice * od.Quantity) as Cost_From_Order_No_11005
FROM Products p
	 JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE od.OrderID = '11005'
ORDER BY P.ProductName ASC



/*******************************************************************************************************************************************************/


/*
zad.5
Zapytanie zwracające liczbę zamówień klienta VINET,
które obsługiwał pracownik Andrew Fuller.
(2)
*/

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Employees

SELECT COUNT(c.CustomerID) AS VINET_Customer_Order_Quantity
FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
		JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE c.CustomerID = 'VINET' AND e.FirstName = 'Andrew' and e.LastName = 'Fuller'


/*******************************************************************************************************************************************************/

/*
zad.6
Zapytanie zwracające łączny jednostkowy koszt produktów z kategorii "przyprawy".
Pole to nazwij CondimentCategoryCost.
(276,75)
*/

--Condiments - przyprawy

SELECT * FROM Products

SELECT * FROM Categories

SELECT SUM(P.UnitPrice) AS CondimentCategoryCost
FROM Products p
	INNER JOIN Categories c ON P.CategoryID = C.CategoryID 
WHERE C.CategoryName LIKE 'Condiments'
/*******************************************************************************************************************************************************/


/*

zad.7
Zapytanie zwracające średni jednostkowy koszt produktu z kategorii "napoje".
(~38)

*/

SELECT AVG(P.UnitPrice) 
FROM Products p 
	INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName LIKE 'Beverages'

/*******************************************************************************************************************************************************/

/*
zad.8
Zapytanie zwracające łączny koszt wszystkich produktów z kategorii "owoce morza",
pozostających aktualnie w magazynie, dla dostawcy Tokyo Traders.
(40)
*/

SELECT * FROM Suppliers


SELECT SUM(P.UnitPrice * P.UnitsInStock) AS TotalCost
FROM Categories C
	JOIN Products P ON C.CategoryID = P.CategoryID
	JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE C.CategoryName LIKE 'Produce' AND S.CompanyName LIKE 'Tokyo Traders' --WHERE C.CategoryName LIKE 'Seafood' AND S.CompanyName LIKE 'Tokyo Traders'


/*******************************************************************************************************************************************************/
/*FUNCTION (table-valued & scalar-valued)*/

/*
Функція — це об'єкт бази даних, який виконує обчислення і повертає результат. 
Функції бувають 2 основних типів: Cкалярні (повертають одне значення) і табличні (повертають таблицю)
*/


/*I. Таблична функція (Table-Valued Function)

Опис:
	-Повертає результат у вигляді таблиці.
	-Буває 2 типів:
		1. Інлайн таблична функція (Inline Table-Valued Function): визначається одним SQL-запитом, не використовує BEGIN...END.
		2. Мультиоператорна таблична функція (Multi-Statement Table-Valued Function): виконує кілька SQL-операцій, використовує блок BEGIN...END.
*/


/*
zad.9
Napisz funkcję tabelaryczną prostą (inline table-valued function)
zwracającą nazwy produktów dostarczanych przez wybranego dostawce,
podając jego ID jako parametr.
*/


--odp 9.0

--create Function
CREATE OR ALTER Function Product_F(@id INT)
RETURNS TABLE AS RETURN

(SELECT P.ProductName 
FROM Products P
WHERE P.SupplierID IN
	(SELECT S.SupplierID
	 FROM Suppliers S
	 WHERE SupplierID = @id))


--odp 9.1
CREATE OR ALTER Function NameProduct_F(@ID INT)
RETURNS TABLE AS RETURN

(SELECT P.ProductName
 FROM Products P 
 JOIN Suppliers S ON P.SupplierID = S.SupplierID
 WHERE S.SupplierID = @ID)


SELECT * FROM Product_F(1) -- call function z odp9.0

SELECT * FROM NameProduct_F(1) -- call function z odp9.1


/*
zad.9+
Napisz funkcję tabelaryczną (Multi-Statement Table-Valued Function)
zwracającą nazwy produktów i łączny koszt wszystkich produktów
dostarczanych przez wybranego dostawce,
podając jego ID jako parametr.
*/


--odp 9.0+
CREATE OR ALTER FUNCTION ProductName_TotalCost_F(@id INT)
RETURNS @ResultTable TABLE(
	ProdutcName NVARCHAR(100),
	TotalCost INT) 

AS
BEGIN
	INSERT INTO @ResultTable
	SELECT P.ProductName, SUM(P.UnitPrice * P.UnitsInStock) AS TotalCost
	FROM Products P 
	JOIN Suppliers S ON P.SupplierID = S.SupplierID
	WHERE S.SupplierID = @id
	GROUP BY P.ProductName

	RETURN;
END;


SELECT * FROM ProductName_TotalCost_F(1) --odp 9.0+


/*******************************************************************************************************************************************************/

/*II. Скалярна функція (Scalar Function)
Опис:
	-Повертає одне значення (число, рядок, дату тощо).
	-Використовується в запитах для виконання обчислень.
	-Приймає вхідні параметри.
	-Викликається, наприклад, у SELECT, WHERE, або JOIN.
*/


/*
zad.10
Napisz skalarną funkcję użytkownika (scalar-valued user-defined function)
zwracającą łączny koszt zamówienia, podając jego ID, jako parametr
*/

CREATE OR ALTER FUNCTION TotalCost_F(@ID Int)
RETURNS Money
	AS
	BEGIN
		DECLARE @TotalCost Money
		SET @TotalCost = (
			SELECT SUM(UnitPrice*Quantity)
			FROM [Order Details]
			WHERE OrderID=@ID
			)
	RETURN @TotalCost
	END

SELECT dbo.TotalCost_F(11005)

/*******************************************************************************************************************************************************/

--Zad.11 (Procedura do zad.10)

CREATE OR ALTER PROCEDURE TotalCost_P(@ID INT)
	AS 
	SELECT SUM(O.UnitPrice * O.Quantity) AS TotalCost
	FROM [Order Details] O
	WHERE O.OrderID = @id

EXEC TotalCost_P 11005 

/*******************************************************************************************************************************************************/
--Derived tables / pochodny tabeli
SELECT * FROM Products

/*
Derived Tables (похідні таблиці) у SQL використовуються для створення тимчасових результатів, які можна використовувати в рамках одного запиту.
Вони дозволяють виконувати обчислення, агрегації, сортування або фільтрацію даних на рівні підзапитів і передавати ці проміжні результати у зовнішній запит.
*/

-- Функція ROW_NUMBER() створює унікальні номери для кожного рядка у результаті запиту 

/*
OVER() - Ключове слово OVER визначає, як ROW_NUMBER() буде застосовуватись до даних. У цьому випадку у функції є дві частини

a) PARTITION BY categoryid
	PARTITION BY визначає розбиття (групування) даних \ Ключове слово PARTITION BY використовується для поділу даних на групи.
	У цьому запиті дані розбиваються на групи за значенням categoryid.
	
	Наприклад:
	Якщо в таблиці є 3 категорії (categoryid = 1, 2, 3), то всі продукти з categoryid = 1 будуть в одній групі, 
	всі з categoryid = 2 — в іншій, і так далі.


b) ORDER BY unitprice, productid
	Всередині кожної групи (categoryid) рядки впорядковуються за:
	unitprice (ціна за одиницю) у зростаючому порядку.
	Якщо кілька рядків мають однаковий unitprice, вони додатково впорядковуються за productid (ідентифікатор продукту).
	
	Упорядкування визначає, який рядок отримає номер 1, 2, 3 і так далі
*/


/*
AS rownum
	Функція ROW_NUMBER() обчислює номер рядка в кожній групі.
	Цей результат зберігається в новій колонці з псевдонімом rownum.
*/

/*
наступний запит, який обчислює номери рядків для продуктів, розбитих за categoryid, і впорядкованих за unitprice та productid
*/

SELECT ROW_NUMBER() OVER
(PARTITION BY categoryId
ORDER BY unitPrice, productId) AS RowNum,
categoryId, productId, productName, unitPrice
FROM Products

/*
наступний запит, який обчислює номери рядків для продуктів, розбитих за categoryid, і впорядкованих за unitprice та productid
якщо ви хочете повернути тільки ті рядки, де номер рядка менше або дорівнює 2; 
тобто в кожній категорії повернути два продукти з найменшими цінами
*/
SELECT categoryid, productid, productname, unitprice
FROM 
(SELECT ROW_NUMBER() OVER 
(PARTITION BY categoryid ORDER BY unitprice, productid) AS rownum,
categoryid, productid, productname, unitprice 
FROM Products) AS D
WHERE rownum <= 2;




/*
3. Вкладені похідні таблиці
Припустимо, ми хочемо знайти найдешевший продукт у кожній категорії, а потім ще раз перевірити умови на обрані результати. Ось як це може виглядати:
*/

/*
Існують кілька проблемних аспектів при роботі з похідними таблицями:
Одна проблема виникає, коли потрібно посилатися на одну похідну таблицю з іншої. 
У такому випадку ви можете опинитися в ситуації вкладення похідних таблиць, що ускладнює логіку та підвищує ймовірність помилок.

Загальна форма вкладення виглядає так:

SELECT ...
FROM (SELECT ...
      FROM (SELECT ...
            FROM T1
            WHERE ...) AS D1
      WHERE ...) AS D2
WHERE ...;

*/

-- Зовнішній SELECT вибирає дані з другої похідної таблиці
SELECT *
FROM (
    -- Перша похідна таблиця фільтрує найдешевші продукти у кожній категорії
    SELECT CategoryID, ProductID, ProductName, UnitPrice
    FROM (
        -- Внутрішній запит додає ROW_NUMBER() для нумерації продуктів у кожній категорії
        SELECT 
            ROW_NUMBER() OVER (PARTITION BY CategoryID ORDER BY UnitPrice) AS RowNum,
            CategoryID,
            ProductID,
            ProductName,
            UnitPrice
        FROM Products
    ) AS D1
    WHERE RowNum = 1 -- Залишаємо тільки найдешевший продукт у кожній категорії
) AS D2
WHERE UnitPrice < 10.00; -- Додаткова фільтрація: вибираємо найдешевші продукти з ціною менше 10

/*
Інша проблема пов'язана з властивістю "все-одночасно" SQL. 
Усі вирази, які з'являються в одній і тій самій фазі обробки запиту, концептуально обчислюються одночасно. 
У результаті ім'я похідної таблиці не видно іншим елементам тієї ж фази.

Наприклад, якщо потрібно з'єднати кілька екземплярів однієї похідної таблиці, необхідно повторити код:

SELECT ...
FROM (SELECT ...
      FROM T1) AS D1
INNER JOIN 
     (SELECT ...
      FROM T1) AS D2
ON ...;

*/

SELECT *
FROM (
    SELECT 
        p.ProductID,
        p.ProductName,
        p.UnitPrice,
        c.CategoryID,
        c.CategoryName,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryID 
            ORDER BY p.UnitPrice ASC
        ) AS RowNum
    FROM Products p
    INNER JOIN Categories c ON p.CategoryID = c.CategoryID
) AS RankedProducts
WHERE RowNum <= 2;


/*******************************************************************************************************************************************************/

--CTE
--VIEW