import React, { useState, FC, useCallback, PropsWithChildren } from 'react';
import { createPortal } from 'react-dom';
import Modal from "../Modal";

export interface ModalPortalProps extends PropsWithChildren {
    isShowed?: boolean;
    callback: () => void;
}

const ModalPortal: FC<ModalPortalProps> = ({ isShowed, callback, children }) => {
    
    const closeModal = useCallback(() => {
        callback();
        }, [callback])
    
    return isShowed && createPortal(<Modal onClose={closeModal} children={children}/>, document.body);
}

export default ModalPortal;