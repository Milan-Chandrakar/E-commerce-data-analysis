-- search sessions by week
select min(date(created_at)) as week_start_date,
count(distinct case when utm_source = 'gsearch' then website_session_id else null end) as gsearch_sessions,
count(distinct case when utm_source = 'bsearch' then website_session_id else null end) as bsearch_sessions
from website_sessions
where created_at BETWEEN '2012-08-22' and '2012-11-29' and utm_campaign = 'nonbrand'
GROUP BY week(created_at);

-- comparing g and b search for mobile sessions
select utm_source, COUNT(distinct website_session_id) as sessions, 
count(distinct case when device_type = 'mobile' then website_session_id else null end) as mobile_sessions,
count(distinct case when device_type = 'mobile' then website_session_id else null end)/COUNT(distinct website_session_id)
as mobile_percent
from website_sessions
where created_at BETWEEN '2012-08-22' and '2012-11-30' and utm_campaign = 'nonbrand'
GROUP BY utm_source;

-- non brand conv rate (sessions to orders) for g and bsearch and slice into device types
select device_type,
count(case when utm_source = 'gsearch' then w.website_session_id else null end) as gsearch_sessions,
count(case when utm_source = 'bsearch' then w.website_session_id else null end) as bsearch_sessions,
count(case when utm_source = 'gsearch' then order_id else null end) as gsearch_orders, 
count(case when utm_source = 'bsearch' then order_id else null end) as bsearch_orders, 
count(case when utm_source = 'gsearch' then order_id else null end)/
count(case when utm_source = 'gsearch' then w.website_session_id else null end) as gsearch_conv_rates,
count(case when utm_source = 'bsearch' then order_id else null end)/
count(case when utm_source = 'bsearch' then w.website_session_id else null end) as bsearch_conv_rates

from website_sessions w
left join orders o
on o.website_session_id = w.website_session_id
where w.created_at BETWEEN '2012-08-22' and '2012-09-18' and utm_campaign = 'nonbrand'
GROUP BY w.device_type;

-- 
select min(date(created_at)),  device_type, 
count(distinct case when utm_source = 'gsearch' then website_session_id else null end) as gsearch_sessions,
count(distinct case when utm_source = 'bsearch' then website_session_id else null end) as bsearch_sessions
from website_sessions
where created_at BETWEEN '2012-11-04' and '2012-12-22' and utm_campaign = 'nonbrand'
GROUP BY device_type, week(created_at);

