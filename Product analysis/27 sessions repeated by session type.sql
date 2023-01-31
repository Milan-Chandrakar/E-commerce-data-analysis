-- sessions repeated by type of sessions
select channel_group,
count(case when is_repeat_session =0 then website_session_id end) as new_sessions,
count(case when is_repeat_session =1 then website_session_id end) as repeated_sessions
from
(
select website_session_id,is_repeat_session,user_id,created_at,
case
 when http_referer is null then 'direct_sessions' 
 when http_referer is not null and utm_source is null then 'organic_sessions'
 when utm_campaign = 'nonbrand' and utm_source is not null then 'Paid_nonbrand_sessions'
 when utm_campaign = 'brand' and utm_source is not null then 'Paid_brand_sessions'
 when utm_campaign is not null and utm_source = 'socialbook' then 'Paid_social_sessions' 
 end as channel_group
from website_sessions
where created_at BETWEEN '2014-01-01' and '2014-11-01'
) as channel_sessions
GROUP BY channel_group

