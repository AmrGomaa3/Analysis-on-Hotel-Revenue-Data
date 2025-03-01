USE project2;

-- Create a view with all tables --
CREATE VIEW hotels_view AS 
SELECT * FROM dbo.[2018]
UNION ALL
SELECT * FROM dbo.[2019]
UNION ALL
SELECT * FROM dbo.[2020]

SELECT * FROM hotels_view;

-- Show total stays --
SELECT stays_In_weekend_nights + stays_In_week_nights AS total_stays
FROM hotels_view;

-- Show revenue --
SELECT (stays_In_weekend_nights + stays_In_week_nights)*adr AS revenue
FROM hotels_view;

-- Show revenue by hotel and year --
SELECT arrival_date_year, hotel, SUM((stays_In_weekend_nights + stays_In_week_nights)*adr) AS revenue
FROM hotels_view
GROUP BY arrival_date_year, hotel;

-- Show revenue and meal cost and discount by year and hotel --
SELECT h.arrival_date_year AS year, h.hotel,
       ROUND(SUM((h.stays_In_weekend_nights + h.stays_In_week_nights)*h.adr), 2) AS revenue,
	   ROUND(SUM(m.Cost), 2) AS total_meal_cost,
	   ROUND(AVG(ms.Discount), 2) AS average_discount
FROM hotels_view AS h
JOIN meal_cost AS m ON m.meal = h.meal
JOIN market_segment AS ms ON ms.market_segment = h.market_segment
GROUP BY h.arrival_date_year, h.hotel;