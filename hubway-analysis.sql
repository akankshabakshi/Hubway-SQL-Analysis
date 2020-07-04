---our dataset has two tables - trips and stations

select * from trips
select * from stations
----1. What was the duration of the longest trip? 

----To check values in duration column in trip table
select duration from trips limit 5;

----answer
select duration from trips 
order by duration desc limit 1; 

----other way of answering
select max(duration) from trips;

-----2.How many trips were taken by registered users?

----view tables having type of users
select * from trips limit 5;

---So, with this query it concludes that we can use sub_type as registered users

--view types of subtype
select distinct sub_type from trips; 

---Answer draft 
select count(*) from trips
where sub_type = 'Registered';
---1105192

---other answer
select count(distinct id) from trips
where sub_type = 'Registered';
---1105192

------3.What was the average trip duration?
select avg(duration) as "Average Duration" from trips;

select sub_type, avg(duration) as "Average Duration" from trips
group by sub_type; 

----for casual user - 1519/60 = 25 minutes 31 seconds
----for registered users - 657/60 = 10 minutes 95 seconds
-----Thats quite a difference! On average, registered users take trips that last around 11 minutes whereas casual users are spending almost 25 minutes per ride. 

---lets look into one more question - which sub_type is taking more trips?

select sub_type, count(distinct id) from trips; ----of registered users, 1570001
----lets confirm that the most trips are taken by registered sub_type only or not?

select count(distinct id) from trips where sub_type = 'Casual';  ---which is - 464809 less than Registered

----So, registered users are likely taking shorter, more frequent trips, possibly as part of their commute to work. Casual users, on the other hand, are spending around twice as long per trip 

---It is possible that casual users tend to come from demographics(tourists, for eg) that are more inclined to take longer trips make sure they get around and see all sights

----Which bike was used for the most trips?

---view all data
select * from trips;

---answer draft 
select bike_number, count(*) from trips
group by bike_number
order by count(*) desc limit 1; 

----5.  What is the average duration of trips by users over the age of 30? 
select avg(duration) from trips
where (2017-birth_date)>30;

---which station is the most frequently used for round trips? 
select stations.station, count(*) as "count"
from trips inner join stations
on trips.start_station = stations.id
where trips.start_station = trips.end_station
group by stations.station
order by count(*) desc
limit 5;

----how many trips start and end in different municipality

select count(trips.id) as count FROM
trips inner join stations as start 
on trips.start_station = start.id
inner join stations as end
on trips.end_station = end.id
where start.municipality <> end.municipality;







