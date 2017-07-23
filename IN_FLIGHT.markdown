select median(value) from light WHERE time > now() - 60m;

(current_luminance - luminance_delta / 2) .. (current_luminance + luminance_delta / 2)
