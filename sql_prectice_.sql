# Basic comands
select * from sales;
select SaleDate, Amount, Customers from sales;

# Adding a new calculative column  as "Amount per box"
select  SaleDate, Amount, Amount/Boxes from sales;
select  SaleDate, Amount, Amount/Boxes 'Amount per box' from sales;

# Using where clause to get data for only amount greter then 1000
select * from sales
where amount>10000
order by amount ;

# Using order by clause to get data sort in assending order by defoult
select * from sales
where amount>10000
order by amount ;

# multiple conditions
select * from sales
where GeoID='g1' #  showing data only for the GeoID = G1
order by PID, Amount desc;# here PID is in asseding but amount is in decending order

# gettin data where amount >1000 and year =2022
select * from sales
where amount>10000 and  SaleDate>='2022-01-01';

# but this kind of date comparision is not work when we have data of 2023/2024 etc
select amount,saledate from  sales
where amount>10000 and year(SaleDate)=2022;# year is the inbuit function in sql return year of the data

# using between key word
select * from sales
where boxes between 0 and  50;    
# OR
select * from sales
where boxes> 0 and boxes<= 50;  

# get data when shipment is at friday
select amount, saledate, boxes , weekday(saledate) as 'day of week' from sales
where weekday(saledate)=4 ; #weekday(saledate) return the number for all days in week like 0,6

# using multiple tables

select * from people
where team ='Delish' or team='jucies'; # o logical or 

# when we have to mentioned more then 2 teams then using logical or becomes hactic
# in that case we uses the in clause

select * from people 
where team in ('delish','jucies');

# concepts of pattern matching using like operator
select * from people
where salesperson like 'B%'; # this return all salesperson names start with B 

select * from people
where salesperson like '%B%'; # this return all salesperson names where B is any where

# lets try some use cases of 'CASE' operator
# here i just want to add some of the labels like limit of amount kind of
select saledate, amount,
		case when amount<1000 then 'under 1k'
			when amount<5000 then 'under 5k'
            when amount<10000 then 'under 10k'
        else '10k or more'
        end as 'amount category' # this "end " keyword just end the case struture
from sales;        

# lets understand the concepts of joins

# this is full join
select * 
from people as p   #that table written in front of from comes on left hand side in output
 join sales as s
on p.SPID=s.SPID;
           #or
 select s.saledate, s.amount, p.salesperson  # we can also demand for the specific columns
 from people as p
 join sales as s
 on p.spid=s.spid;
 
 # left join in this join the data of left side table is preserved
 select  s.saledate,s.amount,p.product
 from sales as s
 left join products as p  #significance of left join is is there is a case where there is no matche for s.pid and p.pid 
                           #then also data from sales table comes and respective product column will be blank
 on s.pid=p.pid;
 
 #we can also join multiple tables through join
 select  s.saledate,s.amount,p.Salesperson,pr.Product
 from sales as s
 join people as p on s.spid=p.spid # note in case of joining more than 2 table trough join 
                                   #try to write bothe of the join and on satement in same line
 join products as pr on s.pid=pr.pid;
 
 # adding as aditional condition with the join
 select  s.saledate,s.amount,p.Salesperson,pr.Product,p.team
 from sales as s
 join people as p on s.spid=p.spid # note in case of joining more than 2 table trough join 
                                   #try to write bothe of the join and on satement in same line
 join products as pr on s.pid=pr.pid
 where s.amount>500# her we just add a where condition
 and p.team ='Delish'; # multiple conditions using single where clause
 
 # lets try to find the data where team have blank or no data 
 select  s.saledate,s.amount,p.Salesperson,pr.Product,p.team,g.region
 from sales as s
 join people as p on s.spid=p.spid # note in case of joining more than 2 table trough join 
                                   #try to write bothe of the join and on satement in same line
 join products as pr on s.pid=pr.pid
 join geo as g on g.GeoID=s.GeoID
 where s.amount>500# her we just add a where condition
 and p.team =''# this just give data having team is blank
 order by s.saledate;
 
 # lets try most important topic "group by" and "aggregation"
 # note = group by helps us to create a report like pivot table
 select geoid,sum(amount)# this just return the sum on amount respective to all the ids
 from sales
 group by geoid;
 
 # find average of amount respect to different "geoid" 
 select geoid,avg(amount)# this just return the average  of amount respective to all the ids
 from sales
 group by geoid;
 
 # lets  try combine use join and groupby
 select g.geo, sum(amount), avg(amount), sum(boxes)
 from sales as s
 join geo as g on s.geoid=g.geoid    # this join help us to get the geographical location in our data respective to amount 
 group by g.geo;
 
 # lets suppose i want to know product category respect to the team and sum of amonut and sum of boxes
 select pr.category,p.team,sum(amount),sum(boxes),avg(amount)
 from sales as s
 join people as p  on p.spid=s.spid
 join products as pr on pr.pid=s.pid
 group by pr.category,p.team; # this arrange the data according to the category and team
 
 #lets find top 10 product according too total amount
 select sum(s.amount) as 'total amount',pr.product
 from sales as s
 join products as pr on s.pid=pr.pid
 group by pr.product
 order by 'total amount' desc
 limit 10;
 
 
 
 
 
 
 
 
 
 










           

