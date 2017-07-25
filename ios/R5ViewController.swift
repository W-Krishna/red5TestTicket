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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureRed5()
    self.createPreview()
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
    let cameras: [AVCaptureDevice] = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
    print("cameras:", cameras)
    if cameras.count > 0 {
      let cameraDevice: AVCaptureDevice = cameras.first!
      let camera = R5Camera(device: cameraDevice, andBitRate: 750)
      camera?.width = 1280
      camera?.height = 720
      camera?.fps = 30
      camera?.orientation = 0
      
      let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
      let microphone = R5Microphone(device: audioDevice)
      microphone?.bitrate = 32
      
      let connection = R5Connection(config: self.configuration)
      self.stream = R5Stream(connection: connection)
      
      self.stream?.attachVideo(camera)
      self.stream?.attachAudio(microphone)
      self.setFrame(self.view.frame)
      self.stream?.delegate = self
      self.attach(stream)
      stream?.publish("test1", type: R5RecordTypeLive)
    } else {
      print("not initializing camera")
      //      TODO: Do not intialize preview, just say no cameras were found
    }
  }
  func onR5StreamStatus(_ stream: R5Stream!, withStatus statusCode: Int32, withMessage msg: String!) {
    print("Update \(statusCode) - message: \(msg)")
  }
  
  func switchCameraPosition(to cameraPosition: String) {
    var frontCamera : AVCaptureDevice?
    var backCamera : AVCaptureDevice?
    
    for device in AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo){
      let device = device as! AVCaptureDevice
      if frontCamera == nil && device.position == AVCaptureDevicePosition.front {
        frontCamera = device
        continue
      }else if backCamera == nil && device.position == AVCaptureDevicePosition.back{
        backCamera = device
      }
    }
    
    let camera = self.stream?.getVideoSource() as! R5Camera
    if(camera.device === frontCamera){
      camera.device = backCamera
    }else{
      camera.device = frontCamera
    }
  }
  
}

