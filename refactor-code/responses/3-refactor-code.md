Certainly! Breaking down the `Refactor.processMessage(RefactorMessage refactorMessage)` method into smaller, more manageable methods will improve readability and maintainability. Here's a refactored version of the method with several helper methods:

```java
private void processMessage(RefactorMessage refactorMessage) {
    if (refactorMessage == null) {
        logger.error("RefactorMessage is null");
        return;
    }

    Long id = determineId(refactorMessage);
    boolean isMultiData = refactorMessage.getSingleData() == null;

    BaseMessage baseMessage = parseBaseMessage(id, isMultiData, refactorMessage);

    if (baseMessage != null) {
        latestMessages.put(baseMessage.getDataType(), baseMessage);
        messageService.sendMessage(baseMessage);
    }
}

private Long determineId(RefactorMessage refactorMessage) {
    if (refactorMessage.getSingleData() != null) {
        return refactorMessage.getSingleDataId();
    } else {
        return refactorMessage.getMultiDataId();
    }
}

private BaseMessage parseBaseMessage(Long id, boolean isMultiData, RefactorMessage refactorMessage) {
    try {
        Instant occurrenceTime = parseOccurrenceTime(refactorMessage);
        SingleDataDto singleDataDto = findSingleData(id, isMultiData);
        MultiDataDto multiDataDto = findMultiData(id, isMultiData);

        if (singleDataDto != null && singleDataDto.getDataType().equals(DataType.TYPE1.getValue()) && refactorMessage.getResult() instanceof HashMap) {
            return parseLocation(occurrenceTime, refactorMessage, singleDataDto);
        } else if (!isMultiData) {
            return parseData(occurrenceTime, refactorMessage, singleDataDto);
        } else {
            return parseData(occurrenceTime, refactorMessage, multiDataDto);
        }
    } catch (RepositoryException e) {
        logger.error("Connection with repository failed id: {}", id, e);
        return null;
    }
}

private Instant parseOccurrenceTime(RefactorMessage refactorMessage) throws RepositoryException {
    if (refactorMessage.getOccurrenceTime() == null || !refactorMessage.getOccurrenceTime().matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}")) {
        logger.error("Invalid occurrence time format");
        throw new RepositoryException("Invalid occurrence time format");
    }
    return Instant.parse(refactorMessage.getOccurrenceTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
}

private SingleDataDto findSingleData(Long id, boolean isMultiData) throws RepositoryException {
    if (isMultiData) {
        return dataRepository.findMultiData(id);
    } else {
        return dataRepository.findSingleData(id);
    }
}

private MultiDataDto findMultiData(Long id, boolean isMultiData) throws RepositoryException {
    if (!isMultiData) {
        return new MultiDataDto();
    } else {
        return dataRepository.findMultiData(id);
    }
}

private LocationMessage parseLocation(Instant occurrenceTime, RefactorMessage refactorMessage, SingleDataDto singleDataDto) {
    try {
        String geoJsonString = OBJECT_MAPPER.writeValueAsString(refactorMessage.getResult());
        GeoJsonObject geoJson = OBJECT_MAPPER.readValue(geoJsonString, GeoJsonObject.class);
        return new LocationMessage(singleDataDto.getDataType(), occurrenceTime, geoJson);
    } catch (JsonProcessingException e) {
        logger.error("Something went wrong with mapping to GeoJson, not processing location", e);
        return null;
    }
}

private SingleDataMessage parseData(Instant occurrenceTime, RefactorMessage refactorMessage, BaseDataDto baseDataDto) {
    if (baseDataDto instanceof SingleDataDto) {
        return new SingleDataMessage((SingleDataDto) baseDataDto, occurrenceTime);
    } else if (baseDataDto instanceof MultiDataDto) {
        return new MultiDataMessage((MultiDataDto) baseDataDto, occurrenceTime);
    }
    return null;
}
```

### Explanation of Changes

1. **`determineId(RefactorMessage refactorMessage)`**: Determines the ID based on whether `singleData` or `multiData` is present.
2. **`parseBaseMessage(Long id, boolean isMultiData, RefactorMessage refactorMessage)`**: Parses the base message and handles the logic for determining the type of message to create.
3. **`parseOccurrenceTime(RefactorMessage refactorMessage)`**: Parses the occurrence time and validates its format.
4. **`findSingleData(Long id, boolean isMultiData)`**: Finds the single data based on whether `isMultiData` is true or false.
5. **`findMultiData(Long id, boolean isMultiData)`**: Finds the multi data based on whether `isMultiData` is true or false.
6. **`parseLocation(Instant occurrenceTime, RefactorMessage refactorMessage, SingleDataDto singleDataDto)`**: Parses the location message.
7. **`parseData(Instant occurrenceTime, RefactorMessage refactorMessage, BaseDataDto baseDataDto)`**: Parses the data message based on whether it's a `SingleDataDto` or `MultiDataDto`.

By breaking down the method into smaller methods, each with a single responsibility, the code becomes more readable and maintainable.