-- SQL For Week1 homework

--3. Taxi Trips on 15th Jan
select count(*)   
from yellow_taxi_trips 
where cast(tpep_pickup_datetime as date) ='2021-01-15';

--4. Largest Tip each day
select 
cast(tpep_pickup_datetime as date) as pickup_date,
max(tip_amount) as largest_tip
from yellow_taxi_trips
group by 1
order by 2 desc;


-- 5. Most Popular Destination
select
zd."Zone" as drop_off_zone,
count(*) as num_journeys
from yellow_taxi_trips t1
left join zones zp
on t1."PULocationID" = zp."LocationID"
left join zones zd
on t1."DOLocationID" = zd."LocationID"
WHERE zp."Zone" = 'Central Park'
and cast(tpep_pickup_datetime as date) ='2021-01-14'
group by 1
order by 2 desc;

--6  6: Most expensive route *
--What's the pickup-dropoff pair with the largest average price for a ride
--(calculated based on total_amount)? 

select
COALESCE(zp."Zone",'Unknown') as pickup_zone,
COALESCE(zd."Zone",'Unknown') as drop_off_zone,
AVG("total_amount") as avg_amt
from yellow_taxi_trips t1
left join zones zp
on t1."PULocationID" = zp."LocationID"
left join zones zd
on t1."DOLocationID" = zd."LocationID"
group by 1,2
order by 3 desc