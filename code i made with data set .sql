SELECT CONCAT_WS('this  ', first_name, " _ " "is ",last_name)
FROM Customers;





use sql_store;
select *
from order_items
where order_id = 6 
and 
(quantity * unit_price > 30)

-- list of people with the first name elka or ambur 
SELECT *
FROM customers 
WHERE first_name regexp 'elka|ambur' ;
  
-- list of people wihere there last name ends with ey or on 
SELECT *
FROM customers 
WHERE last_name regexp 'ey$|on'; 

-- list of last names where begging starts with my or has se 


SELECT *
FROM customers 
WHERE last_name regexp '^my|se';

-- list of customers that have r s or e in there name shippers

SELECT *
FROM customers 
WHERE last_name regexp 'r|s|e'; 



--- combines the orders and customers tables and cuustomer id 


select c.customer_id, c.first_name, o.order_id
from customers  c
left join orders  o
on c.customer_id = o.customer_id
order by c.customer_id;

-- combine tables by the 'using' function 1/17 - columns must match excatly to the column in the orders table 
---- left outterjoins shows all customer despite if the have orders or not 
use sql_store;
select c.customer_id, c.first_name, sh.shipper_id
from customers as c 
left join orders as o
using(customer_id)
join shippers as sh
using (shipper_id)
where shipper_id not in(1,3)



;

---- the union function to combine rows 

select birth_date
from customers 
union 
select name
from shippers; 


--- a way to insert info into a row given that you know what order the columns are in  
	INSERT INTO customers
    values
    ( default,
    'john',
    'smith',
    '1990-01-01',
    null,
    '1444',
    'Atl',
    'GA',
    default);
    
    -- insert row into a table 
    INSERT INTO customers
    (first_name, last_name, birth_date, 
    address, city, state)
    values 
  ('Adrian', 'Cosgrove', '1990-01-01',  'address', 'city', 'Ca');
  
  
  -- insert info into product table 
  insert into products 
  (name, quantity_in_stock, unit_price)
  values ('craig', '6', '18');
  
  ---- insert new records into the prodcuts table 
   insert into products 
  (name, quantity_in_stock, unit_price)
  values ('mike', '17', '.6'),
     ('tim', '26', '.88'),
     ('Billy', '19', '.50');
     use sql_store;


----
-- updating info to a single row 
update invoices
set payment_total = 10,
payment_date = '2019-03-01'
where invoice_id = 3;

select*
from invoices;

--inserts a hiechery row 

insert into orders
(customer_id, order_date, status)
values (9, '2019-01-02', 7);
insert into order_items
values 
(last_insert_id() , 8, 9, 2.95),
(last_insert_id() , 29, 6, 6.55);

--- creates a table called ace using all the info from the order table 

use sql_store ;
create table ace as 
select *
from orders;




---- after I have truncated all the data from the ace table

-- insert all data from the orders table into a table called ace 

insert into ace 
select 
*
from orders 
where order_date < '2019-01-01';


select * 
from 

select* 
from ace;

--- joins two tables then creates a table using that info 
use sql_invoicing;

create table invoice_bro as
select
 i.number, i.client_id, 
i.invoice_total, i.payment_total,
i.invoice_date, i.payment_date, i.due_date,
c.name 
from invoices as i
join clients as c
using (client_id)
where i.payment_date is not null; 





 select client_id, name,
 (select sum(invoice_total)
 from invoices 
 where client_id = c.client_id) as total_sales
 ( SELECT AVG (invoice_total)
 
 ( SELECT AVG(invoice_total)
 from invoices) as avg
 (select total_sales - avg) as differenece
 from clients as c 




---- updates payment and due date for invoice #1 row 
use sql_invoicing;

update invoices 
set Payment_total = 77,
payment_date = null 
where invoice_id = 1 ;


select* 
from invoices ;

---- updates single rows in the invoice ables and inserts data (50% of invoice total
update invoices 
set 
payment_total = 
invoice_total * .05,
 payment_date = due_date
where invoice_id = 1;


----- sets a new payment total and payment date for client id not  3 or 4 
use sql_invoicing; 
update invoices 
set 
payment_total = 
invoice_total * .60, 
payment_date = due_date
where not client_id in (3,5);





--- updates a table using a subquery method 
use sql_invoicing; 
update invoices 
set 
payment_total = 
invoice_total * .60, 
payment_date = due_date
where not client_id =
(select client_id
from clients
where name = 'myworks');

use sql_invoicing;
update invoices 
set 
payment_total = 
invoice_total * .60, 
payment_date = due_date
where client_id in
(select client_id
from clients
where state in('Ca','ny'));

select *
from invoices as i
join clients as c 
using (client_id)
where c.state in('ca', 'ny') and c.client_id = 1




--- when ever you are updating multiple different people at the same time you hvae to use the in clause 
--- this sets the comments to gold members using a subquery. gold members have more than 3k points and the points are located in the customer table 
----- when a sub query returns mulitple records you must you the IN operator 
use sql_store;

update orders 
set comments = 'gold member'
where customer_id
in
(select customer_id
from customers
where points > 3000);

-- deletes all records for every one with a gold memeber comment
delete 
 from orders
where comments = 'gold memeber'


where comments = 'gold member')



-- give all customers born before 1990 50 extra points
use sql_store;
update customers
set points = 
points + 50
where birth_date < '1990-01-01';




select comments 
from orders


select *
from invoices;


select * 
from invoices 
where client_id in (3,5,1)
order by client_id desc

use sql_store ;







select 'first half of 2019' as 
dange_range;

use sql_invoicing;

select invoice_date, due_date, payment_date 
from invoices;

use sql_invoicing;

----- shows the date total sales for the first half of 2019, the 2nd half of 2019 and the total for the year
------ also shows what should be expected which is the invoice toal minus the payment total 
----- also makes a column called date range and inside of the columns is data that i entered  with txt that i've created 

select 'first half of 2019' as date_range, 
sum(invoice_total) as total_sales, 
sum(payment_total) as total_payment,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-01-01' and '2019-06-29'
        union 
select '2nd half of 2019' as date_rangeee,
sum(invoice_total) as total_sales, 
sum(payment_total) as total_payment,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-07-01' and '2019-12-31'
		UNION
select 'total' as date_range, 
sum(invoice_total) as total_sales, 
sum(payment_total) as total_payment,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-01-01' and '2019-12-31';

select *
from invoices






--- creates a table using the query that i made before 
create table dangdamn_bro as
select 'first half of 2019' as date_range, 
sum(invoice_total) as total_sales, 
sum(payment_total) as total_payment,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-01-01' and '2019-06-29'
        union 
select '2nd half of 2019' as date_rangeee,
sum(invoice_total) as total_sales, 
sum(payment_total) as total_payment,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-07-01' and '2019-12-31'
		UNION
select 'total' as date_range, 
sum(invoice_total) as total_sales, 
sum(payment_total) as total_payment,
sum(invoice_total - payment_total) as what_we_expect
from invoices
where invoice_date between '2019-01-01' and '2019-12-31';

---- adds info the dangdamn_bro 


--- insert new recrod for the dangdamn_bro

insert  into dangdamn_bro
values('3rd baby','1555.77', '899.99', '7555');
--- updates the dangdamn_bro 
update dangdamn_bro 
set what_we_expect = 111.00
where date_range = '3rd baby';




 use sql_invoicing;
 ---- gives me the sum and total amount of different invoices for any one with over 500 and 5 invoices in total sales
 select client_id,
 sum(invoice_total) as total_sales,
 count(*) as number_of_invoices
 from invoices 
 group by client_id
 having total_sales > 500 
 and 
 number_of_invoices > 5;

----- joins two tables then uses the having clause to filter aggerate data 
use sql_store;
select
c.customer_id, c.first_name, c.last_name,
sum(oi.quantity * oi.unit_price) as total_sales
from customers as c
join orders as o 
using (customer_id)
join order_items
as oi 
using (order_id)
where state in('va','ny')
group by c.customer_id, c.first_name, c.last_name 
having total_sales > 100
order by first_name






-----

select *
from dangdamn_bro


in
(select customer_id
from customers
where points > 3000);


update orders 
set comments = 'gold member'
where customer_id
in
(select customer_id
from customers
where points > 3000);



use sql_store;

select *
from customers 
where state = 'Va'







select * 
from dangdamn_bro

-- creates new table called dangdamn_bro using all data from the customers table 
insert into dangdamn_bro
select 
customers
from sql_store.orders;



use sql_hr;


----- used a sub query to get all employees who earn more than the average 
select first_name, last_name, salary, avg(salary)
from employees
where salary >
( select avg(salary)
from employees)
group by first_name, last_name, salary



---- this is a subquery that will show a single value
use sql_store;
select * 
from products
where product_id not in
(select distinct 
product_id
from order_items);


--------subqueries

---- select the person with the most max points  point = could have wrtitten points in 
use sql_store;
select first_name, max(points)
from customers
where 
points = (select
          max(points)
          from customers)
          group by first_name;
          
          
          ---- another way to get the person with the most points 
select first_name, sum(points)
from customers
group by first_name
order by sum(points) desc limit 1 






------ a subquery that shows customers who have ordered lettuce 
use sql_store; 
select *
FROM customers 
WHERE customer_id IN ( 
SELECT o.customer_id 
FROM order_items as oi
JOIN orders as o using (order_id)
where oi.product_id = 3);
------



--- another way to see which customers ordered lettuce which is product 3 ..
select customer_id, first_name, last_name
from customers as c
join orders as o using(customer_id)
join order_items as oi
using(order_id) 
where oi.product_id = 3


----select invoices larger than all invoices of clients 3 


use sql_invoicing

selecct 

---- select invoices larger than all invoices of client 3 using subquery 
use sql_store;

select * 
from invoices
where invoice_total >
(select max(invoice_total)
from invoices
where client_id = 3);

----- select invoices larger than all invoices of client 3 using ALL function 

select *
from invoices 
where invoice_total >
all (
select invoice_total 
from invoices
where client_id = 3);

---- 
use sql_store;

select 
---- use the in clause to show all products that have never been ordered 
select * 
from products as p
where product_id not in( 
select product_id
from order_items 
where p.product_id = product_id)

--- 

use sql_invoicing;


select c.client_id, c.name,
 (select sum(invoice_total)
 from invoices 
  where client_id = c.client_id) as total_sales
  ( select avg(invoice_total)
  from invoices) as avg,
  (select tota_sales - avg) as difference
  from clients as c 






--- uses the exists operator to show all products that have never been ordered 
select * 
from products as p 
where not exists (
select product_id
from order_items 
where product_id = p.product_id)

use sql_invoicing;
 
 
;
  
 
 
from clients
 
 
 
 
  
 (select sum(invoice_total)
 from invoices 
  where client_id = c.client_id) as total_sales
  ( select avg(invoice_total)
  from invoices) as avg
  (select tota_sales - avg) as difference
  from clients as c 

------
---------get invoices that are longer than the the client's 
---------average invoice amount 
select * 
from invoices as i 
where invoice_total > (
select avg(invoice_total)
from invoices
where client_id= i.client_id);



-----

