import React from 'react';
import { CookiesProvider } from 'react-cookie';
import { Routes, Route, Navigate } from 'react-router-dom';

// import Registration from '../testing/Registration';
import { useQueryParamsStoreInit } from 'store/RootStore/hooks/useQueryParamsStoreInit';
import { useCookiesStoreInit } from 'store/RootStore/hooks/useCookiesStoreInit';

import Map from 'components/Map';
import MapPage from "pages/MapPage";
import Header from 'components/Header/Header';
import s from './app.module.scss';

export function App() {
  useQueryParamsStoreInit();
  useCookiesStoreInit();

  return (
    <div className={s.app}>
      {/* <Header /> */}
      
        <Routes>
          <Route path='/' element={<CookiesProvider><MapPage /></CookiesProvider>} />
          <Route path='/map' element={<CookiesProvider><Map /></CookiesProvider>} />
          <Route path="*" element={<CookiesProvider><Navigate to="/" replace /></CookiesProvider>} />
        </Routes>
    </div>
  );
}

export default App;
