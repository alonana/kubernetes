import './style.css';
import React from 'react'

export default class Main extends React.Component {
    render() {
        return (
            <div>
                <div
                    className="main-div"
                    onClick={this.props.increment}
                >
                    Hello {this.props.id}
                </div>
                <div
                    onClick={this.props.fetchDetails}
                >
                    Fetch
                </div>
                <div>
                    {this.props.data}
                </div>
            </div>
        );
    }
}