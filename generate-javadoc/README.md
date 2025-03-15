# Explain Java Code

AI can be very helpful generating javadoc. Take the [Refactor.java](../refactor-code/sources/src/main/java/com/mydeveloperplanet/refactor/Refactor.java) Java class and open it.

## Setup
LMStudio, qwen2.5-coder, GPU

## Prompt
Open the file and enter the following prompt.
```text
write javadoc for public classes and methods in order that it clearly explains its functionality
```

## Response
The response can be viewed [here](responses/1-generate-javadoc.md)

## Response Analysis
* The generated javadoc is correct
* The javadoc for the methods could be a bit more elaborate
* A constructor is added which was not asked to do so
* It was only asked to write javadoc for public classes and methods, but this instruction is ignored