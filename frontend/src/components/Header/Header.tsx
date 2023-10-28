import React from 'react';
import Logo from 'img/Logo.png';

import s from './Header.module.scss';

const Header = () => {
    return (
        <header className={s.header}>
            <div className={s.header__logo}>
                <img src={Logo} alt="" className={s.header__logo_img} />
            </div>
        </header>
    );
}

export default Header;