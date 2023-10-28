import React, {FC} from 'react';
import s from './Card.module.scss';
import classNames from 'classnames';

export interface ICard {
    image: string;
    number: string;
    text: string;
    color: number;
}

const cardColors = {
    1: s.card_red,
    2: s.card_orange,
    3: s.card_green
}

const Card: FC<ICard> = ({image, number, text, color}) => {
    const cn = classNames(cardColors[color], s.card);

    return (
        <div className={cn}>
            <div className={s.card__container}>
                <div className={s.card__number}>
                    {number}
                </div>
                <div className={s.card__image}>
                    <img src={image} alt="" />
                </div>
                <div className={s.card__text}>
                    {text}
                </div>
            </div>
        </div>
    )
}

export default Card;