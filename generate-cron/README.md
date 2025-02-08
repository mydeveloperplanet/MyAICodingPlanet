# Generate Cron Expression

AI is very helpful in explaining cron expressions. But is it able to generate Spring Scheduling cron expressions as well?

## Setup
LMStudio, qwen2.5-coder, GPU

## Prompt
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
The LLM does know how to format a valid Spring Scheduling cron expression. The cron expression will run always on Monday, Wednesday, Friday and Saturday. That is not what we meant, because when it runs on Friday, it should not run on Saturday.

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

## Prompt
This challenge is quite difficult because it is a tricky one: you want to run it every three days, but not on Sundays. But what to do when the next schedule would run on Sunday? Do you want it to just skip Sunday or do you want it to run the next day (meaning Monday)?

Let's try another prompt indicating that Sundays should be skipped. Create a new chat window in order to start anew.
```text
generate a spring scheduling cron expression which runs every 3 days at 0 AM, Sundays should be skipped.
```

## Response

---

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

---

## Response Analysis
This response is correct this time. And it also shows the problem it was struggling with: it depends in this case which day you want to start, so the LLM is able to create a cron expression which satisfies the requirements.

The conclusion here is that it does matter which words, phrasing you use in the prompt. And sometimes it is better to start anew with a new prompt instead of iterating on previous responses.