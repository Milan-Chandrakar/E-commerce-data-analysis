-- direct and organic traffics
select year(created_at) as year , month(created_at) as month,
COUNT(case when utm_campaign = 'nonbrand' then website_session_id else null end) as nonbrand_sessions,
COUNT(case when utm_campaign = 'brand' then website_session_id else null end) as brand_sessions,
COUNT(case when utm_campaign = 'brand' then website_session_id else null end)/
COUNT(case when utm_campaign = 'nonbrand' then website_session_id else null end) as brand_percent_of_nonbrand,

COUNT(case when http_referer is null then website_session_id else null end) as direct_sessions,
COUNT(case when http_referer is null then website_session_id else null end)/
COUNT(case when utm_campaign = 'nonbrand' then website_session_id else null end) as direct_percent_of_nonbrand,
COUNT(case when http_referer is not null and utm_source is null then website_session_id else null end) as organic_sessions,
COUNT(case when http_referer is not null and utm_source is null then website_session_id else null end)/
COUNT(case when utm_campaign = 'nonbrand' then website_session_id else null end) as organic_percent_of_nonbrand

from website_sessions
where created_at <= '2012-12-23'
GROUP BY year(created_at), month(created_at)