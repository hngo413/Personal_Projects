/* CHANGE DATE FORMAT IN GLOBAL SETTINGS */
/* pg 304 - 44 */
select * from lgdepartment l;

/* pg 304 - 45 */
select p.prod_sku, p.prod_descript, p.prod_type, p.prod_base, p.prod_category, p.prod_price from lgproduct as p
where p.prod_base='Water' and p.prod_category='Sealer';

/* pg 305 - 46 */
select emp.emp_fname, emp.emp_lname, emp.emp_email
from lgemployee as emp
where emp.emp_hiredate between STR_TO_DATE("1/1/2001", "%m/%d/%Y") and STR_TO_DATE("12/31/2010", "%m/%d/%Y")
order by emp.emp_lname, emp.emp_fname;

/* pg 305 - 47 */
select emp.emp_fname, emp.emp_lname, emp.emp_phone, emp.emp_title, emp.dept_num
from lgemployee as emp
where emp.dept_num=300 or emp.emp_title='CLERK I'
order by emp.emp_lname, emp.emp_fname;

/* pg 305 - 48 */
select emp.emp_num, emp.emp_lname, emp.emp_fname, sal.sal_from, sal.sal_end, sal.sal_amount
from lgemployee as emp, lgsalary_history as sal
where emp.emp_num=sal.emp_num and emp.emp_num in (83731,83745,84039)
order by emp.emp_num, sal.sal_from;

/* pg 306 - 49 */
select distinct c.cust_fname, c.cust_lname, c.cust_street, c.cust_city, c.cust_state, c.cust_zip
from lgcustomer as c, lginvoice as i, lgline as l, lgproduct as p, lgbrand as b
where c.cust_code=i.cust_code
and i.inv_num=l.inv_num
and l.prod_sku=p.prod_sku
and p.brand_id=b.brand_id
and b.brand_name='FORESTERS BEST'
and p.prod_category='Top Coat'
and inv_date between STR_TO_DATE("July 15, 2013", "%M %d, %Y") and STR_TO_DATE("July 31, 2013", "%M %d, %Y")
order by c.cust_state, c.cust_lname, c.cust_fname;

/* pg 306 - 50 */
select e.emp_num, e.emp_lname, e.emp_email, e.emp_title, d.dept_name
from lgemployee as e, lgdepartment as d
where e.dept_num=d.dept_num
and e.emp_title like '%ASSOCIATE'
order by d.DEPT_NAME, e.EMP_TITLE;

/* pg 307 - 51 */
select b.brand_name, count(p.prod_sku) as numproducts
from lgbrand as b, lgproduct as p
where b.brand_id=p.brand_id
group by b.brand_name
order by b.brand_name;

/* pg 307 - 52 */
select p.prod_category, count(*) as numproducts
from lgproduct as p
where p.prod_base='Water'
group by p.prod_category;

/* pg 308 - 53 */
SELECT p.PROD_BASE, p.PROD_TYPE, Count(*) AS NUMPRODUCTS
FROM LGPRODUCT as p
GROUP BY p.PROD_BASE, p.PROD_TYPE
ORDER BY p.PROD_BASE, p.PROD_TYPE;

/* pg 308 - 54 */
SELECT p.BRAND_ID, Sum(p.PROD_QOH) AS TOTALINVENTORY
FROM LGPRODUCT as p
GROUP BY p.BRAND_ID
ORDER BY p.BRAND_ID DESC;

/* pg 308 - 55 */
SELECT P.BRAND_ID, B.BRAND_NAME, Round(Avg(P.PROD_PRICE),2) AS AVGPRICE
FROM LGBRAND AS B, LGPRODUCT AS P
WHERE B.BRAND_ID = P.BRAND_ID
GROUP BY P.BRAND_ID, B.BRAND_NAME
ORDER BY B.BRAND_NAME;

/* pg 309 - 56 */
SELECT L.DEPT_NUM, Max(L.emp_hiredate) AS MOSTRECENT 
FROM LGEMPLOYEE as L
GROUP BY L.DEPT_NUM
ORDER BY L.DEPT_NUM;

/* pg 309 - 57 */
SELECT E.EMP_NUM, E.EMP_FNAME, E.EMP_LNAME, Max(S.SAL_AMOUNT) AS LARGESTSALARY
FROM LGEMPLOYEE AS E, LGSALARY_HISTORY AS S
WHERE E.EMP_NUM = S.EMP_NUM
AND DEPT_NUM = 200
GROUP BY E.EMP_NUM, E.EMP_FNAME, E.EMP_LNAME
ORDER BY max(S.sal_amount) DESC;

/* pg 309 - 58 */
SELECT C.CUST_CODE, C.CUST_FNAME, C.CUST_LNAME, Sum(I.INV_TOTAL) AS TOTALINVOICES
FROM LGCUSTOMER AS C, LGINVOICE AS I
WHERE C.CUST_CODE = I.CUST_CODE
GROUP BY C.CUST_CODE, C.CUST_FNAME, C.CUST_LNAME
HAVING Sum(I.INV_TOTAL) > 1500
ORDER BY Sum(I.INV_TOTAL) DESC;

/* pg 310 - 59 */
SELECT D.DEPT_NUM, D.DEPT_NAME, D.DEPT_PHONE, D.EMP_NUM, E.EMP_LNAME
FROM LGDEPARTMENT AS D, LGEMPLOYEE AS E
WHERE D.EMP_NUM = E.EMP_NUM
ORDER BY D.DEPT_NAME;

/* pg 310 - 60 */
SELECT V.VEND_ID, V.VEND_NAME, B.BRAND_NAME, Count(*) AS NUMPRODUCTS
FROM LGBRAND AS B, LGPRODUCT AS P, LGSUPPLIES AS S, LGVENDOR AS V
WHERE B.BRAND_ID = P.BRAND_ID
AND P.PROD_SKU = S.PROD_SKU
AND S.VEND_ID = V.VEND_ID
GROUP BY V.VEND_ID, V.VEND_NAME, B.BRAND_NAME
ORDER BY V.VEND_NAME, B.BRAND_NAME;

/* pg 310 - 61 */
SELECT E.EMP_NUM, E.EMP_LNAME, E.EMP_FNAME, Sum(I.INV_TOTAL) AS TOTALINVOICES
FROM LGINVOICE as I, LGEMPLOYEE as E
WHERE E.EMP_NUM = I.EMPLOYEE_ID
GROUP BY E.EMP_NUM, E.EMP_LNAME, E.EMP_FNAME
ORDER BY E.EMP_LNAME, E.EMP_FNAME;

/* pg 311 - 62 */
SELECT Max(AVGPRICE) AS "LARGEST AVERAGE"
FROM (SELECT P.BRAND_ID, Round(Avg(P.PROD_PRICE),2) AS AVGPRICE
      FROM LGPRODUCT as P
      GROUP BY P.BRAND_ID) J;

/* pg 311 - 63 */
SELECT P.BRAND_ID, BRAND_NAME, BRAND_TYPE, 
	Round(Avg(PROD_PRICE),2) AS AVGPRICE
FROM LGPRODUCT AS P, LGBRAND AS B
WHERE P.BRAND_ID = B.BRAND_ID
GROUP BY P.BRAND_ID, BRAND_NAME, BRAND_TYPE
HAVING Round(Avg(PROD_PRICE),2) = 
	(SELECT Max(AVGPRICE) AS "LARGEST AVERAGE"
                          FROM (SELECT BRAND_ID, Round(Avg(PROD_PRICE),2) AS AVGPRICE
                                        FROM LGPRODUCT P
                                        GROUP BY BRAND_ID) J);

/* pg 311 - 64 */
SELECT CONCAT(DE.emp_fname, ' ', DE.emp_lname) AS 'MANAGER NAME', DEPT_NAME, DEPT_PHONE, CONCAT(E.emp_fname, ' ', E.emp_lname) AS 'EMPLOYEE NAME', CONCAT(CUST_FNAME, ' ', CUST_LNAME) AS 'CUSTOMER NAME', INV_DATE, INV_TOTAL
FROM LGDEPARTMENT AS D, lgemployee AS E, lgemployee AS DE, LGINVOICE AS I, LGCUSTOMER AS C
WHERE D.EMP_NUM = DE.EMP_NUM
AND D.DEPT_NUM = E.DEPT_NUM
AND E.EMP_NUM = I.EMPLOYEE_ID
AND I.CUST_CODE = C.CUST_CODE
AND CUST_LNAME = 'HAGAN'
AND I.INV_DATE = STR_TO_DATE("5/18/2013", "%m/%d/%Y");