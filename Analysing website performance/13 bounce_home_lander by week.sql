/* 
1 paid search non brand traffic on home and lander and over all bounce rate
*/
CREATE TEMPORARY TABLE landing_pages
SELECT ws.website_session_id, min(wp.website_pageview_id) as min_pageview,
count(wp.website_pageview_id) as count_pageview
from website_sessions ws
inner join website_pageviews wp
on ws.website_session_id = wp.website_session_id
WHERE ws.created_at BETWEEN '2012-06-01' AND '2012-08-31' and utm_campaign ='nonbrand' and  utm_source = 'gsearch'
group by ws.website_session_id;

CREATE TEMPORARY TABLE sessions_with_home_or_lander_and_bounces
select w.website_session_id, l.min_pageview, l.count_pageview, w.pageview_url, date(w.created_at) as dates
from landing_pages l
left join website_pageviews w
on l.min_pageview = w.website_pageview_id;
 
select * from sessions_with_home_or_lander_and_bounces;

select MIN(s.dates) as weeks, 
count(DISTINCT s.website_session_id) as sessions,
count(case when s.count_pageview = 1 then s.website_session_id else null end) as bounce_sessions,
count(case when s.count_pageview = 1 then s.website_session_id else null end)/count(DISTINCT s.website_session_id) as bounce_rate,
COUNT(case when s.pageview_url = '/home' then s.website_session_id else null end) as home_sessions,
COUNT(case when s.pageview_url = '/lander-1' then s.website_session_id else null end) as lander_sessions
from sessions_with_home_or_lander_and_bounces s
group by week(s.dates);

