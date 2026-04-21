SELECT
    Store_ID,
    COUNT(CASE 
              WHEN Stock_Status = 'Critical' THEN 1
          END) AS Total_Critical_Labels,
    SUM(CASE 
            WHEN Stock_Status = 'Critical'
             AND (Opening_Stock + Deliveries - Daily_Sales) >= 150 THEN 1
            ELSE 0
        END) AS False_Alarms,
    ROUND(
        SUM(CASE 
                WHEN Stock_Status = 'Critical'
                 AND (Opening_Stock + Deliveries - Daily_Sales) >= 150 THEN 1
                ELSE 0
            END) * 100.0
        /
        COUNT(CASE 
                  WHEN Stock_Status = 'Critical' THEN 1
              END),
        2
    ) AS False_Alarm_Percentage
FROM uk_supermarket_supply_cleaned
GROUP BY Store_ID
HAVING COUNT(CASE 
                 WHEN Stock_Status = 'Critical' THEN 1
             END) > 0
ORDER BY False_Alarm_Percentage DESC;