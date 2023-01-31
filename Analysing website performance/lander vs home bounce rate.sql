/* 
1 find the 1st instance of /lander-1 to set analysis timeframe 
2 find out bounce rate 
	for home page and lander page in between 2012-06-19 and 2012-07-28
*/

SELECT created_at
from website_pageviews
where pageview_url = '/lander-1'
order by created_at;-- we get lander-1 date start at 2012-06-19;	

CREATE TEMPORARY TABLE entry_pages
SELECT  MIN(wp.website_pageview_id) as entry_page, wp.website_session_id
FROM website_pageviews wp
INNER join website_sessions ws on
ws.website_session_id = wp.website_session_id
and ws.created_at between '2012-06-19' and '2012-07-28'
and utm_campaign = 'nonbrand' and utm_source = 'gsearch'
GROUP BY website_session_id;


CREATE TEMPORARY table needed_landing_sessions
SELECT w.website_session_id, pageview_url
from entry_pages e
left join website_pageviews w
on w.website_pageview_id = e.entry_page
where pageview_url in ('/home','/lander-1');


CREATE TEMPORARY TABLE bounced_session
SELECT w.website_session_id ,n.pageview_url, COUNT(w.website_pageview_id) as pages_per_session
FROM needed_landing_sessions n
left join website_pageviews w
on n.website_session_id = w.website_session_id	
GROUP BY w.website_session_id, n.pageview_url
HAVING COUNT(w.website_pageview_id)= 1;

SELECT  n.pageview_url,count(DISTINCT n.website_session_id) as sessions, 
count(distinct b.website_session_id) as bounced_sessions, 
count(distinct b.website_session_id)/ count(DISTINCT n.website_session_id) as bounce_rate
FROM needed_landing_sessions n
left join bounced_session b on
n.website_session_id = b.website_session_id
group by n.pageview_url;

