WITH cte AS (
    select 
        TO_TIMESTAMP(STARTED_AT),
        DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
        HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_START_AT,
        DAYNAME(TO_TIMESTAMP(STARTED_AT)) AS DAY_STARTED_AT,
        CASE 
            WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) IN ('Sat','Sun')
                THEN 'WEEKEND' 
            ELSE 'BUSINESS DAY'
        END AS DAY_TYPE,
        CASE 
            WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (12,1,2)
                THEN 'WINTER'
            WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (3,4,5)
                THEN 'SPRING'
            WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (6,7,8)
                THEN 'SUMMER'
            ELSE 'AUTTUM'
        END AS SATION_OF_YEAR
    from {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'

)
SELECT * FROM cte