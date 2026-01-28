CREATE SCHEMA IF NOT EXISTS :"schema_name";
-- this table hold the data for store detail
CREATE TABLE IF NOT EXISTS :"schema_name".forecast_store (
        Store INT,
        StoreType VARCHAR(2),
        Assortment VARCHAR(10),
        CompetitionDistance INT,
        CompetitionOpenSinceMonth INT,
        CompetitionOpenSinceYear INT,
        Promo2 VARCHAR(2),
        Promo2SinceWeek VARCHAR(50),
        Promo2SinceYear VARCHAR(10),
        PromoInterval VARCHAR(20)
);
-- this table hold the data for store and holidays
CREATE TABLE IF NOT EXISTS :"schema_name".forecast_train (
        Store INT,
        DayOfWeek INT,
        Store_Date VARCHAR(10),
        Sales INT,
        Customers INT,
        Store_Open INT,
        Promo INT,
        StateHoliday VARCHAR(2),
        SchoolHoliday INT
);

--this is test table
CREATE TABLE IF NOT EXISTS :"schema_name".forecast_test (
        Id INT,
        Store INT,
        DayOfWeek INT,
        Store_Date VARCHAR(10),
        Open INT,
        Promo INT,
        StateHoliday VARCHAR(2),
        SchoolHoliday VARCHAR(2)
);