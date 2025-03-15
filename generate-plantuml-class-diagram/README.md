# Generate PlantUML Class Diagram

Writing documentation can be a tedious task. Let's investigate whether AI can generate a PlantUML Class Diagram.

The goal is to create a database diagram according to [Class Diagram](https://plantuml.com/class-diagram)

## Setup
LMStudio, qwen2.5-coder, GPU

## Prompt
Add the [Refactor source directory](../refactor-code/sources/src) to the Prompt Context. Enter the prompt.

```text
Generate a plantuml class diagram for this code
```

# Response
The response can be viewed [here](responses/1-class-diagram.md)

## Response Analysis
The diagram is saved in [1-class-diagram.puml](responses/1-class-diagram.puml) and a png representation is located in [1-class-diagram.png](responses/1-class-diagram.png).

The response is quite good, but also some issues exist:
* The relations for the `Refactor` class are incomplete. Classes `RefactorMessage`, `SingleDataDto`, `MultiDataDto`, etc. are also used.
* The double relations between `BaseMessage` and `LocationMessage`, `MultiDataMessage`, `SingleDataMessage` are not correct. This should be a single relation.
* Methods and class variables are correct.
* The visibility of methods in class `Refactor` is not correct. Only the `main` method has public visibility and the others should be private.
* `DataType` is an enum and should have been marked as an enum.

## Prompt
These issues seem to be quite similar as in [Generate PlantUML from SQL](../generate-plantuml-from-sql/README.md).  

We know that AI coding assistants are good at reviewing code. So let's see whether the issues can be found.

Enter the prompt.

```text
Review the plant uml and give suggestions in order to improve it. It should ressemble the provided code.
```

## Response
The response can be viewed [here](responses/2-class-diagram.md)

## Response Analysis

The diagram is saved in [2-class-diagram.puml](responses/2-class-diagram.puml) and a png representation is located in [2-class-diagram.png](responses/2-class-diagram.png).

Some general suggestions are given. However, the only difference with the previous version, is that the relationship between `RefactorMessage` and `DataRepository`, `MessageService` has a label `uses`.

To conclude with, the classes are generated correctly besides the visibility. This saves you already a lot of time. The relations, visibility, etc. needs to be added or corrected after reviewing the PlantUML.
