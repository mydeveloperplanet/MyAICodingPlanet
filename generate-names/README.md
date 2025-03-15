# Generate Names

AI can be very helpful with generating names for methods, classes, variables, etc. Take the [Refactor.java](../refactor-code/sources/src/main/java/com/mydeveloperplanet/refactor/Refactor.java) Java class and open it.

## Setup
LMStudio, qwen2.5-coder, GPU

## Prompt
Open the file and enter the following prompt.
```text
give 3 suggestions for a better method name for the parseData methods
```

## Response
The response can be viewed [here](responses/1-generate-names.md)

## Response Analysis
These are quite good suggestions.

## Prompt
Let's find out whether a better name for the class can be found.

Open the file and enter the following prompt.
```text
give 3 suggestions for a better class name for the Refactor.java class
```

## Response
The response can be viewed [here](responses/2-generate-names.md)

## Response Analysis
Not bad suggestions.

## Prompt
Now enter the same prompt, but change the temperature to 0.7 in the DevoxxGenie LLM settings. This instructs the LLM to be more creative.

Open the file and enter the following prompt.
```text
give 3 suggestions for a better class name for the Refactor.java class
```

## Response
The response can be viewed [here](responses/3-generate-names.md)

## Response Analysis
For some reason, the response is very short now. But the suggestions seem to be better than with a temperature of 0.