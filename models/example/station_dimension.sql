WITH bike AS(
    select 
        distinct
        start_statio_id as start_station_id,
        start_station_name,
        start_lat,
        start_lng
    from   {{ ref('stage_bike') }}
    where ride_id != 'ride_id'
    --limit 10
)
select *
from bike   