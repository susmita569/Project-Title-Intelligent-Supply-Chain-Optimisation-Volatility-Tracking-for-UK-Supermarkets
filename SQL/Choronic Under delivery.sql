SELECT 
    Store_ID,
    Category,
    SUM(Deliveries) AS Total_Deliveries,
    SUM(Daily_Sales) AS Total_Sales,
    1.0 * SUM(CASE 
        WHEN Supplier_Status IN ('Delayed','Cancelled') THEN 1 
        ELSE 0 
    END) / COUNT(*) AS Failure_Rate
FROM uk_supermarket_supply_cleaned
GROUP BY Store_ID, Category
HAVING 
    SUM(Deliveries) < 0.5 * SUM(Daily_Sales)
    AND 
    1.0 * SUM(CASE 
        WHEN Supplier_Status IN ('Delayed','Cancelled') THEN 1 
        ELSE 0 
    END) / COUNT(*) > 0.2;