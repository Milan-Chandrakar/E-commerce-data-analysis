/* 
conversion_funnel : to return landing rate on each page view 

*/
select 
product_landed/lander_landed as prod_click_rate,
fuzzy_landed/product_landed as fuzzy_click_rate, 
cart_landed/fuzzy_landed as cart_click_rate, 
shipping_landed/cart_landed as shipping_click_rate, 
billing_landed/shipping_landed as billing_click_rate, 
order_landed/billing_landed as order_click_rate 


from 
(select 
count(case when p.pageview_url ='/lander-1' then '/lander-1' else null end) as lander_landed,
count(case when p.pageview_url ='/products' then '/products' else null end) as product_landed,
count(case when p.pageview_url ='/the-original-mr-fuzzy' then '/the-original-mr-fuzzy' else null end) as fuzzy_landed,
count(case when p.pageview_url ='/cart' then '/cart' else null end) as cart_landed,
count(case when p.pageview_url ='/shipping' then '/shipping' else null end) as shipping_landed,
count(case when p.pageview_url ='/billing' then '/billing' else null end) as billing_landed,
count(case when p.pageview_url ='/thank-you-for-your-order' then '/order' else null end) as order_landed

from website_sessions s
JOIN website_pageviews p 
on s.website_session_id = p.website_session_id
where s.created_at BETWEEN '2012-08-05' and '2012-09-05' and s.utm_source = 'gsearch' and s.utm_campaign = 'nonbrand'
and p.pageview_url in ('/lander-1','/products','/the-original-mr-fuzzy', 
'/cart','/shipping','/billing','/thank-you-for-your-order'))

as  landed_pages


