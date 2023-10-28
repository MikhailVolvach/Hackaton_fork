import Card from "components/Card";
import { Swiper, SwiperSlide } from "swiper/react";
import {v4 as uuidv4} from 'uuid';

import classNames from "classnames";
import { A11y, Scrollbar } from "swiper/modules";
import { DetailsModel } from "utils/types";
import s from './InfoPanel.module.scss';
import Image from 'img/Frame 69.png';

import {FC} from 'react';

import 'swiper/scss';
//import 'swiper/scss/navigation';
//import 'swiper/scss/pagination';

export interface IInfoPanel {
    energyLevel: number;
}

const InfoPanel : FC<IInfoPanel> = ({ energyLevel }) => {
    const batteryLevel = {
      width: `${energyLevel}%`
    }

    const Wheels: DetailsModel[] = [
        {
            image: Image,
            number: 1,
            state: 1
        },
        {
            image: Image,
            number: 2,
            state: 2
        },
        {
            image: Image,
            number: 3,
            state: 3
        },
        {
            image: Image,
            number: 4,
            state: 2
        }
    ]

    return (
        <div className={s.infoPanel}>
            <div className={s.infoPanel__header}>
                <h2 className={s.infoPanel__title}>Обслуживание</h2>
            </div>
            
            <div className={s.infoPanel__body}>
                <div className={classNames(s.infoPanel__segment, s.infoPanel__battery, s.battery)}>
                    <h3 className={s.infoPanel__segment_title}>Уровень заряда</h3>
                    <div className={s.battery}>
                        <div className={s.battery__bar}>
                            <div className={s.battery__level} style={batteryLevel}></div>
                        </div>
                        <div className={classNames(s.battery__percentage, s.percentage)}>
                            <div className={classNames(s.percentage__mark, s.percentage__mark_start)}>0</div>
                            <div className={classNames(s.percentage__mark, s.percentage__mark_mid)}>50</div>
                            <div className={classNames(s.percentage__mark, s.percentage__mark_end)}>100</div>
                        </div>
                    </div>

                </div>
                <div className={classNames(s.infoPanel__segment, s.infoPanel__slider)}>
                    <h3 className={s.infoPanel__segment_title}>Колёса</h3>
                    <div className={s.segment__body}>
                        <Swiper
                        // install Swiper modules
                        modules={[Scrollbar, A11y]}
                        spaceBetween={100}
                        slidesPerView={3}
                        // scrollbar={{ draggable: true }}
                        onSwiper={(swiper) => {}}
                        onSlideChange={() => {}}
                        >
                            {Wheels.map((item) => {
                                let text = "";
                                if (item.state === 1) {
                                    text = 'Требует замены';
                                } else {
                                    if (item.state === 2) {
                                        text = 'Требует обслуживания';
                                    } else {
                                        if (item.state === 3) {
                                            text = 'Исправно';
                                        }
                                    }
                                }

                                return (
                                <SwiperSlide key={uuidv4()} className={s.segment__slide}>
                                    <Card image={item.image} number={`${item.number} / ${Wheels.length}`} text={text} color={item.state}/>
                                </SwiperSlide>)
                            })}
                        </Swiper>
                    </div>
                </div>
                <div className={classNames(s.infoPanel__segment, s.infoPanel__slider)}>
                    <h3 className={s.infoPanel__segment_title}>Солнечные батареи</h3>
                    <div className={s.segment__body}>
                        <Swiper
                        // install Swiper modules
                        modules={[Scrollbar, A11y]}
                        spaceBetween={100}
                        slidesPerView={3}
                        // scrollbar={{ draggable: true }}
                        onSwiper={(swiper) => console.log(swiper)}
                        onSlideChange={() => console.log('slide change')}
                        >
                            {Wheels.map((item) => {
                                let text = "";
                                if (item.state === 1) {
                                    text = 'Требует замены';
                                } else {
                                    if (item.state === 2) {
                                        text = 'Требует обслуживания';
                                    } else {
                                        if (item.state === 3) {
                                            text = 'Исправно';
                                        }
                                    }
                                }

                                return (
                                <SwiperSlide key={uuidv4()} className={s.segment__slide}>
                                    <Card image={item.image} number={`${item.number} / ${Wheels.length}`} text={text} color={item.state}/>
                                </SwiperSlide>)
                            })}
                        </Swiper>
                    </div>
                </div>
            </div>
          </div>
    );
}

export default InfoPanel;