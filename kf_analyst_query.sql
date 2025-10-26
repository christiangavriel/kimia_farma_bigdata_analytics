-- Create New Table

CREATE TABLE `rakamin-kf-analytics-476317.kimia_farma.kf_analyst` AS

SELECT
  t.transaction_id,
  t.date,
  c.branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,
  c.rating AS rating_cabang,
  t.customer_name,
  p.product_id,
  p.product_name,
  t.price AS actual_price,
  t.discount_percentage,

-- Calculate profit percentage based on price
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price <= 100000 THEN 0.15
    WHEN t.price <= 300000 THEN 0.20
    WHEN t.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

  -- Calculate nett sales
  (t.price * (1 - t.discount_percentage/100)) AS nett_sales,

  -- Calculate net profit
  (t.price * (1 - t.discount_percentage/100)) *
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price <= 100000 THEN 0.15
    WHEN t.price <= 300000 THEN 0.20
    WHEN t.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit,

  t.rating AS rating_transaksi

FROM
  `rakamin-kf-analytics-476317.kimia_farma.kf_final_transaction` AS t
JOIN
  `rakamin-kf-analytics-476317.kimia_farma.kf_product` AS p
ON
  t.product_id = p.product_id
JOIN
  `rakamin-kf-analytics-476317.kimia_farma.kf_kantor_cabang` AS c
ON
  t.branch_id = c.branch_id;


