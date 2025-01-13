-- youtube link - https://www.youtube.com/@VijaiTheAnalyst
-- Accenture
-- Uniquely Staffed Consultants
-- As a Data Analyst on the People Operations team at Accenture, you are tasked with understanding how many consultants are
-- staffed to each client, and how many consultants are exclusively staffed to a single client. Write a query that displays 
-- the outputs of client name and the number of uniquely and exclusively staffed consultants ordered by client name.

create table employee_4  (
employee_id int not null,
engagement_id int not null
);
DELIMITER //
create procedure employee_4_data_creation()
	begin 
	declare i int default 1;
	while i <= 100 do 
		insert into employee_4(employee_id, engagement_id)
        values(1000 + floor(rand()*40) , floor(rand()*6)+1);
        set i  = i +1;
	end while;
END //
DELIMITER ;
call employee_4_data_creation();

select employee_id, count(employee_id) from employee_4
group by employee_id ;

create table consulting_engagements(
engagement_id int primary key auto_increment,
project_name varchar(200) not null,
company_name varchar(200) not null 
);

insert into consulting_engagements(project_name, company_name)
values
('SAS_Transition','XYZ Analytics'),
('Python Automation','ABB Research Insights'),
('Snowflake cloud migration','XYZ Analytics'),
('BI tool Integration','KY Associates'),
('Onboarding employees','KY Associates'),
('Internal training','Country Bank');

with exclusive_employee as(
	select 
		E.employee_id
    from employee_4 as E
    left join consulting_engagements as CE
    on E.engagement_id = CE.engagement_id
    group by E.employee_id
    having count(CE.company_name) = 1
)
select 
	CE.company_name,
    count(TE.employee_id) as total_employee,
    count(EE.employee_id) as Exclusive_employee
from employee_4 as TE
left join consulting_engagements as CE
on TE.engagement_id = CE.engagement_id
left join exclusive_employee as EE
on TE.employee_id = EE.employee_id
group by CE.company_name
order by CE.company_name
;


drop table employee_4;
drop table consulting_engagements;
drop procedure employee_4_data_creation;
