use youtubedb;
-- youtube link - https://www.youtube.com/@VijaiTheAnalyst
-- Write a query to find the nth highest salary in each department.

select * from employee_2;
select * from Department;

select * from
(
	select 
		E.employee_name,
		E.salary,
		D.department_name,
		rank() over(partition by E.department_id order by E.salary desc) as Rnk_num    
	from employee_2 as E
	left join department as D
	on E.department_id = D.department_id
) as tbl_1
where rnk_num = 3
order by salary desc;













