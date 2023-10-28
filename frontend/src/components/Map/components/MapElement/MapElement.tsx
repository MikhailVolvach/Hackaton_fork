import {FC, useCallback} from 'react';
import classNames   from "classnames";
import chroma from 'chroma-js';

import s from './MapElement.module.scss';
import {CellCoordinateType} from "utils/types";

export interface IMapElement {
    className?: string;
    value: number;
    onClick: (coord: CellCoordinateType) => void;
    coord: CellCoordinateType;
}

const MapElement: FC<IMapElement> = ({ className = '', value = 0, onClick, coord}) => {
    const cn = classNames(className, s.element);

    const color = chroma.scale(['#ffffff', '#a1251b']).domain([0, 100])(value).hex();

    const landscapeColor = {
        backgroundColor: color,
    }

    const handleClick = useCallback(() => {
        onClick(coord);
    }, [])

    return (
        <div className={cn} style={landscapeColor} onClick={handleClick}></div>
    )
}

export default MapElement;