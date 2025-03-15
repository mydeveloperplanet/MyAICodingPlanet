# Explain k8s yaml

AI can be very helpful in explaining code. Take the Kubernetes [db-secrets.yml](../review-code/sources/db-secrets.yml) file and open it.

The resources section is something I do not understand very well, especially not the units.

## Setup
Ollama, qwen2.5-coder, CPU

## Prompt
Open the file, select the resources section and open a new chat window. Enter the following prompt.
```text
/explain
```
This expands to the following prompt.
```text
Break down the code in simple terms to help a junior developer grasp its functionality.
```

## Response
The response can be viewed [here](responses/1-explain-k8s)

## Response Analysis
The response is correct, but what is a Mebibyte?

## Prompt
Remain in the same chat window and enter the following prompt.
```text
how much RAM is 64Mi and what is a mebibyte
```

## Response
The response can be viewed [here](responses/2-explain-k8s)

## Response Analysis
The response is correct and the explanation accurately defines a Mebibyte.