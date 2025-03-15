# Refactor Code

Can AI assist you in refactoring code? Take a look at method `processMessage` in class [Refactor.java](sources/src/main/java/com/mydeveloperplanet/refactor/Refactor.java)

This code screams for refactoring. Let's see how AI can help us with that.

## Setup
LMStudio, qwen2.5-coder, GPU

## Prompt
Add the entire code directory to the Prompt Context and open the Refactor class.

```text
/review
```
This expands to the following prompt.
```text
Review the selected code, can it be improved or are there any bugs?
```

## Response
The response can be viewed [here](responses/1-refactor-code.md)

## Response Analysis
Some general improvements are suggested, but overall the code did not improve a lot.

## Prompt
Open a new chat window and add the source directory as Prompt Context again. Provide more clear instructions of what you expect. This is based on [AI-Assisted Software Development](https://aalapdavjekar.medium.com/ai-assisted-software-development-a-comprehensive-guide-with-practical-prompts-part-3-3-a5dbc2ee45e3)

```text
Please review the following code for quality and potential issues: Refactor.processMessage(RefactorMessage refactorMessage) 
In your review, please consider: 
1. Code style and adherence to best practices 
2. Potential bugs or edge cases not handled 
3. Performance optimizations 
4. Security vulnerabilities 
5. Readability and maintainability 

For each issue found, please: 
1. Explain the problem 
2. Suggest a fix 
3. Provide a brief rationale for the suggested change 

Additionally, are there any overall improvements or refactoring suggestions you would make for this code?
```

## Response
The response can be viewed [here](responses/2-refactor-code.md)

## Response Analysis
This response seems to be better:
1. It is seen that the method is too long and too complex, this is a good conclusion.
2. The input variable `refactorMessage` should be checked for `null`, this is correct.
3. The LLM suggests to use a `DateTimeFormatter` to parse the date, but in this specific situation, this is not applicable. The `occurrenceTime` is a range separated by a slash, e.g. "2014-03-01T13:00:00Z/2015-05-11T15:30:00Z".
4. It suggests to validate the input data, which is a good suggestion. 
5. A suggestion is given to use early returns, but the fix given is already present in the code.
6. Also overall improvements and suggestions are given (e.g. to write unit tests).

## Prompt
The most interesting suggestion is to break the code down into smaller, more manageable methods. However, no real fix was suggested. So, let's enter a follow-up prompt.

```text
Break the method down into smaller more manageable methods
```

## Response
The response can be viewed [here](responses/3-refactor-code.md)

## Response Analysis
The suggested code is not entirely correct.
1. `findSingleData` and `findMultiData` are not exactly improvements.
2. `parseOccurrenceTime` is not parsing the same way as in the original code.
3. `parseLocation` makes uses of a constructor with arguments which does not exist.
4. `parseData` makes also use of constructors with arguments which do not exist.
However, the overall simplification and readability improvements do make sense.

## Prompt
Let's use Anthropic Claude 3.5 Sonnet to verify whether a cloud LLM is able to produce better results.
Add the entire code directory to the Prompt Context and open the Refactor class.
```text
Please review the following code for quality and potential issues: Refactor.processMessage(RefactorMessage refactorMessage)
In your review, please consider:
1. Code style and adherence to best practices 
2. Potential bugs or edge cases not handled 
3. Performance optimizations 
4. Security vulnerabilities 
5. Readability and maintainability

For each issue found, please:
1. Explain the problem 
2. Suggest a fix 
3. Provide a brief rationale for the suggested change

Additionally, are there any overall improvements or refactoring suggestions you would make for this code?
```

## Response
The response can be viewed [here](responses/4-refactor-code.md)

## Response Analysis
1. Complex conditional logic, this is correct and should be changed.
2. The method is too long and should be split into smaller methods, that is correct.
3. Some problems with null references and input validation are found, that is correct.
4. Some overall suggestions are given.
Overall, the suggestions are of a similar level compared to a local LLM.

## Overall Conclusion
AI can give good suggestions and improvements for existing code. However, the code cannot be taken as-is into your code base. It is better to apply some of the suggestions yourself and prompt again to see whether the code has improved.

The suggestions between a cloud provider or a local LLM running on a GPU do not differ very much from each other.