import {FC, useCallback} from 'react';

import {v4 as uuidv4} from 'uuid';

import s from './Map.module.scss';
import {generateRandomArray} from "utils/TMPUtils/generateMap";

import MapElement from "components/Map/components/MapElement";
import {CellCoordinateType} from "utils/types";

export interface IMap {
    onClick?: (coord: CellCoordinateType) => void;
}

const Map: FC<IMap> = ({onClick = () => {}}) => {
    const arrayMap = generateRandomArray(100, 100);

    const handleCellClick = useCallback((coord: CellCoordinateType) => {
        onClick(coord);
    }, [onClick])


    return (
        <div className={s.map}>
            <div className={s.map__grid}>
                {arrayMap.map((line: CellCoordinateType[]) =>
                    line.map(
                        (elem: CellCoordinateType) =>
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