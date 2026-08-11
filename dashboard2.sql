--- Second Dashboard 
--- Metrics to be shown : Total Loan Applications, Total Funded Amount and Total Amount Received

select * from loans;

-- 1. Monthly Trends by Issue Date 
select 
  Extract(MONTH from issue_date) as month_number,
  to_char(issue_date, 'MONTH')  as month_name,
  count(id) as total_loan_applications,
  sum(loan_amount) as total_funded_received,
  sum(total_payment) as total_received_amount
from loans
group by Extract(MONTH from issue_date), to_char(issue_date, 'MONTH')
order by Extract(MONTH from issue_date) ;

-- 2. REgional analysis by State

select 
  address_state,
  count(id) as total_loan_applications,
  sum(loan_amount) as total_funded_received,
  sum(total_payment) as total_received_amount
from loans
group by address_state
order by count(id) desc;

-- 3. Loan term Analysis 

select 
  term,
  count(id) as total_loan_applications,
  sum(loan_amount) as total_funded_received,
  sum(total_payment) as total_received_amount
from loans
group by term
order by count(id) desc;

-- 4. Employee Length Analysis

select 
  emp_length,
  count(id) as total_loan_applications,
  sum(loan_amount) as total_funded_received,
  sum(total_payment) as total_received_amount
from loans
group by emp_length
order by count(id) desc;

-- 5. Loan Purpose Breakdown
select 
  purpose,
  count(id) as total_loan_applications,
  sum(loan_amount) as total_funded_received,
  sum(total_payment) as total_received_amount
from loans
group by purpose
order by count(id) desc;


-- 6. Home Ownership Analysis 
select 
  home_ownership,
  count(id) as total_loan_applications,
  sum(loan_amount) as total_funded_received,
  sum(total_payment) as total_received_amount
from loans
group by home_ownership
order by count(id) desc;


