select no_of_repeated_sessions,
count(case when no_of_repeated_sessions = 0 then '1'end) as zero,
count(case when no_of_repeated_sessions = 1 then '1'end) as one,
count(case when no_of_repeated_sessions = 2 then '1'end) as two,
count(case when no_of_repeated_sessions = 3 then '1'end) as 
from (
select user_id,(count(website_session_id)-1) as no_of_repeated_sessions
from website_sessions
where created_at BETWEEN '2014-01-01' and '2014-11-01'
GROUP BY user_id
) as no_of_repeated_session
group by no_of_repeated_sessions