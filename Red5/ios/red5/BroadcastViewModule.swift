//
//  BroadcastViewModule.swift
//  red5Test
//
//  Created by uli on 7/21/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit

@objc(BroadcastViewModule)
class BroadcastViewModule : RCTViewManager {

  override func view() -> UIView! {
    return BroadcastView();
  }

}
