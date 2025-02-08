# Generate Cron Expression

This readme is the original version. Here I found out that there is a difference in the quality of the results when using CPU or GPU using the same LLM. The conclusion is that GPU provides better results than CPU.

This readme is only for reference purposes.

---

AI is very helpful in explaining cron expressions. But is it able to generate Spring Scheduling cron expressions as well?

## Setup
Ollama, qwen2.5-coder, CPU

## Prompt
Enter the prompt.
```text
generate a spring scheduling cron expression which runs every 3 days at 0 AM, but not on Sundays
```

## Response

---

To generate a Spring Scheduling cron expression that runs every 3 days at 0 AM but not on Sundays, you can use the following expression:

```cron
0 0 */3 ? * MON-FRI
```

### Explanation:
- `0`: This specifies the minute. In this case, it's set to 0, meaning the task will run at the start of every hour.
- `0`: This specifies the hour. The task will run at 0 AM (midnight).
- `*/3`: This specifies the day of the month. The task will run every 3 days.
- `?`: This is a special character that indicates no specific value for the day of the week, allowing the cron expression to be valid even though it includes both day-of-month and day-of-week fields.
- `*`: This specifies the month. The task will run every month.
- `MON-FRI`: This specifies the day of the week. The task will not run on Sundays.

This cron expression ensures that the scheduled task runs at 0 AM every 3 days, excluding Sundays.

---

## Response Analysis
The response is not correct:
* Spring cron expression start with seconds
* Also Saturdays are excluded, this was not asked

## Prompt
Let's tell the LLM what was wrong.

Enter the prompt.
```text
this looks like a crontab expression, I do need a cron expression for Spring Scheduling and the cron expression also need to run on saturdays, which is now excluded
```

## Response

---

To generate a Spring Scheduling cron expression that runs every 3 days at 0 AM and includes Saturdays, you can use the following expression:

```cron
0 0 */3 * MON-SAT
```

### Explanation:
- `0`: This specifies the minute. In this case, it's set to 0, meaning the task will run at the start of every hour.
- `0`: This specifies the hour. The task will run at 0 AM (midnight).
- `*/3`: This specifies the day of the month. The task will run every 3 days.
- `*`: This specifies the month. The task will run every month.
- `MON-SAT`: This specifies the day of the week. The task will run on Mondays, Tuesdays, Wednesdays, Thursdays, Fridays, and Saturdays.

This cron expression ensures that the scheduled task runs at 0 AM every 3 days, including both Sundays and Saturdays.

---

## Response Analysis
Saturday is included now, but still, this cron expression is not correct. The seconds are still missing. The summary tells us that the task will also run on Sundays, which is not correct.

## Prompt
Last attempt using a CPU, but explicitly mentioning Spring Boot.

```text
is this cron expression valid for spring boot?
```

## Response

---

Yes, the cron expression `0 0 */3 * MON-SAT` is valid for Spring Boot. This expression schedules a task to run at 0 AM every 3 days, including both Sundays and Saturdays.

Here's a breakdown of the cron expression:

- `0`: This specifies the minute. In this case, it's set to 0, meaning the task will run at the start of every hour.
- `0`: This specifies the hour. The task will run at 0 AM (midnight).
- `*/3`: This specifies the day of the month. The task will run every 3 days.
- `*`: This specifies the month. The task will run every month.
- `MON-SAT`: This specifies the day of the week. The task will run on Mondays, Tuesdays, Wednesdays, Thursdays, Fridays, and Saturdays.

This cron expression ensures that the scheduled task runs at 0 AM every 3 days, including both Sundays and Saturdays.

---

## Response Analysis
It still fails. This is interesting because the LLM was able to explain the cron expression [earlier](../explain-cron/README.md).

To conclude with: the cron expression is correct besides that the seconds are missing.

## Prompt
Let's try this with a different setup: LMStudio, qwen2.5-coder, GPU

Enter the prompt.
```text
generate a spring scheduling cron expression which runs every 3 days at 0 AM, but not on Sundays
```

## Response

---

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

---

## Response Analysis
This time the LLM does know how to format a valid Spring Scheduling cron. The cron expression will run always on Monday, Wednesday, Friday and Saturday. That is not what we meant, because when it runs on Friday, it should not run on Saturday.

## Prompt
Write a follow-up prompt.
```text
It will run always on Friday and Saturday, this is not every 3 days. The task should only run every 3 days, excluding (thus skipping) Sundays.
```

## Response

---

To generate a Spring Scheduling cron expression that runs every 3 days at 0 AM, but not on Sundays, you can use the following expression:

```cron
0 0 */3 ? * MON,WED,FRI,SAT
```

Explanation:
- `0` seconds (fixed)
- `0` minutes (fixed)
- `0` hours (midnight)
- `?` day of month (not specified, as we are using day of week)
- `*` month (every month)
- `MON,WED,FRI,SAT` days of the week (Monday, Wednesday, Friday, Saturday)

This cron expression ensures that the task runs every 3 days starting from the next available day after a Sunday.

---

## Response Analysis
No real improvement, the expression has changed in such a way that it now runs every three hours. The explanation the LLM gives, does not correspond to this new cron expression.

Using a GPU improves the results compared to using a CPU, but the end result is not entirely correct.