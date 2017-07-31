//
//  RNRed5Exports.m
//  red5Test
//
//  Created by uli on 7/21/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "React/RCTBridgeModule.h"
#import "React/RCTViewManager.h"
#import <React/RCTLog.h>

@interface RCT_EXTERN_MODULE(BroadcastViewModule, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(cameraPosition, NSString)
RCT_EXPORT_VIEW_PROPERTY(publishWithBroadcastId, NSString)
@end
