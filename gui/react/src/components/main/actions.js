import fetch from 'cross-fetch';

const INCREMENT = "INCREMENT";
const RECEIVE = "RECEIVE";

function fetchDetails() {
    return (dispatch) => {
        fetch('/api/access/list',
            {
                method: "post",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({id: 1}),
            }
        )
            .then(resp => resp.json())
            .then(json => dispatch(receive(json)));
    }
}

function receive(value) {
    return {
        type: RECEIVE,
        value: value,
    };
}

function increment() {
    return {
        type: INCREMENT
    };
}

export const types = {
    INCREMENT,
    RECEIVE
};

export const actions = {
    increment,
    fetchDetails,
};