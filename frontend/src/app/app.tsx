import React from 'react';
import { CookiesProvider } from 'react-cookie';
import { Routes, Route, Navigate } from 'react-router-dom';

// import Registration from '../testing/Registration';
import { useQueryParamsStoreInit } from 'store/RootStore/hooks/useQueryParamsStoreInit';
import { useCookiesStoreInit } from 'store/RootStore/hooks/useCookiesStoreInit';

import Map from 'pages/Map';

export function App() {
  useQueryParamsStoreInit();
  useCookiesStoreInit();

  return (
    <div>
      <CookiesProvider>
        <Routes>
          <Route path='/' element={<Map />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </CookiesProvider>
    </div>
  );
}

export default App;
