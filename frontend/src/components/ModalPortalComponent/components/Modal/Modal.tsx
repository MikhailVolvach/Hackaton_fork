import React, { PropsWithChildren, FC, useCallback } from 'react';
import s from './Modal.module.scss';

export interface ModalProps extends PropsWithChildren {
    onClose: () => void;
}

const Modal: FC<ModalProps> = ({ onClose, children }) => {
    const handleCloseClick = useCallback(() => {
        onClose();
        }, [onClose]);
    
    return (
        <div className={s.modal}>
            <div className={s.modal__container}>
                <button className={s.modal__close} onClick={handleCloseClick}>Закрыть</button>
                { children }
            </div>
            <div className={s.modal__overlay}></div>
        </div>
    )   
//    return <div>Тело модального окна<button onClick={onClose}>Закрыть модальное окно</button></div>
}

export default Modal;