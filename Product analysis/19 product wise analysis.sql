-- revenue and margin
SELECT year(created_at) as year, month(created_at) as month,
COUNT(DISTINCT order_id) as number_of_sales,
sum(price_usd) as revenue,
sum(price_usd -cogs_usd) as margin
from orders
where created_at <= '2013-01-04'
GROUP BY year(created_at), month(created_at);

-- product wise ANALYZE
SELECT year(w.created_at) as year, month(w.created_at) as month,
COUNT(DISTINCT order_id) as monthly_order_volume,
COUNT(DISTINCT order_id)/count(distinct w.website_session_id) as conv_rates,
sum(price_usd) /count(distinct w.website_session_id) as revenue_per_session,
sum(case when primary_product_id =1 then items_purchased end) as 1st_product,
sum(case when primary_product_id =2 then items_purchased end) as 2nd_product

from website_sessions w
left join orders o
on o.website_session_id = w.website_session_id

where w.created_at between '2012-04-01' and '2013-04-05'
GROUP BY year(w.created_at), month(w.created_at)