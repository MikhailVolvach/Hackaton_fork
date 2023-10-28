import React, {useCallback} from 'react';

import {v4 as uuidv4} from 'uuid';

import s from './Map.module.scss';
import {generateRandomArray} from "utils/TMPUtils/generateMap";

import MapElement from "pages/Map/components/MapElement";
import {CoordinateType} from "utils/types";

const Map = () => {
    const arrayMap = generateRandomArray(100, 100);

    const handleCellClick = useCallback((coord: CoordinateType) => {
        console.log(coord);
    }, [])

    return (
        <div className={s.map}>
            <div className={s.map__grid}>
                {arrayMap.map((line: CoordinateType[]) =>
                    line.map(
                        (elem: CoordinateType) =>
                            <MapElement
                            key={uuidv4()}
                            className={s.map__cell}
                            value={elem.value}
                            onClick={handleCellClick}
                            coord={elem}/>
                    )
                )}
            </div>
        </div>
    )
}

export default Map;