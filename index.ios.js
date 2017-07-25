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
      cameraPosition: 'frontCamera'
    }
    this._toggleCamera = this._toggleCamera.bind(this)
  }

  _toggleCamera () {
    if (this.state.cameraPosition === 'frontCamera') {
      this.setState({cameraPosition: 'backCamera'})
    } else {
      this.setState({cameraPosition: 'frontCamera'})
    }
  }

  render () {
    return (
      <View style={styles.container}>
        <BroadcastView
          style={{flex: 1}}
          cameraPosition={this.state.cameraPosition}
        />
        <Button
          title={'Toggle Camera'}
          onPress={this._toggleCamera}
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
