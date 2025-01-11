-- youtube link - https://www.youtube.com/@VijaiTheAnalyst
-- Visa
-- Monthly Merchant Balance
-- Say you have access to all the transactions for a given merchant account. Write a query to print the cumulative 
-- balance of the merchant account at the end of each day, with the total balance reset back to zero at the end of the month. 
-- Output the transaction date and cumulative balance.

use youtubedb;

create table merchant_transaction(
transaction_id  int PRIMARY KEY auto_increment,
merchant_id int not null,
transaction_date date not null,
amount decimal(10,2) not null)
;

DELIMITER //
create procedure merchant_transaction_data()
begin 
	declare i int default 1;
    declare start_date date default '2024-01-01';
    while i <= 100 do
		insert into merchant_transaction(merchant_id,transaction_date,amount) 
        values (1, Date_add(start_date, interval(i) Day), round(rand()*100 -50, 2));
        set i = i+1;
	end while;
END //
DELIMITER ;
call merchant_transaction_data();

with daily_total as(
	select 
		transaction_Date,
		day(transaction_Date) as tran_day,
        month(transaction_Date) as tran_month,
        year(transaction_Date) as tran_year,
        sum(amount) as day_bal
    from merchant_transaction
    group by tran_day,tran_month,tran_year
)

select 
	transaction_Date, day_bal,
	sum(day_bal)over(partition by tran_month, tran_year order by tran_day) as cum_daily_bal
from daily_total
order by transaction_Date
;

drop table merchant_transaction;
drop procedure merchant_transaction_data;



