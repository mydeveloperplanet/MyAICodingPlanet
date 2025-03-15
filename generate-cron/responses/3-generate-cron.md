To generate a Spring Scheduling cron expression that runs every 3 days at 0 AM and skips Sundays, you can use the following expression:

```cron
0 0 0 ? * MON,WED,FRI
```

This cron expression breaks down as follows:
- `0` seconds
- `0` minutes
- `0` hours (midnight)
- `?` day of the month (no specific day, use `?`)
- `*` month (every month)
- `MON,WED,FRI` days of the week (Monday, Wednesday, and Friday)

This ensures that the task runs every 3 days starting from a Monday.