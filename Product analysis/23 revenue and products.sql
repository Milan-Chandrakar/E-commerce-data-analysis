create TEMPORARY table test_sessions
SELECT website_session_id, created_at,
case when created_at between '2013-12-12' and '2014-01-12' then 'post-cross_sell' 
when created_at between '2013-11-12' and '2013-12-12' then 'pre-cross_sell' end as time_period
from website_sessions
where created_at BETWEEN '2013-11-12' and '2014-01-12' ;


select time_period,count(DISTINCT t.website_session_id) as sessions,
count(distinct o.order_id) as orders,
count(distinct o.order_id)/count(DISTINCT t.website_session_id) as sessions_to_order_conv_rate
from test_sessions t
left join orders o
on t.website_session_id = o.website_session_id
GROUP BY time_period;


 select t.time_period, avg(price_usd) as avg_order_values
 from test_sessions t
 left join orders o
 on t.website_session_id = o.website_session_id
 group by t.time_period;
 
 select t.time_period, avg(o.items_purchased) as avg_products_per_order
 from test_sessions t
 left join orders o
 on t.website_session_id = o.website_session_id
 group by t.time_period;
 
 select t.time_period, sum(price_usd) as total_revenue,
 sum(price_usd)/COUNT(DISTINCT t.website_session_id) as revenue_per_session
 from test_sessions t
 left join orders o
 on t.website_session_id = o.website_session_id
 group by t.time_period;