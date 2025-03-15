# Explain Cron Expression

AI is very helpful in explaining cron expressions. In the example a cron expression for Spring Scheduling will be used. Important to notice is that Spring Scheduling cron expressions have an additional component to define the seconds. This is different from a regular crontab cron expression.

An example of a cron expression is available in this [file](sources/cron-1.properties)

## Setup
Ollama, qwen2.5-coder, CPU

## Prompt
Open the file, select the cron expression and enter the prompt.
```text
/explain
```
This expands to the following prompt.
```text
Break down the code in simple terms to help a junior developer grasp its functionality.
```

## Response
The response can be viewed [here](responses/1-explain-cron.md)

## Response Analysis
It is recognized that it is a cron expression, but the explanation is not correct because this is a valid Spring Scheduling cron expression. However, the LLM assumed this was a crontab cron expression.

## Prompt
Let's give the LLM a bit more context.

Remain in the same chat window and enter the prompt.
```text
explain the selected Spring Scheduling cron expression
```

## Response
The response can be viewed [here](responses/2-explain-cron.md)

## Response Analysis
The response is correct this time besides the summary. So, by adding the information that it is about a Spring Scheduling cron expression, the LLM was able to explain it correctly.

Always beware that you should provide enough context to the LLM, otherwise responses will not be what you would expect.