package com.mydeveloperplanet.refactor;

public class SingleDataDto {

    private DataType dataType;

    public SingleDataDto() {}

    public SingleDataDto(DataType dataType) {
        this.dataType = dataType;
    }

    public DataType getDataType() {
        return dataType;
    }

    public void setDataType(DataType dataType) {
        this.dataType = dataType;
    }
}
