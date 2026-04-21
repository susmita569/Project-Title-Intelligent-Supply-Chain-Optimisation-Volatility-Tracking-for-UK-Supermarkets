SELECT
    t1.Date,
    t1.Store_ID,
    t1.Region,
    SUM(t1.Daily_Sales) AS Total_Daily_Sales
FROM uk_supermarket_supply_cleaned t1
WHERE t1.Supplier_Status = 'Cancelled'
GROUP BY t1.Date, t1.Store_ID, t1.Region
HAVING SUM(t1.Daily_Sales) > (
    SELECT AVG(t2.Daily_Sales)
    FROM uk_supermarket_supply_cleaned t2
    WHERE t2.Region = t1.Region
);