/* weekly and monthly trends == seasonality of business
*/
SELECT year(w.created_at) as year,month(w.created_at) as month, count(w.website_session_id) as sessions
,COUNT(o.order_id) as orders
from website_sessions w
left join orders o on
o.website_session_id = w.website_session_id
where w.created_at <= '2012-12-31'
GROUP BY year(w.created_at),month(w.created_at);

-- hourly and weekday analysis

select hours,
AVG(case when weeks = 0 then sessions end) as mon,
avg(case when weeks = 1 then sessions end) as tues,
avg(case when weeks = 2 then sessions end) as wed,
avg(case when weeks = 3 then sessions end) as thurs,
avg(case when weeks = 4 then sessions end) as fri,
avg(case when weeks = 5 then sessions end) as sat,
avg(case when weeks = 6 then sessions end) as sun
from (
SELECT date(created_at),weekday(created_at) as weeks, hour(created_at) as hours, count(website_session_id) as sessions
/*
count(case when weekday(created_at) = 0 then w.website_session_id end) as mon,
count(case when weekday(created_at) = 1 then w.website_session_id end) as tues,
count(case when weekday(created_at) = 2 then w.website_session_id end) as wed,
count(case when weekday(created_at) = 3 then w.website_session_id end) as thurs,
count(case when weekday(created_at) = 4 then w.website_session_id end) as fri,
count(case when weekday(created_at) = 5 then w.website_session_id end) as sat,
count(case when weekday(created_at) = 6 then w.website_session_id end) as sun
*/
from website_sessions w
where w.created_at between '2012-09-15' and '2012-11-15'
GROUP BY 1,2,3
) as hour_sessions
GROUP BY hours
