import {types} from "./actions";

const initialState = {
    id: 0,
    data: "",
};

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case types.INCREMENT:
            return {
                ...state,
                id: state.id + 1,
            };
        case types.RECEIVE:
            return {
                ...state,
                data: JSON.stringify(action.value),
            };

        default:
            return state
    }
}

