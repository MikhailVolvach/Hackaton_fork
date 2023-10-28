import React, { useCallback } from 'react';

import Map from 'components/Map';
import { CellCoordinateType } from 'utils/types';

import s from './MapPage.module.scss';

import 'swiper/scss/scrollbar';
import InfoPanel from './components/InfoPanel';
import Controls from './components/Controls';
import TripInfo from './components/TripInfo/TripInfo';

const MapPage = () => {
  const handleCellClick = useCallback((coord: CellCoordinateType) => {
    console.log(coord);
  }, []);

  const handleControlClick = useCallback((e: MouseEvent) => {
    console.log(e?.target?.dataset?.direction);
  }, []);

  return (
    <div className={s.mapPage}>
      <div className={s.mapPage__container}>
        <div className={s.mapPage__col_left}>
            <TripInfo coordinates={{
                      x: 0,
                      y: 0
                  }} energyLevel={67} />
        </div>
        <div className={s.mapContent}>
            <Map onClick={handleCellClick} />
        </div>
        <div className={s.mapPage__col_right}>
            <InfoPanel energyLevel={67} />
            <Controls onClick={handleControlClick}/>
        </div>
      </div>
    </div>
  );
};

export default MapPage;
