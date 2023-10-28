
import {FC} from 'react';
import { CoordinateType } from 'utils/types';

export interface ITripInfo {
    coordinates: CoordinateType;
    energyLevel: number
}

const TripInfo:FC<ITripInfo> = ({ coordinates, energyLevel }) => {
    return (
        <div></div>
    )
}

export default TripInfo;