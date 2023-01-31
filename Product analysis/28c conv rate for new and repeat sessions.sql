/* conv rate and revenue per session for repeat and new session
*/
select is_repeat_session,
count(DISTINCT w.website_session_id) as sessions,
count(distinct o.order_id)/count(DISTINCT w.website_session_id) as conv_rate,
 sum(price_usd)/ count(DISTINCT w.website_session_id) as revenue_per_session
from website_sessions w
left join orders o
on w.website_session_id = o.website_session_id
where w.created_at BETWEEN '2014-01-01' and '2014-11-08'
GROUP BY is_repeat_session;

select *
from orders