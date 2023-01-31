select pageview_url, count(distinct website_session_id) as sessions
from website_pageviews
group by pageview_url
order by sessions desc