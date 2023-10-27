import { action, computed, makeObservable, observable } from 'mobx';
import qs from 'qs';
import { ILocalStore } from 'utils/useLocalStore';

export type PrivateFields = "_params";

export default class QueryParamsStore implements ILocalStore{
    private _params: qs.ParsedQs = {};
    private _search = "";

    constructor() {
        makeObservable<QueryParamsStore, PrivateFields>(this, {
            _params: observable.ref,
            page: computed,
            search: computed,
            params: computed,
            setParams: action,
        })
    }
    
    get page() {
        return this._params.page || 1;
    }

    get search() {
        return this._params.search || "";
    }

    get params(): qs.ParsedQs {
        return this._params;
    }

    setParams(param: string): void {
        param = param.startsWith("?") ? param.slice(1) : param;

        if (this._search !== param) {
            this._params = qs.parse(param);
            this._search = param;
        }
    }

    destroy(): void {
        return;
    }
}

    