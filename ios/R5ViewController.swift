//
//  R5ViewController.swift
//  red5Test
//
//  Created by uli on 7/24/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import UIKit
import R5Streaming

class R5ViewController: R5VideoViewController, R5StreamDelegate {
  var configuration = R5Configuration()
  var stream: R5Stream? = nil
  var broadcastId: String = ""
  var cameraPositionSet = false
  var isPublishing = false
  var cameras: [AVCaptureDevice]?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setFrame(self.view.frame)
    self.configureRed5()
    self.cameras = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice]
    self.createPreview()
    
    let app = UIApplication.shared
    NotificationCenter.default.addObserver(self, selector: #selector(R5ViewController.applicationWillResignActive(notification:)), name: NSNotification.Name.UIApplicationWillResignActive, object: app)
    NotificationCenter.default.addObserver(self, selector: #selector(R5ViewController.applicationDidBecomeActive(notification:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: app)
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


  func configureRed5() {
    configuration.host = "35.196.4.176"
    configuration.port = 8554
    configuration.contextName = "live"
    configuration.licenseKey = "LQZW-IFEK-5KOH-VSGX"
    configuration.buffer_time = 0.5
    configuration.protocol = 1
  }

  func createPreview() {
    if let cams = self.cameras {
      var cameraDevice: AVCaptureDevice?
      for (i, cam) in (cams.enumerated()) {
        if cam.position == .back {
          cameraDevice = cameras?[i]
        }
      }
      
      let camera = R5Camera(device: cameraDevice, andBitRate: 750)
      camera?.width = 1280
      camera?.height = 720
      camera?.fps = 24
      
      let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
      let microphone = R5Microphone(device: audioDevice)
      microphone?.bitrate = 32
      
      let connection = R5Connection(config: self.configuration)
      self.stream = R5Stream(connection: connection)
      self.stream?.attachVideo(camera)
      self.stream?.attachAudio(microphone)
      self.stream?.delegate = self
      self.attach(self.stream)
      self.showPreview(true)
    }
  }

  func onR5StreamStatus(_ stream: R5Stream!, withStatus statusCode: Int32, withMessage msg: String!) {
    print("Update \(statusCode) - message: \(msg)")
  }
  
  
  func applicationWillResignActive(notification: NSNotification) {
    self.stopPublishing()
  }
  
  func applicationDidBecomeActive(notification: NSNotification) {
    self.createPreview()
    if (self.isPublishing) {
      self.publishWith(broadcastId: self.broadcastId)
      self.showPreview(false)
    }
  }

  func switchCameraPosition(to cameraPosition: String) {
    var frontCamera : AVCaptureDevice?
    var backCamera : AVCaptureDevice?
    if self.cameraPositionSet  {
      for device in AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo){
        let device = device as! AVCaptureDevice
        if frontCamera == nil && device.position == AVCaptureDevicePosition.front {
          frontCamera = device
          continue;
        }else if backCamera == nil && device.position == AVCaptureDevicePosition.back{
          backCamera = device
        }
      }

      let camera = self.stream?.getVideoSource() as! R5Camera
      
      if(camera.device === frontCamera){
        camera.device = backCamera;
      }else{
        camera.device = frontCamera;
      }
    }
    self.cameraPositionSet = true
  }
  
  func publishWith(broadcastId: String) {
    self.broadcastId = broadcastId
    self.stream?.publish(broadcastId, type: R5RecordTypeLive)
    self.isPublishing = true
  }
  
  func stopPublishing() {
    if (self.isPublishing) {
      self.stream?.stop()
      self.stream?.delegate = nil
      self.stream = nil
      self.isPublishing = false
    }
  }

}
