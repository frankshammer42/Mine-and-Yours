//
//  UpdateArmViewController.swift
//  mine_yours
//
//  Created by Frankshammer42 on 12/2/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class UpdateArmViewController: UIHeadGazeViewController{
    
    @IBOutlet weak internal var uiview: UIView!
    @IBOutlet weak var vid_label: UILabel!
    @IBOutlet weak var when_label: UILabel!
    @IBOutlet weak var where_label: UILabel!
//    @IBOutlet weak var arm_position_label: UILabel!
//    @IBOutlet weak var arm_orientation_label: UILabel!
    @IBOutlet weak var tutorial_prompt: UITextView!
    
    var video_name = ""
    var video_when = ""
    var video_where = ""
//    var camera_position = ""
//    var camera_orientation = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.sceneview?.isHidden = false
        update_vid_cam_info()
        let headGazeRecognizer = UIHeadGazeRecognizer()
        super.virtualCursorView?.addGestureRecognizer(headGazeRecognizer)
        blockFingerTouch(toggle: true, asMirror: true)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(showProgressAndhideInfo), userInfo: nil, repeats: false)
        if (self.video_name == "First Snow"){
            post_to_controller_server(to_pass: "snow");
            Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(moveToSnowStory), userInfo: nil, repeats: false)
        }
        if (self.video_name == "Stop Sign"){
            post_to_controller_server(to_pass: "stop")
            Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(moveToStopStory), userInfo: nil, repeats: false)
        }
        if (self.video_name == "Balcony"){
            post_to_controller_server(to_pass: "balcony")
            Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(moveToBalconyStory), userInfo: nil, repeats: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func moveToSnowStory() {
        self.performSegue(withIdentifier: "snowStorySegue", sender: self)
    }
    
    @objc func moveToStopStory() {
        self.performSegue(withIdentifier: "stopStorySegue", sender: self)
    }
    
    @objc func moveToBalconyStory() {
        self.performSegue(withIdentifier: "balconyStorySegue", sender: self)
    }
    
    private func update_vid_cam_info() {
        vid_label.text = video_name
        when_label.text = video_when
        where_label.text = video_where
//        arm_position_label.text = camera_position
//        arm_orientation_label.text = camera_orientation
    }
    
    private func blockFingerTouch(toggle enableHeadCtr: Bool, asMirror showFace: Bool = false){
        super.sceneview?.isHidden = false
        self.uiview.removeFromSuperview()
        super.virtualCursorView?.removeFromSuperview()
        //change the z-order of the UI widgets and block that shit
        super.view.addSubview(self.uiview)
        self.view.addSubview(super.virtualCursorView!)
    }
    
    @objc func showProgressAndhideInfo(){
        tutorial_prompt.isHidden = false
        when_label.isHidden = true
        where_label.isHidden = true
        vid_label.isHidden = true
//        arm_position_label.isHidden = true
//        arm_orientation_label.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    
    
    
}
