#Query 3: Supplier Impact Stress Test
SELECT
    Region,
    AVG(CASE 
            WHEN Supplier_Status = 'On-Time' THEN Closing_Stock
        END) AS Avg_Closing_Stock_OnTime,
    AVG(CASE 
            WHEN Supplier_Status = 'Delayed' THEN Closing_Stock
        END) AS Avg_Closing_Stock_Delayed
FROM uk_supermarket_supply_cleaned
GROUP BY Region
HAVING
    AVG(CASE 
            WHEN Supplier_Status = 'On-Time' THEN Closing_Stock
        END)
    -
    AVG(CASE 
            WHEN Supplier_Status = 'Delayed' THEN Closing_Stock
        END) > 20;