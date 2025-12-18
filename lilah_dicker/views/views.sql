CREATE VIEW household_essential_spend AS
SELECT
  p.household_id,
  pic.item_type,
  SUM(
    pic.quantity * pic.unit_price - pic.discount_amount
  ) AS spend
FROM Purchases p
JOIN purchase_items_classified pic
  ON p.purchase_id = pic.purchase_id
GROUP BY p.household_id, pic.item_type;

CREATE VIEW purchase_items_classified AS
SELECT
  pi.purchase_id,
  pi.product_id,
  pc.category_main,
  pi.quantity,
  pi.unit_price,
  pi.discount_amount,
  CASE
    WHEN pc.category_main = 'ESSENTIAL'
      THEN 'ESSENTIAL'
    ELSE 'NONESSENTIAL'
  END AS item_type
FROM Purchase_Items pi
JOIN Products pr
  ON pi.product_id = pr.product_id
JOIN Product_Categories pc
  ON pr.category_main = pc.category_main
 AND pr.category_detail = pc.category_detail;

CREATE VIEW monthly_household_spend AS
SELECT
  p.household_id,
  DATE_FORMAT(p.purchase_datetime, '%Y-%m-01') AS purchase_month,
  AVG(p.total_amount) AS avg_monthly_spend
FROM Purchases p
GROUP BY p.household_id, purchase_month;

CREATE VIEW household_annual_spend AS
SELECT
  household_id,
  AVG(avg_monthly_spend) * 12 AS estimated_annual_spend
FROM monthly_household_spend
GROUP BY household_id;