--creating summarized for UI
CREATE TABLE IF NOT EXISTS :"schema_name".daily_sales_storeType AS 
WITH forecast_trainstore_map AS (
SELECT
    t.Store,
    t.DayOfWeek,
    t.Store_Date,
    t.Sales,
    t.Customers,
    t.Store_Open,
    t.Promo,
    t.StateHoliday,
    t.SchoolHoliday,
    s.StoreType,
    s.Assortment,
    s.CompetitionDistance,
    s.CompetitionOpenSinceMonth,
    s.CompetitionOpenSinceYear,
    s.Promo2,
    s.Promo2SinceWeek,
    s.Promo2SinceYear,
    s.PromoInterval
FROM :"schema_name".forecast_train t
INNER JOIN :"schema_name".forecast_store s
ON t.Store = s.Store
)

SELECT
    StoreType,
    Store_Date,
    SUM(Sales) AS Total_Sales
FROM forecast_trainstore_map
GROUP BY StoreType,Store_Date
ORDER BY Store_Date;