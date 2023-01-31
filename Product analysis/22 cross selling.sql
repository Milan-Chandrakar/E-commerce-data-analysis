/* 2 period 25 sept before and after
cart sessions
click through rates
avg products per order
avg order value
overall revenue per cart page view
*/
CREATE TEMPORARY table cart_sessions
SELECT pageview_url,website_session_id,website_pageview_id,
case when created_at between '2013-09-25' and '2013-10-25' then 'post-cross_sell' 
when created_at between '2013-08-25' and '2013-09-25' then 'pre-cross_sell' end as time_period
from website_pageviews
where created_at BETWEEN '2013-08-25' and '2013-10-25' and pageview_url = '/cart';

CREATE TEMPORARY TABLE after_cart
select c.website_session_id, c.website_pageview_id, p.pageview_url, c.time_period
from cart_sessions c
left join website_pageviews p
on c.website_session_id = p.website_session_id
and p.website_pageview_id > c.website_pageview_id;

select time_period,
 COUNT(DISTINCT case when pageview_url is null then website_session_id else null end) as clicked_through,
 COUNT(DISTINCT website_session_id) as cart_sessions,
 COUNT(DISTINCT case when pageview_url is null then website_session_id else null end) /
 COUNT(DISTINCT website_session_id) as click_through_rates
 from after_cart
 group by time_period;
 
 select c.time_period, avg(o.items_purchased) as avg_products_per_order
 from cart_sessions c
 left join orders o
 on c.website_session_id = o.website_session_id
 group by c.time_period;
 
 select * from orders;
 select c.time_period, avg(price_usd) as avg_order_values
 from cart_sessions c
 left join orders o
 on c.website_session_id = o.website_session_id
 group by c.time_period;
 
 select c.time_period, sum(price_usd) as total_revenue,
 sum(price_usd)/COUNT(DISTINCT c.website_session_id) as revenue_per_cart_view
 from cart_sessions c
 left join orders o
 on c.website_session_id = o.website_session_id
 group by c.time_period;
 
 