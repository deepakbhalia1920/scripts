CREATE SCHEMA IF NOT EXISTS cloudsql_demo;
CREATE TABLE IF NOT EXISTS cloudsql_demo.fashion_products (
    id INT PRIMARY KEY,
    gender TEXT,
    masterCategory TEXT,
    subCategory TEXT,
    articleType TEXT,
    baseColour TEXT,
    season TEXT,
    year INT,
    usage TEXT,
    productDisplayName TEXT,
    link TEXT,
    unitPrice NUMERIC(10,2),
    discount INT,
    finalPrice NUMERIC(10,2),
    rating NUMERIC(3,1),
    stockCode VARCHAR(20),
    stockStatus TEXT
);