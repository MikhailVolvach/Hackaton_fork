import { useCallback, useMemo, useRef } from 'react';
import { Cookies } from 'react-cookie';
import CookiesStore from 'store/RootStore/CookiesStore/CookiesStore';
import { useLocalStore } from 'utils/useLocalStore';
import { formCookieValue } from 'utils/formCookieValue';

export const useCookiesStore = (defaultCookiesName = 'hackaton_user') => {
  const cookiesStore = useLocalStore(() => new CookiesStore());

  const cookies = useMemo(() => new Cookies(), []);

  if (!cookies.get(defaultCookiesName)) {
    cookies.set(defaultCookiesName, formCookieValue(), { path: '/' });
  }

  const defaultCookiesRef = useRef(cookies.get(defaultCookiesName));

  cookiesStore.setCookies(defaultCookiesRef.current);

  const setCookiesStore = useCallback(
    (
      name = defaultCookiesName,
      value: object = {},
      options = { path: '/' }
    ) => {
      const cookieItem = cookies.get(name);
      if (!cookieItem) {
        Object.assign(cookieItem, formCookieValue(value));
      } else {
        Object.assign(cookieItem, value);
      }
      cookies.set(name, cookieItem, options);
    },
    [cookies, defaultCookiesName]
  );

  return [cookiesStore.cookies?.getAll(), setCookiesStore];
};
