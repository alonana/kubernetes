import './style.css';
import React from 'react'

export default class Main extends React.Component {
    renderElement(key, value) {
        return (
            <div>
                <span>{key}={value}</span>
            </div>
        );
    }

    renderRow(row) {
        const elements = [];
        Object.keys(row).forEach(k => elements.push(this.renderElement(k, row[k])));
        return (
            <div className="row">
                {elements}
            </div>
        );
    }

    renderRows() {
        const elements = [];
        this.props.data.forEach(d => elements.push(this.renderRow(d)));
        return (
            <div>
                {elements}
            </div>
        );
    }

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
                    {this.renderRows()}
                </div>
            </div>
        );
    }
}