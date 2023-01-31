/* refund rates for various products */
CREATE TEMPORARY table product_wise_orders
select created_at,order_id,
CASE when i.product_id = 1 then i.order_id else null end as prod_1,
CASE when i.product_id = 2 then i.order_id else null end as prod_2,
CASE when i.product_id = 3 then i.order_id else null end as prod_3,
CASE when i.product_id = 4 then i.order_id else null end as prod_4
from order_items i
where i.created_at < '2014-10-15';

select year(i.created_at) as year,month(i.created_at) as month,
count(distinct prod_1) as prod_1_orders,
count(case when r.order_id = prod_1 then r.order_id else null end)/count(distinct prod_1) 
 as prod_1_refund_rate,
count(distinct prod_2) as prod_2_orders, 
count(case when r.order_id = prod_2 then r.order_id else null end)/count(distinct prod_2)
 as prod_2_refund_rate,
 count(distinct prod_3) as prod_3_orders,
count(case when r.order_id = prod_3 then r.order_id else null end) /count(distinct prod_3) 
as prod_3_refund_rate,
count(distinct prod_4) as prod_4_orders,
count(case when r.order_id = prod_4 then r.order_id else null end)/count(distinct prod_4) 
 as prod_4_refund_rate

from product_wise_orders i
left join order_item_refunds r
on i.order_id = r.order_id
GROUP BY year(i.created_at),month(i.created_at);

select * from order_item_refunds
