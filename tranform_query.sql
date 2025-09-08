CREATE OR REPLACE TABLE `teak-vent-471410-p8.Bank_Syariah_Scraping.reviews_bank_syariah_cleaned` AS
SELECT
  review_id,
  TRIM(user_name) AS user_name,
  user_image,
  TRIM(review_content) AS review_content,
  CAST(rating_score AS INT64) AS rating_score,
  IFNULL(thumbs_up_count, 0) AS thumbs_up_count,
  IFNULL(review_created_version, 'unknown') AS review_created_version,
  TIMESTAMP(review_timestamp) AS review_timestamp,
  TRIM(reply_content) AS reply_content,
  TIMESTAMP(replied_at) AS replied_at,
  IFNULL(app_version, 'unknown') AS app_version,
  app_name,

  -- kolom turunan
  LENGTH(review_content) AS review_length,
  CASE
    WHEN rating_score >= 4 THEN 'positive'
    WHEN rating_score = 3 THEN 'neutral'
    WHEN rating_score BETWEEN 1 AND 2 THEN 'negative'
    ELSE 'unknown'
  END AS sentiment_label,

  -- lama respon (dalam jam)
  TIMESTAMP_DIFF(replied_at, review_timestamp, HOUR) AS response_time_hours,


FROM `teak-vent-471410-p8.Bank_Syariah_Scraping.reviews_bank_syariah`;
