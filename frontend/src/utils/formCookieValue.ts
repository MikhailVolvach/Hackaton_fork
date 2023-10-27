import {v4 as uuidv4} from 'uuid';

export const formCookieValue = (value = {}, saveToken = false) => {
    return saveToken ? {} : {...value, token: uuidv4()};
}