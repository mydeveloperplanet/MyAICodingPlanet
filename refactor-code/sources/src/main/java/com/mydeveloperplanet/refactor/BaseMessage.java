package com.mydeveloperplanet.refactor;

import java.time.Instant;

public class BaseMessage {
    private DataType dataType;
    private Instant occurrenceTime;

    public DataType getDataType() {
        return dataType;
    }

    public void setDataType(DataType dataType) {
        this.dataType = dataType;
    }

    public Instant getOccurrenceTime() {
        return occurrenceTime;
    }

    public void setOccurrenceTime(Instant occurrenceTime) {
        this.occurrenceTime = occurrenceTime;
    }
}
