CREATE TEMPORARY TABLE product_Seen
SELECT * 
from website_pageviews 
where pageview_url in ('/the-original-mr-fuzzy', '/the-forever-love-bear') and 
created_at between '2013-01-06' and '2013-04-10';

-- CREATE TEMPORARY TABLE pages_seen
SELECT   p.pageview_url,
count(case when w.pageview_url ='/cart' then '/cart' else null end) as cart_landed,
count(case when w.pageview_url ='/shipping' then '/shipping' else null end) as shipping_landed,
count(case when w.pageview_url ='/billing-2' then '/billing' else null end) as billing_landed,
count(case when w.pageview_url ='/thank-you-for-your-order' then '/order' else null end) as order_landed
from product_Seen p
left join website_pageviews w on
w.website_session_id = p.website_session_id
and w.website_pageview_id > p.website_pageview_id
GROUP BY pageview_url


