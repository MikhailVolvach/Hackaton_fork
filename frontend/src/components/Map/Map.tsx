import {FC, memo, useCallback, useEffect, useState} from 'react';

import {v4 as uuidv4} from 'uuid';

import s from './Map.module.scss';
import {generateRandomArray} from "utils/TMPUtils/generateMap";

import MapElement from "components/Map/components/MapElement";
import {CellCoordinateType} from "utils/types";

import {apiUrl} from 'config/config';
import axios from 'axios';

export interface IMap {
    onClick?: (coord: CellCoordinateType) => void;
}

const Map: FC<IMap> = ({onClick = () => {}}) => {
    // const arrayMap = generateRandomArray(100, 100);
    const [arrayMap, setArrayMap] = useState<number[][]>([]);
    const mapGridStyle = {
        gridTemplateColumns: `repeat(${arrayMap.length}, 1fr)`,
        gridTemplateRows: `repeat(${arrayMap.length}, 1fr)`
    }

    const handleCellClick = useCallback((coord: CellCoordinateType) => {
        onClick(coord);
    }, [onClick])

    useEffect(() => {
        axios.get(`${apiUrl}/map/render`).then( response => {
            setArrayMap(response.data);
        })
    }, []);

    return (
        <div className={s.map}>
            <div className={s.map__grid} style={mapGridStyle}>
                {/* {arrayMap.map((line: CellCoordinateType[]) =>
                    line.map(
                        (elem: CellCoordinateType) =>
                            <MapElement
                            key={uuidv4()}
                            className={s.map__cell}
                            value={elem.value}
                            onClick={handleCellClick}
                            coord={elem}/>
                    )
                )} */}

                {arrayMap.map((line, i) => 
                    line.map((elem, j) => 
                        <MapElement
                                key={uuidv4()}
                                className={s.map__cell}
                                value={elem}
                                onClick={handleCellClick}
                                coord={{x: i, y: j, value: elem}}/>
                    )
                )}

                
            </div>
        </div>
    )
}

export default memo(Map);