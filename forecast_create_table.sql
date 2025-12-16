CREATE TABLE IF NOT EXISTS "alloydb_demo"."forecast_store" (
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

CREATE TABLE IF NOT EXISTS "alloydb_demo"."forecast_train" (
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


CREATE TABLE IF NOT EXISTS "alloydb_demo"."forecast_test" (
        Id INT,
        Store INT,
                DayOfWeek INT,
        Store_Date VARCHAR(10),
        Open INT,
        Promo INT,
        StateHoliday VARCHAR(2),
        SchoolHoliday VARCHAR(2)
);