package com.mydeveloperplanet.refactor;

import java.util.HashMap;
import java.util.Map;

public class DataRepository {

    private HashMap<Long, SingleDataDto> singleDataRepository = new HashMap<>(Map.of(
            0L, new SingleDataDto(DataType.TYPE1),
            1L, new SingleDataDto(DataType.TYPE2),
            2L, new SingleDataDto(DataType.TYPE3)
    ));

    private HashMap<Long, MultiDataDto> multiDataRepository = new HashMap<>();

    public SingleDataDto findSingleData(Long id) throws RepositoryException {
        // Some code to find SingleData objects
        return singleDataRepository.get(id);
    }

    public MultiDataDto findMultiData(Long id) throws RepositoryException {
        // Some code to find MultiData objects
        return new MultiDataDto();
    }

}
