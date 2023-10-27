import React from 'react';

import { useLocation, useNavigate } from 'react-router-dom';
import QueryParamsStore from 'store/RootStore/QueryParamsStore';
import { useLocalStore } from 'utils/useLocalStore';

const stringifyParams = (queryParams: URLSearchParams): string => {
    let result = '';
    queryParams.forEach((value, key) => (result += `${key}=${value}&`));
    return result.endsWith("&") ? result.slice(0, result.length - 1) : result;
}

const getSearchParamsForLocation = (location: string, defaultSearchParams: URLSearchParams) : URLSearchParams => {
    const searchParams = new URLSearchParams(location);
    
    if (defaultSearchParams) {
        for (const key of defaultSearchParams.keys()) {
            if (!searchParams.has(key)) {
                // Если в поисковых параметрах нет конкретного ключа, то собираем все значения ключа из дефолтных поисковых параметров и добавляем их
                defaultSearchParams.getAll(key).forEach((value) => searchParams.append(key, value));
            }
        }
    }
    
    return searchParams;
}

export const useQueryParamsStore = (
    defaultParams: URLSearchParams = new URLSearchParams()
)  => {
    const queryParamsStore = useLocalStore(() => new QueryParamsStore());
    
    const defaultSearchParamsRef = React.useRef(new URLSearchParams(defaultParams));
    
    const location = useLocation();
    
    const searchParams: URLSearchParams = React.useMemo(
        () => getSearchParamsForLocation(location.search, defaultSearchParamsRef.current),
        [location.search]
    )
    
    queryParamsStore.setParams(stringifyParams(searchParams));
    
    const navigate = useNavigate();
    
    const setQueryParamsStore = React.useCallback(
        (queryParams: URLSearchParams) => {
            const newSearchParams = stringifyParams(queryParams);
            queryParamsStore.setParams(newSearchParams);
            navigate(`?${newSearchParams}`);
            },
        [navigate, searchParams])
    
    return [queryParamsStore, setQueryParamsStore];
}