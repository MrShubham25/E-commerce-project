create database assignment;
use assignment;
select count(*) from events;
select * from events;

create view v_events as
select event_time, event_type, product_id, category_id, category_code, brand, price, user_id, user_session,
substr(event_time,1,10) event_date,
substr(event_time,12,8) eventntime,
substr(event_time,21) event_timezone
from events ;

 
select * from v_events limit 100;
##1
select month(event_date)event_month , year(event_date) event_year ,round(sum(price)) monthly_sales
 from v_events group by year(event_date),month(event_date) order by sum(price)  ;
 ##2
 select user_id , (event_time) as avg_time from
 ( select user_id , event_time,lag(event_time) over (partition by user_id ) as lag_event_time from v_events) as view_;
 ##3
 select brand, count(brand) top_brand from v_events group by brand order by count(brand) desc;
 ##4
 select category_code,count(*) count_c from v_events where event_type='purchase'
 group by category_code order by count(*) desc;
 ##5
 select user_id,count(*) from v_events where event_type='purchase' group by user_id order by count(*) desc;
 ##6
 select user_id,count(*) as Purchase_time from v_event where event_type='purchase'
 group by user_id order by count(*) desc;

 