SELECT min(DATE(created_at)) as week_start_date, 
COUNT(CASE WHEN device_type ='desktop' THEN website_session_id ELSE NULL End) as desktop_sessions,
COUNT(CASE WHEN device_type ='mobile' THEN website_session_id ELSE NULL End) as mobile_sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-04-15' AND '2012-06-09' and utm_campaign = 'nonbrand' and 
utm_source= 'gsearch'
GROUP BY week(created_at)