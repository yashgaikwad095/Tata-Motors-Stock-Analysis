# Tata Motors Stock Performance Analysis (2006–2024)

Daily stock price data (4,233 rows, Dec 2006 – Jan 2024) analyzed entirely in SQL
(MySQL) using Window Functions — no external tool needed for the analysis layer,
demonstrating SQL as a standalone analytical tool, not just a storage/retrieval layer.

## Dataset

`tata_motors_stock` table — Date, Open, High, Low, Close, Adj Close, Volume.
Sourced from Yahoo Finance historical data (NSE: TATAMOTORS).

## Tech & Techniques Used

- **Window Functions:** `LAG()` for day-over-day % change, `AVG() OVER (ROWS BETWEEN
  ... PRECEDING)` for 7-day and 30-day moving averages
- **Aggregation:** `GROUP BY YEAR()` for year-wise trend analysis
- **Correlated subqueries** for first/last price comparison (total growth calc)

## Business Insights

**1. Overall Growth**
Stock grew **409.9%** from ₹161.52 (Dec 2006) to ₹823.55 (Jan 2024) — a ~5x return
over 17 years, though not a smooth climb (see crash events below).

**2. Major Crash Events Are Clearly Visible in the Data**
The 5 worst single-day drops line up with known macro/company events, not random
noise:
- **2008-10-23 (-16.44%) and 2008-10-24 (-14.74%):** 2008 global financial crisis
- **2020-03-23 (-14.36%):** COVID-19 market crash (same week markets crashed
  globally)
- **2019-02-08 (-17.58%):** Company-specific — coincides with Tata Motors/JLR
  reporting large losses that quarter
This confirms the data is reliable — it reflects real market history, not
artifacts of a bad download.

**3. 2009 Was the Recovery Bottom, Then a Multi-Year Climb**
Year-wise average closing price bottomed out in **2009 (₹76.38)** — the low point
after the 2008 crash — before recovering. More recently, the stock went from a
**2020 average of ₹129.6 to a 2024 average of ₹803.47** (~6x in 4 years, coinciding
with the post-COVID EV/auto sector rally), a much steeper climb than the broader
17-year trend suggests.

**4. January 2021 Was an Unusually High-Activity Period**
The 10 highest-volume trading days all cluster in **January 2021**, several with
large positive returns (up to +15.16% in a single day) — a sign of a major
company/sector announcement or rally that a business stakeholder would want
flagged and investigated further, rather than treated as routine trading noise.

## Data Quality Notes

- 7 of 4,233 rows (0.17%) had a missing Close price — excluded from day-over-day
  return calculations via `WHERE Close IS NOT NULL`
- "7-day" and "30-day" moving averages are in **trading days**, not calendar days
  (markets are closed weekends/holidays) — standard convention in stock analysis
- 2024 figures reflect a partial year (data ends Jan 19, 2024) — not a full-year
  average, noted to avoid a misleading year-over-year comparison
