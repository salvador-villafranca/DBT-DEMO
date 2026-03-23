WITH daily_weather as (
    select 
        date(time) as daily_weather,
        weather,
        temp,
        pressure,
        humidity,
        clouds
    from {{ source('demo', 'weather') }}
    limit 10
),
daily_weather_agg as (
    select 
            daily_weather,
            weather,
            --count(weather),
            --ROW_NUMBER() OVER (PArtition BY daily_weather ORDER BY COUNT(weather) DESC )  AS row_number
            round(avg(temp),2) AS avg_temp,
            round(avg(pressure),2) AS avg_pressure,
            round(avg(humidity),2) AS avg_humidity,
            round(avg(clouds),2) AS avg_clouds
    from daily_weather
    group by daily_weather, weather

    qualify ROW_NUMBER() OVER (PArtition BY daily_weather ORDER BY COUNT(weather) DESC ) =1
)
select 
*
from daily_weather_agg