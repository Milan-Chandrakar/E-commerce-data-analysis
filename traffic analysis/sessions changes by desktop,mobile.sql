SELECT device_type, COUNT(DISTINCT ws.website_session_id) as sessions, COUNT(o.order_id) as orders,
COUNT(o.order_id)/COUNT(DISTINCT ws.website_session_id) as conv_rate
FROM website_sessions ws
left join orders o on ws.website_session_id = o.website_session_id
WHERE ws.created_at <'2012-05-11'
GROUP BY 1