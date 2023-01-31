/* 1) find the 1st page view for each session	
   2) find the url for that page view */

CREATE TEMPORARY TABLE entry_pages
SELECT MIN(website_pageview_id) as entry_id,website_session_id
FROM website_pageviews
where created_at < '2012-06-09'
GROUP BY website_session_id;

SELECT pageview_url, COUNT(DISTINCT w.website_session_id) as sessions_entry_page
FROM entry_pages e 
left join website_pageviews w
on e.entry_id = w.website_pageview_id
WHERE created_at < '2012-06-09'
GROUP BY w.pageview_url
order by COUNT(DISTINCT w.website_session_id)