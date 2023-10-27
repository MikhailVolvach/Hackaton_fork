import React from 'react';
import cn from 'classnames';

import s from './button.module.scss';

export interface ButtonProps extends React.PropsWithChildren, React.ButtonHTMLAttributes<HTMLButtonElement> {
    theme?: string;
}

const Button: React.FC<ButtonProps> = ({ theme, disabled, ...props }) => {
    const buttonClassName = cn(s.custom_button, s.custom_button__primary);    

    return (
        <button disabled={disabled} {...props} className={buttonClassName}>Sample</button>
    )
}

export default Button;