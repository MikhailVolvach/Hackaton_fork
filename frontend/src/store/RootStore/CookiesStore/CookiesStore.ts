import { action, observable, makeObservable, computed } from 'mobx';
import { ILocalStore } from 'utils/useLocalStore';
import { Cookies } from 'react-cookie';


export type PrivateFields = '_cookies';

export default class CookiesStore implements ILocalStore {
    private _cookies: Cookies = new Cookies();

    constructor() {
        makeObservable<CookiesStore, PrivateFields>(this, {
            _cookies: observable.ref,
            cookies: computed,
            setCookies: action,
        });
    }
    
    get cookies() {
        return this._cookies;
    }
    
    setCookies(cookies: Cookies) {
        if (!this._cookies) {
            this._cookies = cookies;
        }
    }

    destroy(): void {
        return;
    }
}
