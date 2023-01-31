-- conversion funnel for different products

-- create 2 categories pre and post prod launch
CREATE TEMPORARY table prod_page_id
select website_session_id, website_pageview_id,created_at,
case when 
	created_at between '2012-10-06' and '2013-01-06' THEN 'Pre_product_launch'
    when
    created_at between '2012-01-06' and '2013-04-06' then 'Post_product_launch'
    else 'check code'
    end as time_Peroid
from website_pageviews 
where pageview_url = '/products' and created_at between '2012-10-06' and '2013-04-06';

SELECT 
time_Peroid, COUNT(distinct p.website_session_id) as sessions,
count(distinct w.website_session_id) as went_next_page,
COUNT(distinct case when pageview_url = '/the-original-mr-fuzzy' then w.website_session_id else null end) as mr_fuzzy,
COUNT(distinct case when pageview_url = '/the-forever-love-bear' then w.website_session_id else null end) as forever

from prod_page_id p
left join website_pageviews w
on w.website_session_id = p.website_session_id
and w.website_pageview_id > p.website_pageview_id
group by time_Peroid;