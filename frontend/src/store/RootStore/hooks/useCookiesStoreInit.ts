import { Cookies } from 'react-cookie';

import rootStore from '../instance';
import { formCookieValue } from 'utils/formCookieValue';

export const useCookiesStoreInit = () => {
  const cookies = new Cookies();
  
  if (!cookies.get('hackaton_user')) {
      cookies.set('hackaton_user', formCookieValue({}), { path: '/' });
      rootStore.cookies.setCookies(cookies.get('hackaton_user'));  
  }
};
