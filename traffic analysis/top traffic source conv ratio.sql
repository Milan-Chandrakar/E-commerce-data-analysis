select count(distinct ws.website_session_id) as sessions, count(distinct o.order_id) as orders, 
count(distinct o.order_id)/count(distinct ws.website_session_id) as conversion_ratio
from website_sessions ws
left join orders o on ws.website_session_id= o.website_session_id
where ws.created_at < '2012-04-12' and utm_source ='gsearch' and utm_campaign ='nonbrand'
