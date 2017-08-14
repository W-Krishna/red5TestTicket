/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react'
import {
  AppRegistry,
  StyleSheet,
  View,
  Button
} from 'react-native'
import BroadcastView from 'react-native-red5'

export default class red5Test extends Component {
  constructor (props) {
    super(props)
    this.state = {
      cameraPosition: 'front',
      broadcastId: ''
    }
    this._toggleCamera = this._toggleCamera.bind(this)
    this._toggleBroadcast = this._toggleBroadcast.bind(this)
  }

  _toggleCamera () {
    if (this.state.cameraPosition === 'front') {
      this.setState({cameraPosition: 'back'})
    } else {
      this.setState({cameraPosition: 'front'})
    }
  }

  _toggleBroadcast () {
    if (this.state.broadcastId === 'test1') {
      this.setState({broadcastId: ''})
    } else {
      this.setState({broadcastId: 'test1'})
    }
  }

  render () {
    return (
      <View style={styles.container}>
        <BroadcastView
          style={{flex: 1}}
          publishWithBroadcastId={this.state.broadcastId}
          cameraPosition={this.state.cameraPosition}
        />
        <Button
          title={'Toggle Camera'}
          onPress={this._toggleCamera}
        />
        <Button
          title={'Toggle broadcast'}
          onPress={this._toggleBroadcast}
        />
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
})

AppRegistry.registerComponent('red5Test', () => red5Test)
