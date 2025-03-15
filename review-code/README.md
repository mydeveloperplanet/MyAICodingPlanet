# Review Code

AI can be very helpful during code reviews. Take this [db.yml](sources/db.yml) which is a Kubernetes deployment file taken from the [Spring Petclinic](https://github.com/spring-projects/spring-petclinic/blob/main/k8s/db.yml)

When you take a look at this file, you can see some issues with it:
* the secret is hardcoded
* no resource limits are added
* the liveness and readiness probes are not quite ok

## Setup
Ollama, qwen2.5-coder, CPU

## Prompt
Open the db.yml file and use the following prompt
```text
/review
```
This expands to the following prompt.
```text
Review the selected code, can it be improved or are there any bugs?
```

## Response
The response can be viewed [here](responses/1-review-code.md)

## Response Analysis
The response is correct. However, an additional question arises:
_A comment is made about **Secret Management**, but not how this can be solved._

So, apply the suggested changes, they are located in file [db-review.yml](sources/db-review.yml).

## Prompt
Open this file and enter a follow-up prompt in the same chat window (this way, the chat memory is sent to the LLM)
```text
the secrets are hardcoded, I want to change this in order to adhere security best practices, what should be changed
```

## Response
The response can be viewed [here](responses/2-review-code.md)

## Response Analysis
The response is correct, although the db.yml file still contains a Secret section with the hardcoded values. This section should have been left out.

So, apply the suggested changes, they are located in file [db-secret.yml](sources/db-secret.yml) and remove the Secrets section.