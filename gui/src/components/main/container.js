import {connect} from 'react-redux'
import {actions} from './actions'
import component from './component'

function mapStateToProps(state) {
    return {
        ...state.main,
    }
}

const mapDispatchToProps = {
    increment: actions.increment,
    fetchDetails: actions.fetchDetails,
};

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(component)