-- FIRST DASHBOARD

--PART 1
 
select * from loans;

--  Change the data type to date for some columns
ALTER TABLE loans 
  ALTER COLUMN isuue_date TYPE DATE USING to_date(issue_date, 'DD-MM-YYYY'),
  ALTER COLUMN last_credit_pull_date TYPE DATE USING to_date(last_credit_pull_date, 'DD-MM-YYYY'),
  ALTER COLUMN last_payment_date       TYPE DATE USING to_date(last_payment_date, 'DD-MM-YYYY'),
  ALTER COLUMN next_payment_date       TYPE DATE USING to_date(next_payment_date, 'DD-MM-YYYY');

-- 1. Total Loan Applications

select count(id) as total_loan_applications  from loans; 

--  MTD and PMTD Loan Applications 

select count(id) as MTD_loan_applications from loans 
where extract(MONTH from issue_date)= 12
and extract (YEAR from issue_date)=2021;

select count(id) as PMTD_loan_applications from loans 
where extract(MONTH from issue_date)= 11
and extract (YEAR from issue_date)=2021;

-- 2. Total funded Amount

select sum(loan_amount) as total_funded_amount from loans;

-- MTD and PMTD funded amounts

select sum(loan_amount) as MTD_funded_amount from loans
where extract(MONTH from issue_date)= 12 and extract(YEAR from issue_date)=2021;

select sum(loan_amount) as MTD_funded_amount from loans
where extract(MONTH from issue_date)= 11 and extract(YEAR from issue_date)=2021;

-- 3. Total received amount

select sum(total_payment) as total_received_amount from loans;

--  MTD and PMTD Received amount

select sum(total_payment) as MTD_received_amount from loans
where  extract(MONTH from issue_date)= 12 and extract(YEAR from issue_date)=2021;

select sum(total_payment) as PMTD_received_amount from loans
where  extract(MONTH from issue_date)= 11 and extract(YEAR from issue_date)=2021;

-- 4. AVG interest rate
select avg(int_rate) *100 as avg_int_rate from loans;

-- MTD and PMTD avg interest rate 
select avg(int_rate)*100 as MTD_avg_int_rate from loans
where  extract(MONTH from issue_date)= 12 and extract(YEAR from issue_date)=2021;

select avg(int_rate) *100 as PMTD_avg_int_rate from loans
where  extract(MONTH from issue_date)= 11 and extract(YEAR from issue_date)=2021;

-- 5. avg DTI

select avg(dti) * 100 as avg_DTI from loans;

--  MTD and PMTD avg DTI

select avg(dti)*100 as MTD_avg_DTI from loans
where  extract(MONTH from issue_date)= 12 and extract(YEAR from issue_date)=2021;

select avg(dti) *100 as PMTD_avg_DTI from loans
where  extract(MONTH from issue_date)= 11 and extract(YEAR from issue_date)=2021;


-- PART 2


select * from loans;

-- 1. Good loan applications percentage
select count(
case when loan_status ='Fully Paid'
or loan_status ='Current' then id end) * 100/
count(id) as good_loan_app_percentage
from loans;

-- 2. Good loan applications 

select count(id) as good_loan_applications from loans where loan_status in ('Fully Paid','Current');

-- 3. Good loan funded amount

select sum(loan_amount) as good_loan_funded_amount from loans where loan_status in ('Fully Paid','Current');

-- 4. Good loan received amount 

select sum(total_payment) as good_loan_received_amount from loans where loan_status in ('Fully Paid','Current');



-- 5. bad loan applications percentage
select (count(case when loan_status ='Charged Off' then id end) * 100)/
count(id) as bad_loan_app_percentage
from loans;

-- 6. bad loan applications 

select count(id) as bad_loan_applications from loans where loan_status ='Charged Off';

-- 7. bad loan funded amount

select sum(loan_amount) as bad_loan_funded_amount from loans where loan_status  ='Charged Off';

-- 8. bad loan received amount 

select sum(total_payment) as bad_loan_received_amount from loans where loan_status ='Charged Off';


-- 9. Loan status 

select loan_status, 
   count(id) as loan_count,
   sum(total_payment) as total_amount_received,
   sum(loan_amount) as total_funded_amount,
   avg(int_rate *100) as avg_int_rate,
   avg(dti * 100) as avg_dti
from loans group by loan_status order by total_amount_received DESC;

-- 10. MTD Loan status 

select loan_status, 
   count(id) as loan_count,
   sum(total_payment) as MTD_total_amount_received,
   sum(loan_amount) as MTD_total_funded_amount,
   avg(int_rate *100) as MTD_avg_int_rate,
   avg(dti * 100) as MTD_avg_dti
from loans 
where extract(month from issue_date)=12 and extract( year from issue_date)=2021
group by loan_status order by total_amount_received DESC;

-- 11. PMTD Loan status 

select loan_status, 
   count(id) as loan_count,
   sum(total_payment) as PMTD_total_amount_received,
   sum(loan_amount) as PMTD_total_funded_amount,
   avg(int_rate *100) as PMTD_avg_int_rate,
   avg(dti * 100) as PMTD_avg_dti
from loans 
where extract(month from issue_date)=11 and extract( year from issue_date)=2021
group by loan_status order by total_amount_received DESC;
