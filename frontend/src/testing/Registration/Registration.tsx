import React, { useCallback } from 'react';
import LoginPage from './LoginPage';
import axios from 'axios';
import { useCookiesStore } from 'store/RootStore/hooks/useCookiesStore';

const apiUrl = "http://84.201.134.49:8000/say_hello/";

const Registration = () => {
    const [cookiesStore, setCookiesStore] = useCookiesStore();

    const handleLogin = useCallback(
        (value: object) => {
            setCookiesStore('hackaton_user', value, {path: '/'})
        }, [setCookiesStore])

    const handleClick = useCallback(() => {
        axios.get(
            apiUrl,
            {
                withCredentials: true,
                headers: {
                    'Set-Custom-Cookie': `hackaton_user=${JSON.stringify(cookiesStore.hackaton_user.token)}`
                },
            },            
            ).then(response => {
            if (response.status === 200) {
                console.log(response);
            } else {
              throw new Error('Login failed');
            }
        })
        .catch(error => {
            console.error('Login failed', error);
        });
        }, [cookiesStore.hackaton_user.token])
    
    return (
        <div>
            <div><LoginPage onLogin={handleLogin} /></div>
            <button onClick={handleClick}>Отправить</button>
        </div>
    )
}

export default Registration;
