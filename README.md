# SeQura Coding Challenge

## Problem Statement
Please find problem statement here: https://gist.github.com/francesc/33239117e4986459a9ff9f6ea64b4e80

## Solution
API only rails application is intialized to build this project to make it lightweight!

### Setup:

**Prerequisites:**
1. Ruby 3.0.2
2. Rails 6.1.6
3. MySQL
4. Redis

**Steps**
1. Clone Repo
2. `bundle install`
3. `rails db:setup`

**Data Modeling**
1) Merchant: To store merchants information
2) Order: To store orders information
3) Shopper: To store shopper information
4) Disbursement: To persist disbursements against one merchant with several order in a given week

**API Sample**
<details>
   <summary>Screenshots</summary>
<img width="394" alt="Screenshot 2022-05-30 at 11 50 18 PM" src="https://user-images.githubusercontent.com/86788260/171048346-14c6a80e-f91a-4034-b2ed-bf8e9a400669.png">
<img width="505" alt="Screenshot 2022-05-30 at 11 50 02 PM" src="https://user-images.githubusercontent.com/86788260/171048389-7dbd0bae-0f9e-4814-a68f-bf5839b31307.png">
 </details>

### How it works ###
We have stored disbursements for each merchant for each week in our database. One merchant will going to have one entry of disbursement for one week.
Web application and background jobs will be running in parallel. There is a job `CalculateDisbursementsJob` that run each day using configurations `config/sidekiq.yml` and it start other workers `CalculateDisbursementForMerchantJob` in parallel for each merchant which calculates disbursements for each merchant against those orders which not taken into the considerations yet for the current week. We can set frequency to cron `CalculateDisbursementsJob` which depends on influx of data/merchants/orders, it can be run after each 5 minutes. And through the endpoint, we can obtain how much money should be disbursed to each merchant for each customer per week/year.

#### What's missing or can be improved ###
1. Test coverage can be improved. Was not able to write test cases for background jobs due to time shortage.
2. API endopint should be secured.
3. Implement/Fix all TODO comments in the code.
4. We need to publish a domain event once order is completed to calculate the disbursements relaterd to its merchant.
5. If dataset is the source of truth, then we need to adjust email format regex OR we need to ignore entries in dataset that has invalid email formats.
6. We can include cache behind the API layer. Or if we do not find disbursements but completed orders are present, we can enqueue background job.
7. Write rake task that calculate the disbursements from the starting point when system was up for the first time till today
8. Rubocop should be integrated
9. Facker & FactoryBot should also be integrated to write neat test cases.
