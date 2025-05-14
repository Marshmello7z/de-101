--Динамика дохода и прибыли

SELECT EXTRACT(YEAR FROM order_date) AS year,
       TO_CHAR(order_date, 'Mon') AS month_name,
       SUM(profit) AS profit_sum,
       SUM(sales) AS sales_sum
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), TO_CHAR(order_date, 'Mon'), EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);

--Продажи и прибыль по категориям

SELECT Category,
       SUM(profit) AS profit_sum,
       SUM(sales) AS sales_sum
FROM orders
GROUP BY Category;

--Региональные менеджеры(сравнение)

SELECT p.person,
       SUM(o.profit) AS profit_sum,
       SUM(o.sales) AS sales_sum
FROM orders o
JOIN people p ON o.region = p.region
GROUP BY p.person
ORDER BY profit_sum DESC;

--Сегменты покупателей

SELECT o.segment,
       SUM(o.profit) AS profit_sum,
       SUM(o.sales) AS sales_sum
FROM orders o
JOIN people p ON o.region = p.region
GROUP BY o.segment
ORDER BY profit_sum DESC;

--Динамика продаж по сегментам

SELECT EXTRACT(YEAR FROM order_date) AS year,
       SUM(CASE WHEN segment = 'Consumer' THEN sales ELSE 0 END) AS consumer_sales,
       SUM(CASE WHEN segment = 'Corporate' THEN sales ELSE 0 END) AS corporate_sales,
       SUM(CASE WHEN segment = 'Home Office' THEN sales ELSE 0 END) AS home_office_sales
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;

--Основные показатели
SELECT EXTRACT(YEAR FROM order_date) AS year,
       TO_CHAR(order_date, 'Mon') AS month_name,
       SUM(profit) AS profit_sum,
       SUM(sales) AS sales_sum,
       AVG(discount) as avg_discount,
       SUM(profit)/SUM(sales) as profit_ratio
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), TO_CHAR(order_date, 'Mon'), EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);

--По штатам

select country,state,SUM(sales)
from orders
group by country, state 
order by state;

--По регионам

select region,concat(ROUND(SUM(sales)/(select SUM(SALES) from ORDERS),2)*100,'%') as SALES_PERCERNTS_PER_REGION
from orders
group by region
order by SALES_PERCERNTS_PER_REGION;

--Суммы по возвратам
SELECT 
    COALESCE(r.returned, 'No') AS returned,
    SUM(o.sales) AS sales_sum
FROM orders o
LEFT JOIN (
    SELECT DISTINCT order_id, 'Yes' AS returned
    FROM returns
) r ON o.order_id = r.order_id
GROUP BY r.returned;














