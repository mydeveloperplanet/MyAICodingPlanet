package com.mydeveloperplanet.refactor;

import java.util.Map;

public class RefactorMessage {

    private Map<String, Object> singleData;
    private Long singleDataId;
    private Map<String, Object> multiData;
    private Long multiDataId;
    private String occurrenceTime;
    private Object result;

    public RefactorMessage(Map<String, Object> singleData, Long singleDataId, Map<String, Object> multiData, Long multiDataId, String occurrenceTime, Object result) {
        this.singleData = singleData;
        this.singleDataId = singleDataId;
        this.multiData = multiData;
        this.multiDataId = multiDataId;
        this.occurrenceTime = occurrenceTime;
        this.result = result;
    }

    public Map<String, Object> getSingleData() {
        return singleData;
    }

    public void setSingleData(Map<String, Object> singleData) {
        this.singleData = singleData;
    }

    public Map<String, Object> getMultiData() {
        return multiData;
    }

    public void setMultiData(Map<String, Object> multiData) {
        this.multiData = multiData;
    }

    public Long getSingleDataId() {
        return singleDataId;
    }

    public void setSingleDataId(Long singleDataId) {
        this.singleDataId = singleDataId;
    }

    public Long getMultiDataId() {
        return multiDataId;
    }

    public void setMultiDataId(Long multiDataId) {
        this.multiDataId = multiDataId;
    }

    public String getOccurrenceTime() {
        return occurrenceTime;
    }

    public void setOccurrenceTime(String occurrenceTime) {
        this.occurrenceTime = occurrenceTime;
    }

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }
}
