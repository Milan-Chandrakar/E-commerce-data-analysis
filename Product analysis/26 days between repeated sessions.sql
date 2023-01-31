CREATE TEMPORARY table two_session

SELECT case when two_session_users = 2 then user_id end as user_id
from (
SELECT user_id, count(website_session_id) as two_session_users
from website_sessions
where created_at BETWEEN '2014-01-01' and '2014-11-01'  
GROUP BY user_id
) as two_sessions;

CREATE TEMPORARY table session_dates
select t.user_id,min(w.created_at) as 1sT_session, max(w.created_at) as 2nd_session
from two_session t
left join website_sessions w
on t.user_id = w.user_id
where created_at BETWEEN '2014-01-01' and '2014-11-01'
GROUP BY t.user_id;

select avg(datediff(2nd_session,1st_session)),max(datediff(2nd_session,1st_session)),min(datediff(2nd_session,1st_session))
from session_dates
