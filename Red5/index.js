import React from 'react'
import { View, requireNativeComponent } from 'react-native'

class BroadcastView extends React.Component {
  render () {
    return <RNBroadcastView {...this.props} />
  }
}

BroadcastView.propTypes = {
  /**
   * cameraPosition: 'front' or 'back'
   * publish: If an rtmpURL is provided, will start publishing.
              If empty string provided, will stop publishing.
   */
  ...View.propTypes,
  cameraPosition: React.PropTypes.string
}

var RNBroadcastView = requireNativeComponent('BroadcastViewModule', BroadcastView)

module.exports = BroadcastView
