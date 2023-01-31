/*
return 1st billing 2 session
find billing and billing 2 conversion rate to orders
 - find sessions belonging to billings
 - find order converted for each billings
*/

/*
select * from website_pageviews where pageview_url ='/billing-2' order by created_at -- 1st billing 2 at '2012-09-10'
*/

select billing_version, count(distinct order_id),
count(distinct order_id)/ COUNT(DISTINCT website_session_id) as order_rate
from
(
select p.website_session_id, p.pageview_url as billing_version, o.order_id
from website_pageviews p
left join orders o
on o.website_session_id = p.website_session_id
WHERE p.created_at BETWEEN '2012-09-10' and '2012-11-10' and pageview_url in ('/billing-2', '/billing')
) as billing_order_conv
GROUP BY billing_version



