import QueryParamsStore from 'store/RootStore/QueryParamsStore';
import CookiesStore from 'store/RootStore/CookiesStore';

export default class RootStore {
    readonly query : QueryParamsStore = new QueryParamsStore();
    readonly cookies : CookiesStore = new CookiesStore();
}