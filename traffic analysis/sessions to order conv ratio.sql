use mavenfuzzyfactory;
select utm_content, count(distinct ws.website_session_id) as sessions,
	count(distinct orders.order_id) as orders,
    count(distinct orders.order_id)/count(distinct ws.website_session_id) as sessions_to_order_conv_ratio
from website_sessions ws
left join orders
on ws.website_session_id =orders.website_session_id 
where ws.website_session_id between 1000 and 2000
group by 1
order by 4 desc