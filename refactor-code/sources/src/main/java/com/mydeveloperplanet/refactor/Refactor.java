package com.mydeveloperplanet.refactor;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.geojson.GeoJsonObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Refactor {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private static final Logger logger = LoggerFactory.getLogger(Refactor.class);
    private final DataRepository dataRepository = new DataRepository();
    private final Map<DataType, BaseMessage> latestMessages = new HashMap<>();
    private final MessageService messageService = new MessageService();

    public static void main(String[] args) {
        Refactor refactor = new Refactor();

        Map<String, Object> singleMap = new HashMap<>(Map.of(
                "key1", "value1",
                "key2", "value2"
        ));
        RefactorMessage singleDataRefactorMessage = new RefactorMessage(singleMap, 0L, null, null, "2025-01-12 00:00", new HashMap<>());
        refactor.processMessage(singleDataRefactorMessage);

        Map<String, Object> multiMap = new HashMap<>(Map.of(
                "key1", "value1",
                "key2", "value2"
        ));
        RefactorMessage multiDataRefactorMessage = new RefactorMessage(null, null, multiMap, 0L, "2025-01-12 00:00", new Object());
        refactor.processMessage(multiDataRefactorMessage);

    }

    private void processMessage(RefactorMessage refactorMessage) {
        Long id;
        boolean isMultiData = false;
        if (refactorMessage.getSingleData() != null) {
            id = refactorMessage.getSingleDataId();
        } else {
            id = refactorMessage.getMultiDataId();
            isMultiData = true;
        }

        SingleDataDto singleDataDto = null;
        MultiDataDto multiDataDto = null;
        try {
            if (isMultiData) {
                multiDataDto = dataRepository.findMultiData(id);
            } else {
                singleDataDto = dataRepository.findSingleData(id);
            }
        } catch (RepositoryException e) {
            logger.error("Connection with repository failed id: {}", id, e);
            return;
        }

        Instant occurrenceTime = Instant.parse(refactorMessage.getOccurrenceTime().substring(0, refactorMessage.getOccurrenceTime().indexOf("/")));

        BaseMessage baseMessage = null;

        if ((!isMultiData) && singleDataDto != null && singleDataDto.getDataType().equals(DataType.TYPE1.getValue()) && refactorMessage.getResult() instanceof HashMap) {
            baseMessage = parseLocation(occurrenceTime, refactorMessage, singleDataDto);
        } else if (!isMultiData) {
            baseMessage = parseData(occurrenceTime, refactorMessage, singleDataDto);
        } else {
            baseMessage = parseData(occurrenceTime, refactorMessage, multiDataDto);
        }

        if (baseMessage != null) {
            latestMessages.put(baseMessage.getDataType(), baseMessage);
            messageService.sendMessage(baseMessage);
        }
    }

    private LocationMessage parseLocation(Instant occurrenceTime, RefactorMessage refactorMessage, SingleDataDto singleDataDto) {
        LocationMessage locationMessage = new LocationMessage();

        GeoJsonObject geoJson;
        try {
            String geoJsonString = OBJECT_MAPPER.writeValueAsString(refactorMessage.getResult());
            geoJson = OBJECT_MAPPER.readValue(geoJsonString, GeoJsonObject.class);
        } catch (JsonProcessingException e) {
            logger.error("Something went wrong with mapping to GeoJson, not processing location", e);
            return null;
        }

        locationMessage.setDataType(singleDataDto.getDataType());
        locationMessage.setOccurrenceTime(occurrenceTime);
        locationMessage.setGeoJson(geoJson);

        return locationMessage;
    }

    private SingleDataMessage parseData(Instant occurenceTime, RefactorMessage refactorMessage, SingleDataDto singleDataDto) {
        SingleDataMessage singleDataMessage = new SingleDataMessage();
        singleDataMessage.setDataType(singleDataDto.getDataType());
        singleDataMessage.setOccurrenceTime(occurenceTime);
        return singleDataMessage;
    }

    private MultiDataMessage parseData(Instant occurenceTime, RefactorMessage refactorMessage, MultiDataDto multiDataDto) {
        MultiDataMessage multiDataMessage = new MultiDataMessage();
        multiDataMessage.setDataType(multiDataDto.getDataType());
        multiDataMessage.setOccurrenceTime(occurenceTime);
        return multiDataMessage;
    }

}
