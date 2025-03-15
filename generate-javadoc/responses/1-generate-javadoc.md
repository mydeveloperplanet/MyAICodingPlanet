```java
/**
 * The Refactor class is responsible for processing messages and generating appropriate data objects.
 */
public class Refactor {

    /**
     * The ObjectMapper instance used for JSON processing.
     */
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    /**
     * The logger instance for logging messages.
     */
    private static final Logger logger = LoggerFactory.getLogger(Refactor.class);

    /**
     * The data repository instance for accessing data.
     */
    private final DataRepository dataRepository;

    /**
     * A map to store the latest messages by their data type.
     */
    private final Map<DataType, BaseMessage> latestMessages;

    /**
     * The message service instance for sending messages.
     */
    private final MessageService messageService;

    /**
     * Constructs a new Refactor instance with default dependencies.
     */
    public Refactor() {
        this.dataRepository = new DataRepository();
        this.latestMessages = new HashMap<>();
        this.messageService = new MessageService();
    }

    /**
     * Main method to demonstrate the functionality of the Refactor class.
     *
     * @param args Command line arguments (not used).
     */
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

    /**
     * Processes a message and generates appropriate data objects.
     *
     * @param refactorMessage The message to be processed.
     */
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
            baseMessage = parseData(occurenceTime, refactorMessage, singleDataDto);
        } else {
            baseMessage = parseData(occurenceTime, refactorMessage, multiDataDto);
        }

        if (baseMessage != null) {
            latestMessages.put(baseMessage.getDataType(), baseMessage);
            messageService.sendMessage(baseMessage);
        }
    }

    /**
     * Parses a location message from the given data.
     *
     * @param occurrenceTime The time when the event occurred.
     * @param refactorMessage The message containing the location data.
     * @param singleDataDto The data transfer object for single data.
     * @return A LocationMessage instance if parsing is successful, null otherwise.
     */
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

    /**
     * Parses a single data message from the given data.
     *
     * @param occurenceTime The time when the event occurred.
     * @param refactorMessage The message containing the data.
     * @param singleDataDto The data transfer object for single data.
     * @return A SingleDataMessage instance.
     */
    private SingleDataMessage parseData(Instant occurenceTime, RefactorMessage refactorMessage, SingleDataDto singleDataDto) {
        SingleDataMessage singleDataMessage = new SingleDataMessage();
        singleDataMessage.setDataType(singleDataDto.getDataType());
        singleDataMessage.setOccurrenceTime(occurenceTime);
        return singleDataMessage;
    }

    /**
     * Parses a multi data message from the given data.
     *
     * @param occurenceTime The time when the event occurred.
     * @param refactorMessage The message containing the data.
     * @param multiDataDto The data transfer object for multi data.
     * @return A MultiDataMessage instance.
     */
    private MultiDataMessage parseData(Instant occurenceTime, RefactorMessage refactorMessage, MultiDataDto multiDataDto) {
        MultiDataMessage multiDataMessage = new MultiDataMessage();
        multiDataMessage.setDataType(multiDataDto.getDataType());
        multiDataMessage.setOccurrenceTime(occurenceTime);
        return multiDataMessage;
    }
}
```