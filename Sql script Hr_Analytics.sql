-- used to change columname 
-- ALTER TABLE hr_2 CHANGE COLUMN `Employee ID` Employee_ID VARCHAR(255);

use hr_analytics;
select * from hr_1;
select * from hr_2;

-- Q1 Average Attrition rate for all Departments
 with cte as
(select department,
count(case when Attrition ="yes" then 1  end ) / count(*) *100 as Attrition_rate
from hr_1
group by department) select department, avg(Attrition_rate) over (partition by department)
 as Average_Attrition_Rate from cte;
 
-- Q2 Average Hourly rate of Male Research Scientist
select  Jobrole, avg(HourlyRate)as Average_Hourly_rate_Male_scientist from hr_1
where Gender = "Male" and JobRole = "Research Scientist"  ;

-- Q3 Attrition rate Vs Monthly income stats
select h2.monthlyincome ,
count(case when h1.attrition = "Yes" then 1 end ) / count(*) *100 as Attrition_rate
from hr_1 h1
join 
hr_2 h2 on h1.employeenumber = h2.employeeid 
group by h2.monthlyincome 
order by h2.monthlyincome desc;



-- Q4 Average working years for each Department

select department , avg(age) as Average_working_yrs_department_wise
from hr_1
group by department;

-- Q5Job Role Vs Work life balance
select h1.jobrole , avg(h2.worklifebalance) as work_life
from hr_1 h1
join hr_2 h2 on h1.employeenumber=h2.employeeid
group by h1.jobrole
order by work_life desc;

-- Q6 Attrition rate Vs Year since last promotion relation
select h2.yearssincelastpromotion,
count(case when h1.attrition ="Yes" then 1 end ) / count(*) * 100 as attrition_rate
from hr_1 h1
join 
hr_2 h2 on h1.employeenumber=h2.employeeid
group by h2.yearssincelastpromotion
order by h2.yearssincelastpromotion desc;







