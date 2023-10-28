import s from './Controls.module.scss';
import Arrow from 'img/arrow.png';
import classNames from 'classnames';
import { FC, useCallback } from 'react';

export interface IControls {
    onClick: (e: MouseEvent) => void;
}

const directions = [
    "forward", "back", "left", "right"
];

const Controls: FC<IControls> = ({ onClick }) => {

    return (
        <div className={s.controls}>
            <div onClick={(e) => onClick(e)} className={s.controls__container}>
                {directions.map(direction => <div className={s.controls__arrow} data-direction={direction}><img src={Arrow} alt="" data-direction={direction} /></div>)}
            </div>
        </div>
  );
};

export default Controls;
