InfluxDB query for median luminance of the last seconds:

use metrics
select median(value) from light WHERE time > now() - 60s;
