with series as (
select to_date('20210101','YYYYMMDD')  +interval '1 day' * generate_series  as dt from generate_series(0,400,1)),
federal_holiday as (
select to_date('20210101','YYYYMMDD') holiday_dt, 'AL' as holiday_description
)
select to_char(dt,'YYYYMMDD')::bigint date_id,
dt as date,
to_char(dt,'day') as date_of_week,
case when lower(to_char(dt,'day')) = 'saturday' or  lower(to_char(dt,'day')) = 'sunday' or  federal_holiday.holiday_dt is not null then 'Y'
else 'N' end is_business_day,
case when federal_holiday.holiday_dt is not null then 'Y'
else 'N' end is_federal_holiday,
federal_holiday.holiday_description
from series left outer join federal_holiday on series.dt=federal_holiday.holiday_dt
