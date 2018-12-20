//
//  TocViewController.swift
//  mine_yours
//
//  Created by Frankshammer42 on 12/2/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation
import AVKit

class TocViewController: UIHeadGazeViewController{
    @IBOutlet weak internal var uiview: UIView!
    @IBOutlet weak internal var snow_button: UIHoverableButton!
    @IBOutlet weak internal var time_button: UIHoverableButton!
    @IBOutlet weak internal var balcony_button: UIHoverableButton!
    
    @IBAction func snowButtonTouchUpInside(_ sender: UIHoverableButton) {
        print("User chooses to view snow")
        audioPlayer?.play()
    }
    
    @IBAction func timeButtonTouchUpInside(_ sender: UIHoverableButton) {
        print("User chooses to view stop")
        audioPlayer?.play()
    }
    
    @IBAction func balconyButtonTouchUpInside(_ sender: UIHoverableButton) {
        print("User chooses to view balcony")
        audioPlayer?.play()
    }

    //Go to different Segues based upon identifier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "snowSegue") {
            let vc = segue.destination as? UpdateArmViewController
            vc?.video_name += "First Snow"
            vc?.video_when += "Nov 15, 2018, at 3:48:11"
            vc?.video_where += "Between Stern and Courant"
//            vc?.camera_position += "1.4m Above Ground"
//            vc?.camera_orientation += "45 Degrees Around X Axis"
        }
        
        if (segue.identifier == "stopSegue") {
            let vc = segue.destination as? UpdateArmViewController
            vc?.video_name += "Stop Sign"
            vc?.video_when += "Nov 24, 2018, at 17:05:11"
            vc?.video_where += "Golden Gate Park"
//            vc?.camera_position += "1.6m Above Ground"
//            vc?.camera_orientation += "20 Degrees Around Y Axis"
        }
        
        if (segue.identifier == "balconySegue") {
            let vc = segue.destination as? UpdateArmViewController
            vc?.video_name += "Balcony"
            vc?.video_when += "Nov 22, 2018, at 16:27:51"
            vc?.video_where += "Seaside, California"
            //            vc?.camera_position += "1.6m Above Ground"
            //            vc?.camera_orientation += "20 Degrees Around Y Axis"
        }
        
        
    }
    
    var audioPlayer: AVAudioPlayer?
    private func loadSound(){
        do{
            if let fileURL = Bundle.main.path(forResource: "button_sound1_full", ofType: "wav") {
                print("Continue processing")
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("Error: No file with specified name exists")
            }
        }
        catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.sceneview?.isHidden = false
        loadSound()
//        setup_vid()
        snow_button.dwellDuration = 0.8 //Change the duration
        snow_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        time_button.dwellDuration = 0.8
        time_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        balcony_button.dwellDuration = 0.8
        balcony_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        
        let headGazeRecognizer = UIHeadGazeRecognizer()
        super.virtualCursorView?.addGestureRecognizer(headGazeRecognizer)
        headGazeRecognizer.move = { [weak self] gaze in
            self?.buttonAction(gaze: gaze)
        }
        makecircularWithShadow(button: snow_button, name: "ABOUT SNOW")
        makecircularWithShadow(button: time_button, name: "ABOUT TIME")
        makecircularWithShadow(button: balcony_button, name: "ABOUT BALCONY")
        blockFingerTouch(toggle: true, asMirror: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func makecircularWithShadow(button: UIButton, name: String="untitled", masksToBounds: Bool = true) {
        button.layer.cornerRadius  = button.frame.height / 2
        button.layer.masksToBounds = masksToBounds
        button.layer.shadowColor   = UIColor.black.cgColor
        button.layer.shadowOffset  = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowRadius  = 0.6
        button.layer.shadowOpacity = 0.5
        guard let button = button as? UIHoverableButton else { return }
        button.name = name
    }
    
    private func buttonAction(gaze: UIHeadGaze){
        self.snow_button.hover(gaze: gaze)
        self.time_button.hover(gaze: gaze)
        self.balcony_button.hover(gaze: gaze)
    }
    
    private func blockFingerTouch(toggle enableHeadCtr: Bool, asMirror showFace: Bool = false){
        super.sceneview?.isHidden = false
        self.uiview.removeFromSuperview()
        super.virtualCursorView?.removeFromSuperview()
        //change the z-order of the UI widgets and block that shit
        super.view.addSubview(self.uiview)
        self.view.addSubview(super.virtualCursorView!)
    }
    
    private func setup_vid(){
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "metro", ofType: "mov")!)
        let vid_player = AVPlayer(url: fileURL)
        let new_layer = AVPlayerLayer(player: vid_player)
        new_layer.frame = self.uiview.frame
        self.uiview.layer.addSublayer(new_layer)
        new_layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        new_layer.zPosition = -1
        
        vid_player.play()
        vid_player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: vid_player.currentItem, queue: .main) { [weak self] _ in
            vid_player.seek(to: CMTime.zero)
            vid_player.play()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    
    
    
    
    
    
    
    
}
