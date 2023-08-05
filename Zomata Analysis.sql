Use zomato;
-- To View all the data in the table
select * from zomatodata;

describe zomatodata;

-- Business Problems

-- 1.Identify the top 3 cities with restaurants having the least ratings,count the number of restaurants in each city and order by number of restaurants 

SELECT City,COUNT(RestaurantName) AS Restaurant_Count ,Rating
FROM zomatodata
WHERE Rating = (SELECT MIN(Rating) FROM zomatodata)
GROUP BY City
ORDER BY Restaurant_Count DESC
LIMIT 3;

-- 2.Find the top 3 restaurants in Kolkata which provides online delivery

SELECT RestaurantName,Rating
FROM zomatodata
WHERE City = "Kolkata" AND Has_Online_delivery = "Yes" 
ORDER BY Rating Desc
LIMIT 3;

-- 3. Find the best rated restaurant for pizza in New Delhi

SELECT RestaurantName,Rating
FROM zomatodata
WHERE City = "New Delhi" AND Cuisines LIKE "%Pizza%" 
ORDER BY Rating Desc
LIMIT 1;

-- 4. Select top 5 cities with most restaurants linked with zomato

SELECT City,COUNT(RestaurantName) AS Restaurant_Count
FROM zomatodata
GROUP BY City 
ORDER BY Restaurant_Count DESC
LIMIT 5;

-- 5.Enlist most affordable and highly rated restaurants city wise

SELECT City, RestaurantName, Rating, Average_Cost_for_two
FROM zomatodata
WHERE Average_Cost_for_two = (SELECT MIN(Average_Cost_for_two) FROM zomatodata)
AND Rating = (SELECT MAX(Rating) FROM zomatodata ) 
ORDER BY City;

-- 6.What is the average rating of restaurants in each city?

SELECT City, ROUND(AVG(Rating),1) as Average_Rating
FROM zomatodata
GROUP BY City;

-- 7.Which cities have the highest number of restaurants with online delivery?

SELECT City, COUNT(*) as Online_Delivery_Count
FROM zomatodata
WHERE Has_Online_delivery = 'Yes'
GROUP BY City
ORDER BY Online_Delivery_Count DESC;

-- 8.Generate a report that shows the top-rated restaurants in each city:

SELECT City, RestaurantName, MAX(Rating) as Top_Rating
FROM zomatodata
GROUP BY City;

-- 9.What is the average rating of restaurants that offer online delivery?

SELECT City,ROUND(AVG(Rating),1) as Average_Rating
FROM zomatodata
WHERE Has_Online_delivery = 'Yes'
GROUP BY City;

-- 10.Which cities have the most restaurants with table booking?

SELECT City, COUNT(*) as Table_Booking_Count
FROM zomatodata
WHERE Has_Table_booking = 'Yes'
GROUP BY City
ORDER BY Table_Booking_Count DESC;

-- 11.Identify cities which have atleast 3 restaurants with ratings >= 4.8 and incase of two cities with same result sort them in alphabetical order

SELECT City
FROM zomatodata
WHERE Rating >= 4.8
GROUP BY City
HAVING COUNT(*) >= 3
ORDER BY COUNT(*) DESC, City;

-- 12.Group the restaurants based on the average cost for two into: Very expensive,expensive,high,medium,average.Then find the number of restaurants in each category

SELECT 
    CASE
        WHEN Average_Cost_for_two > 2000 THEN 'Very expensive'
        WHEN Average_Cost_for_two > 1500 THEN 'Expensive'
        WHEN Average_Cost_for_two > 1000 THEN 'High'
        WHEN Average_Cost_for_two > 500 THEN 'Medium'
        ELSE 'Average'
    END as Cost_Category,
    COUNT(*) as Restaurant_Count
FROM zomatodata
GROUP BY Cost_Category
ORDER BY Restaurant_Count ;

