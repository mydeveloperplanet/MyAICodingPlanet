To create a Spring Scheduling cron expression that runs every 3 days at 0 AM but not on Sundays, you can use the following expression:

```cron
0 0 0 ? * MON,WED,FRI,SAT
```

Explanation:
- `0` seconds (fixed)
- `0` minutes (fixed)
- `0` hours (midnight)
- `?` day of month (not specified, as we are using day of week)
- `*` month (every month)
- `MON,WED,FRI,SAT` days of the week (Monday, Wednesday, Friday, Saturday)

This cron expression ensures that the task runs every 3 days starting from the next available day after a Sunday.