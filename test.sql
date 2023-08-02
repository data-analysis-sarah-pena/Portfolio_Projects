/*
Summary:
  I leveraged Google Analytics ecommerce data to deliver actionable insights through comprehensive data analysis, optimizing key performance metrics, supporting informed decision-making, and driving business growth. Utilizing SQL, I identified the best selling product, top 10 customers by AOV, top 100 customers with the highest LTV, segmented customers by gender and purchase category for targeted marketing, and analyzed total customer revenue.

These metrics identify high and low value customers, segment customer behaviors, categorize customers by order value over specific durations, recognize frequent and substantial purchasers, and quantify KPIs for sales and marketing dashboards, ultimately contributing significantly to company revenue.

Dataset: (console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1sbigquery-public-data!2sthelook_ecommerce)

Data Analysis:
*/

--What is the best selling item?

SELECT
oi.product_id AS product_id,
p.name AS product_name,
p.category AS product_category,
COUNT(*) AS num_of_orders
FROM
`bigquery-public-data.thelook_ecommerce.products` AS p
JOIN
`bigquery-public-data.thelook_ecommerce.order_items` AS oi
ON
p.id = oi.product_id
GROUP BY
1,
2,
3
ORDER BY
num_of_orders DESC

/*
I utilized the COUNT function to calculate the total number of orders, incorporated the order items table with the JOIN keyword, and arranged the data in descending order based on the total number of orders to identify the best selling product.

The best selling product provides valuable insights into consumer preferences and demand patterns. Listed below are several ways it can be implemented:

Revenue Optimization: Identifying the best selling product allows businesses to focus their efforts on promoting and optimizing sales for that particular item, maximizing revenue generation.

Inventory Management: Understanding which product sells the most helps in better inventory management. Businesses can ensure that there is enough stock available to meet customer demand for the popular product while minimizing excess inventory costs for slower-selling items.

Marketing Strategies: Knowledge of the best selling product can inform marketing strategies and campaigns. Businesses can tailor their marketing efforts to highlight the most popular product, attracting more potential customers and driving sales.

Product Development: The information about the best selling product can also influence product development decisions. It provides valuable feedback on what features and attributes resonate well with customers, guiding future product improvements and innovations.

Competitive Insights: Knowing the best selling product within the market segment provides a competitive advantage. Businesses can use this information to benchmark themselves against competitors and identify potential gaps or opportunities in the market.

In summary, understanding the best selling product is essential for strategic decision-making, revenue generation, and overall business success in the competitive ecommerce companies.
*/

--Top 10 Customers by Average Order Price?

SELECT
u.id AS user_id,
u.first_name,
u.last_name,
AVG(oi.sale_price) AS avg_sale_price
FROM
`bigquery-public-data.thelook_ecommerce.users` AS u
JOIN
`bigquery-public-data.thelook_ecommerce.order_items` AS oi
ON
u.id = oi.user_id
GROUP BY
1,
2,
3
ORDER BY
avg_sale_price DESC
LIMIT
10

/*
To identify the top 10 customers by average order value, I employed the AVG function to calculate the average sale price from the order_items table and used the JOIN keyword to retrieve data from both the users and order_items tables. Subsequently, I arranged the information in descending order based on the average sale price.

Determining the top 10 customers by average order value is useful for solving a business problem because it helps in identifying and leveraging high-value customers. Here's why it is important:

Revenue Maximization: High-value customers contribute significantly to a company's revenue. Identifying the top 10 customers by average order value allows businesses to focus on providing excellent customer service, personalized offers, and incentives to encourage repeat purchases and increase the average transaction value.

Customer Retention and Loyalty: Understanding the purchasing behavior of the top 10 customers helps in building strong relationships with these valuable clients. By recognizing and catering to their preferences, businesses can enhance customer satisfaction and loyalty, reducing the likelihood of them switching to competitors.

Upselling and Cross-selling Opportunities: High-value customers are more likely to be receptive to upselling and cross-selling offers. By knowing their preferences and purchase history, businesses can tailor targeted promotions to increase the value of each transaction.

Marketing Strategies: Insights gained from the top 10 customers can be used to refine marketing strategies. Businesses can create more effective and targeted campaigns, focusing on attracting similar high-value customers and improving overall marketing ROI.

Customer Segmentation: Identifying high-value customers also helps in customer segmentation. Businesses can categorize customers based on their spending patterns, allowing for more tailored and effective marketing and communication efforts.

Profitability Analysis: Analyzing the purchasing behavior of the top 10 customers helps in understanding the profitability of individual customers. This knowledge can guide businesses in resource allocation and prioritizing customer service efforts.

Competitive Advantage: By effectively serving and retaining high-value customers, businesses can gain a competitive advantage. Satisfied and loyal customers are more likely to recommend the company to others, leading to increased word-of-mouth referrals and a positive brand reputation.

In summary, knowing the top 10 customers by average order value is crucial for maximizing revenue, enhancing customer loyalty, and developing targeted marketing strategies, ultimately leading to improved business performance and growth.
*/

--Top 100 Customers by Lifetime Value

SELECT
u.id AS user_id,
u.first_name,
u.last_name,
SUM(oi.sale_price) AS lifetime_value
FROM
`bigquery-public-data.thelook_ecommerce.users` AS u
JOIN
`bigquery-public-data.thelook_ecommerce.order_items` AS oi
ON
u.id = oi.user_id
GROUP BY
1,
2,
3
ORDER BY
lifetime_value DESC
LIMIT
100

/*
To identify the top 100 customers by lifetime value, I employed the SUM function to calculate the sum sale price from the order_items table and used the JOIN keyword to retrieve data from both the users and order_items tables. Next, I arranged the information in descending order based on the lifetime value.

Recognizing the top 100 customers by lifetime value is useful for solving a business problem because it allows businesses to focus on their most profitable and loyal customers. Here's why it is important:

Revenue Generation: The top 100 customers with the highest lifetime value are a significant source of revenue for the business. By understanding their preferences and behaviors, companies can tailor products, services, and offers to retain and further increase their spending, maximizing revenue.

Customer Retention and Loyalty: High lifetime value customers are likely to be loyal to the brand. Knowing who these customers are enables businesses to implement targeted retention strategies, providing exceptional customer service, loyalty programs, and personalized incentives to foster long-term relationships.

Referral Potential: Satisfied customers with high lifetime value are more likely to refer others to the business. By identifying and nurturing these customers, companies can benefit from positive word-of-mouth marketing, which can drive new customer acquisition at a lower cost.

Upselling and Cross-selling Opportunities: Understanding the purchasing history of the top 100 customers with high lifetime value allows businesses to identify opportunities for upselling and cross-selling. Tailored offers and recommendations can increase the average order value and customer lifetime value even further.

Customer Segmentation: Identifying high lifetime value customers helps in customer segmentation. Businesses can categorize customers based on their value to the company, allowing for more personalized and effective marketing strategies for different customer groups.

Resource Allocation: Focusing on high lifetime value customers can optimize resource allocation. Businesses can allocate marketing, sales, and customer service efforts more efficiently, prioritizing efforts where they are most likely to yield the highest return on investment.

Churn Prediction: Analyzing the behavior of top customers in terms of lifetime value can also help predict and prevent customer churn. By understanding factors that lead to churn among high-value customers, businesses can take proactive measures to retain them.

Competitive Advantage: Identifying and nurturing high lifetime value customers can provide a competitive advantage. By building strong customer relationships and loyalty, businesses can differentiate themselves from competitors and create barriers to entry for new players.

In summary, knowing the top 100 customers by lifetime value is crucial for revenue optimization, customer retention, and strategic resource allocation, leading to improved customer satisfaction, business performance, and sustained growth.
*/

--Categorize customers by gender and purchase for targeted marketing.

SELECT
u.id AS user_id,
u.gender,
u.first_name,
u.last_name,
u.email,
p.category

FROM
`bigquery-public-data.thelook_ecommerce.users` AS u
JOIN
`bigquery-public-data.thelook_ecommerce.products` AS p
ON
u.id = p.id

GROUP BY
1,
2,
3,
4,
5,
6
ORDER BY
gender, category

/*
I utilized the JOIN keyword to retrieve data from both the users and products tables and ordered the information by gender and category. I included the users emails so that the list could be exported for targeted marketing tailored to specific gender preferences and interests, personalized recommendations, cross-selling and upselling, and seasonal trend insights.

Identifying the customers' gender and purchase category is useful for solving a business problem because it provides valuable insights into consumer preferences and behavior, enabling businesses to implement targeted marketing strategies and improve customer engagement. Here's why it is important:

Personalized Marketing: Understanding the gender of customers allows businesses to create more personalized and relevant marketing campaigns. Different genders may have distinct preferences and interests, and tailoring promotions accordingly can enhance the effectiveness of marketing efforts.

Targeted Product Recommendations: Knowing the purchase category of customers helps in providing targeted product recommendations. By analyzing past purchases, businesses can offer related or complementary products that align with customers' interests, increasing the chances of upselling and cross-selling.

Customer Segmentation: Categorizing customers based on their purchase category allows for effective customer segmentation. Businesses can group customers with similar interests and behaviors, facilitating more personalized communication and marketing strategies.

Inventory Management: Insights into purchase categories enable businesses to optimize inventory management. By understanding which products are in high demand, companies can ensure sufficient stock availability for popular items and reduce excess inventory costs for less popular ones.

New Product Development: Analysis of purchase categories can guide new product development decisions. By identifying trending or popular categories, businesses can prioritize the creation of new products that align with customer preferences and market demands.

Customer Satisfaction: Tailoring products and marketing efforts based on customer gender and purchase category can enhance customer satisfaction. Satisfied customers are more likely to become repeat buyers and brand advocates, positively impacting the business's reputation and customer retention.

Marketing ROI: Targeted marketing based on gender and purchase category can lead to improved marketing return on investment (ROI). By focusing on specific customer segments, businesses can allocate marketing resources more efficiently and effectively.

Competitor Analysis: Understanding customers' purchase categories can also provide insights into competitor analysis. By comparing customer preferences with those of competitors, businesses can identify market gaps and opportunities for differentiation.

In summary, knowing the customers' gender and purchase category is crucial for implementing personalized marketing, improving customer segmentation, enhancing customer satisfaction, and making informed decisions related to product development and inventory management. These insights enable businesses to stay competitive and drive growth in the ever-evolving market landscape.
*/

--What is each customer’s total revenue?

SELECT u.id AS user_id, u.first_name, u.last_name, u.email, i.sale_price AS customer_revenue,
COUNT (num_of_item) AS total_conversions,


FROM
`bigquery-public-data.thelook_ecommerce.users` AS u
JOIN
`bigquery-public-data.thelook_ecommerce.orders` AS o
ON
o.user_id = u.id
JOIN
`bigquery-public-data.thelook_ecommerce.order_items` AS i
ON
i.id = u.id


GROUP BY
1,
2,
3,
4,
5


ORDER BY (sale_price) DESC

/*
Knowing each customer's total revenue is essential for solving a business problem because it provides critical information about the customer's value to the company. Here's why it is important:

Customer Segmentation: Segmenting customers based on their total revenue allows businesses to identify high-value and low-value customers. This segmentation helps in tailoring marketing strategies and customer service efforts according to the potential and value each customer brings to the business.

Personalized Marketing: Understanding each customer's total revenue enables personalized marketing approaches. Businesses can customize promotions, offers, and communications based on the customer's spending behavior, increasing the likelihood of conversion and customer loyalty.

Customer Retention: Knowing the total revenue of each customer helps in prioritizing efforts to retain high-value customers. Businesses can allocate resources and incentives to retain those customers who contribute significantly to the company's revenue, reducing churn and maintaining long-term profitability.

Customer Lifetime Value (CLV) Prediction: Total revenue data aids in calculating the Customer Lifetime Value (CLV) of individual customers. This metric is crucial for estimating the long-term profitability of a customer and helps in making strategic decisions related to customer acquisition and retention.

Upselling and Cross-selling Opportunities: Total revenue insights can identify upselling and cross-selling opportunities for individual customers. Businesses can offer higher-value products or services to customers with the potential to spend more, increasing the average transaction value.

Decision-Making: Knowing each customer's total revenue provides decision-makers with a clear understanding of the revenue distribution and the impact of individual customers on the overall business performance. It informs resource allocation and investment decisions for different customer segments.

Competitive Analysis: Total revenue data also helps in competitive analysis. By comparing the revenue generated from different customer segments, businesses can identify their strengths and weaknesses relative to competitors, leading to informed strategies for growth and market positioning.

Customer Feedback and Satisfaction: Monitoring each customer's total revenue can provide insights into customer satisfaction and feedback. High-value customers who have been with the company for an extended period and have made significant purchases are more likely to provide valuable feedback.

In summary, knowing each customer's total revenue is essential for customer segmentation, personalized marketing, customer retention, CLV prediction, and making data-driven decisions to improve overall business performance and profitability. It allows businesses to prioritize efforts, allocate resources efficiently, and build long-lasting customer relationships.
*/
