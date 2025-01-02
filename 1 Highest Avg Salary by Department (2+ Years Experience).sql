
-- youtube link - https://www.youtube.com/@VijaiTheAnalyst
-- Question - Write a query to find the department with the highest average salary for employees who have been with the company for more than 2 years.

use youtubedb;

create table department (
department_id int PRIMARY KEY Auto_increment,
department_name varchar(50) not null
);

create table employee_2(
employee_id int PRIMARY KEY AUTO_INCREMENT,
employee_name varchar(200) not null,
department_id int,
salary decimal(10,2) not null,
hire_date date not null,
foreign key (department_id) references department(department_id)
);

insert into department(department_name)
Values
('Sales'), ('Engineering'), ('Marketing'), ('Finance'), ('IT');

DELIMITER  //
create procedure insert_random_employee(in num_employee int)
begin 
	declare i int default 1;
    while i <= num_employee do
		insert into employee_2(employee_name, department_id, salary, hire_date) Values
        (concat('Employee_',i), floor(rand()*5)+1, floor(rand()*1000000)+30000, Date_sub(curdate(), interval floor(rand()*10) year));
		set i = i +1;
    end while;
end //
DELIMITER ;

call insert_random_employee(100);

select 
department_name, avg(salary)
from 
employee_2 as E
left join department as D
on E.department_id = D.department_id
where e.hire_date < date_sub(curdate(), interval 2 year)
group by department_name
order by avg(salary) desc
limit 1;

