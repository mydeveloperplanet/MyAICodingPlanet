package com.mydeveloperplanet.refactor;

public enum DataType {
    TYPE1("Value1"),
    TYPE2("Value2"),
    TYPE3("Value3");

    private final String value;

    DataType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
