/* steps 
1 find entry page (pageView_id) for each session
2 find url for that page
3 find total number of sessions for that entry page
4 if that number =1, then it is a bounce
5 count total number of bounce sessions
6 find the bounce rate */


CREATE TEMPORARY TABLE entry_pages
SELECT MIN(website_pageview_id) as entry_page,website_session_id
FROM website_pageviews
where created_at < '2012-06-14'
GROUP BY website_session_id;

CREATE TEMPORARY TABLE sessions_with_home_landing_page
SELECT e.website_session_id, w.pageview_url as landing_page
from entry_pages e
left join website_pageviews w on e.entry_page = w.website_pageview_id
where w.pageview_url = '/home';

CREATE TEMPORARY TABLE pages_per_session
SELECT w.website_session_id, COUNT(w.website_session_id) as pages_in_each_session
FROM sessions_with_home_landing_page s
LEFT JOIN website_pageviews w
on s.website_session_id = w.website_session_id
GROUP BY w.website_session_id;

SELECT COUNT(website_session_id) as sessions, COUNT(case when pages_in_each_session = 1 then 'bounce' else null end) as bounce,
COUNT(case when pages_in_each_session = 1 then 'bounce' else null end)/COUNT(website_session_id) as bounce_rate
from pages_per_session



 

