//
//  BroadcastView.swift
//  red5Test
//
//  Created by uli on 7/21/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import UIKit
import R5Streaming

class BroadcastView: UIView {

  let r5ViewController = R5ViewController()
  
  var cameraPosition: String = "" {
    didSet {
      r5ViewController.switchCameraPosition(to: cameraPosition)
    }
  }
  
  var publishWithBroadcastId: String = "" {
    didSet {
      if publishWithBroadcastId != "" {
        r5ViewController.publishWith(broadcastId: publishWithBroadcastId)
      } else {
        r5ViewController.stopPublishing()
      }
      
    }
  }
  

  override init(frame: CGRect) {
    super.init(frame: frame)
    r5ViewController.view.frame = frame
    self.addSubview(r5ViewController.view)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
