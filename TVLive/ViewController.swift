//
//  ViewController.swift
//  TVLive
//
//  Created by jianhao on 2016/11/13.
//  Copyright © 2016年 cocoaswifty. All rights reserved.
//

import UIKit
import XCDYouTubeKit

class ViewController: UIViewController {
    var videoPlayerViewController: XCDYouTubeVideoPlayerViewController!
    var pickerView: UIPickerView!
    var isFirst: Bool = true
    let videos = ["TzhQsNz71mU", "psBnG0ZvGmU", "XxJKnDLYZz4", "yk2CUjbyyQY", "1eGej-D4oHQ", "Giw92W9xkys", "g9uJqP0hT_I"]
    let videosDict = ["TzhQsNz71mU":"EBC 東森新聞 51 頻道",
                      "psBnG0ZvGmU":"CTI中天新聞24小時HD新聞直播",
                      "XxJKnDLYZz4":"台灣民視新聞HD直播",
                      "yk2CUjbyyQY":"TTV Live 台視直播",
                      "1eGej-D4oHQ":"中視新聞台 LIVE直播",
                      "Giw92W9xkys":"EBC 東森財經新聞 57 頻道",
                      "g9uJqP0hT_I":"華視新聞HD直播"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadVideo(identifier: videos[0])
        setSwipeGestureRecognizer()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadVideo(identifier: String = "") {
        if isFirst {
            videoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: identifier)
            videoPlayerViewController.present(in: self.view)
            videoPlayerViewController.moviePlayer.play()
            isFirst = false
        } else {
            videoPlayerViewController.moviePlayer.stop()
            videoPlayerViewController.videoIdentifier = identifier
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700), execute: {
                self.videoPlayerViewController.moviePlayer.play()
            })
            
            
        }
        
        
    }
    
    func setSwipeGestureRecognizer() {
        // 一個可供移動的 UIView
        pickerView = Bundle.main.loadNibNamed("PickerView", owner: self, options: nil)?.first as? UIPickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.frame = CGRect(x: -self.view.frame.width, y: 0, width: self.view.frame.width*0.6, height: self.view.frame.height)
        self.view.addSubview(pickerView)
        
        
        // 向左滑動
        let swipeLeft = UISwipeGestureRecognizer(
            target:self,
            action:#selector(ViewController.swipe(_:)))
        swipeLeft.direction = .left
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeLeft)
        
        
        // 向右滑動
        let swipeRight = UISwipeGestureRecognizer(
            target:self,
            action:#selector(ViewController.swipe(_:)))
        swipeRight.direction = .right
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeRight)
    }
    
    // 觸發滑動手勢後 執行的動作
    func swipe(_ recognizer:UISwipeGestureRecognizer) {
        let point = pickerView.center
        
        if recognizer.direction == .right {
            print("Go Right")
            
            if point.x <= 50 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.pickerView.frame.origin = CGPoint(x: 0, y: 0)
                })
                
            }
        } else if recognizer.direction == .left {
            print("Go Left")
            videoPlayerViewController.moviePlayer.play()
            
            if point.x >= 50 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.pickerView.frame.origin = CGPoint(x: -self.view.frame.width, y: 0)
                })
            }
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return videos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return videosDict[videos[row]]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(videos[row])
        loadVideo(identifier: videos[row])
        UIView.animate(withDuration: 0.25, animations: {
            self.pickerView.frame.origin = CGPoint(x: -self.view.frame.width, y: 0)
        })
    }
}
