//
//  TimeStoryViewController.swift
//  mine_yours
//
//  Created by Frankshammer42 on 12/10/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class StopSignStoryViewController: UIHeadGazeViewController, AVAudioPlayerDelegate{
    @IBOutlet weak internal var uiview: UIView!
    @IBOutlet weak var first_button: UIHoverableButton!
    @IBOutlet weak var second_button: UIHoverableButton!
    @IBOutlet weak var third_button: UIHoverableButton!
    @IBOutlet weak var fourth_button: UIHoverableButton!
    
    @IBOutlet weak var back_to_content_button: UIHoverableButton!
    @IBOutlet weak var attentionButton: UIHoverableButton!
    
    var first_button_touched = false
    var second_button_touched = false
    var third_button_touched = false
    var fourth_button_touched = false
    
    var first_audio_finished = false
    var second_audio_finished = false
    var third_audio_finished = false
    var fourth_audio_finished = false
    
    
    var video_starts_to_play = false
    var video_finish_play = false
    
    var video_paused = false
   
    weak var shapeLayer: CAShapeLayer?
    
    var audioPlayer_1: AVAudioPlayer?
    var audioPlayer_2: AVAudioPlayer?
    var audioPlayer_3: AVAudioPlayer?
    var audioPlayer_4: AVAudioPlayer?
    var videoPlayer: AVPlayer?
    
    @IBAction func attentionButtonTouchUpInside(_ sender: UIHoverableButton) {
        if (first_button_touched && second_button_touched && third_button_touched && fourth_button_touched && !video_starts_to_play && fourth_audio_finished){
            setup_vid()
            video_starts_to_play = true
            attentionButton.isHidden = true
            uiview.alpha = 0.9
        }
        
//        if (first_button_touched && second_button_touched && third_button_touched && fourth_button_touched && video_paused){
//            videoPlayer?.play()
//            video_paused = false
//            attentionButton.isHidden = true
//        }
    }
    
//    @IBAction func attentionButtonTouchUpOutside(_ sender: UIHoverableButton) {
//        if (first_button_touched && second_button_touched && third_button_touched && fourth_button_touched && video_starts_to_play){
//            videoPlayer?.pause();
//            attentionButton.isHidden = false
//            video_paused = true
//        }
//    }
    
    @IBAction func firstButtonTouchUpInside(_ sender: UIHoverableButton) {
        if (!first_button_touched){
            generate_story_graph(sentence_index: 0)
            audioPlayer_1?.play()
            first_button_touched = true
        }
    }
    
    
    @IBAction func secondButtonTouchUpInside(_ sender: UIHoverableButton) {
        if (!second_button_touched && first_button_touched && first_audio_finished){
            generate_story_graph(sentence_index: 1)
            audioPlayer_2?.play()
            first_button.isHidden = true
            second_button_touched = true
        }
    }
    
    
    @IBAction func thirdButtonTouchUpInside(_ sender: UIHoverableButton) {
        if (!third_button_touched && first_button_touched && second_button_touched && second_audio_finished){
            generate_story_graph(sentence_index: 2)
            audioPlayer_3?.play()
            second_button.isHidden = true
            third_button_touched = true
        }
    }
    
    @IBAction func fourthButtonTouchUpInside(_ sender: UIHoverableButton) {
        if (!fourth_button_touched && third_button_touched && first_button_touched && second_button_touched && third_audio_finished){
            audioPlayer_4?.play()
            third_button.isHidden = true
            fourth_button_touched = true
            self.shapeLayer?.removeFromSuperlayer()
        }
    }

    @IBAction func backButtonTouchUpInside(_ sender: UIHoverableButton) {
        if (video_finish_play){
            post_to_controller_server(to_pass: "rest")
            self.performSegue(withIdentifier: "stopBack", sender: self)
        }
    }
    
    private func loadStorySounds(){
        do{
            if let fileURL = Bundle.main.path(forResource: "stop_1", ofType: "m4a") {
                print("Continue processing")
                audioPlayer_1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                audioPlayer_1?.delegate = self as AVAudioPlayerDelegate
                audioPlayer_1?.prepareToPlay()
                
            } else {
                print("Error: No file with specified name exists")
            }
        }
        catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
        do{
            if let fileURL = Bundle.main.path(forResource: "stop_2", ofType: "m4a") {
                print("Continue processing")
                audioPlayer_2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                audioPlayer_2?.delegate = self as AVAudioPlayerDelegate
                audioPlayer_2?.prepareToPlay()
                
            } else {
                print("Error: No file with specified name exists")
            }
        }
        catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
        do{
            if let fileURL = Bundle.main.path(forResource: "stop_3", ofType: "m4a") {
                print("Continue processing")
                audioPlayer_3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                audioPlayer_3?.delegate = self as AVAudioPlayerDelegate
                audioPlayer_3?.prepareToPlay()
                
            } else {
                print("Error: No file with specified name exists")
            }
        }
        catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
        do{
            if let fileURL = Bundle.main.path(forResource: "stop_4", ofType: "m4a") {
                print("Continue processing")
                audioPlayer_4 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                audioPlayer_4?.delegate = self as AVAudioPlayerDelegate
                audioPlayer_4?.prepareToPlay()
                
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
        loadStorySounds()
        
        first_button.dwellDuration = 0.8 //Change the duration
        first_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        second_button.dwellDuration = 0.8 //Change the duration
        second_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        third_button.dwellDuration = 0.8 //Change the duration
        third_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        fourth_button.dwellDuration = 0.8 //Change the duration
        fourth_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        
        
        back_to_content_button.dwellDuration = 0.8
        back_to_content_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        attentionButton.dwellDuration = 0.8
        attentionButton.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        
        
        
        
        let headGazeRecognizer = UIHeadGazeRecognizer()
        super.virtualCursorView?.addGestureRecognizer(headGazeRecognizer)
        headGazeRecognizer.move = { [weak self] gaze in
            self?.buttonAction(gaze: gaze)
        }
        makecircularWithShadow(button: first_button, name: "")
        makecircularWithShadow(button: second_button, name: "")
        makecircularWithShadow(button: third_button, name: "")
        makecircularWithShadow(button: fourth_button, name: "")
        makecircularWithShadow(button: back_to_content_button, name: "")
        makecircularWithShadow(button: attentionButton, name: "")
        
        
        //        appear_sound?.play()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.first_button.alpha = 1
        }, completion: nil)
        
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
        self.first_button.hover(gaze: gaze)
        self.second_button.hover(gaze: gaze)
        self.third_button.hover(gaze: gaze)
        self.fourth_button.hover(gaze: gaze)
        self.back_to_content_button.hover(gaze: gaze)
        self.attentionButton.hover(gaze: gaze)
    }
    
    private func blockFingerTouch(toggle enableHeadCtr: Bool, asMirror showFace: Bool = false){
        super.sceneview?.isHidden = false
        self.uiview.removeFromSuperview()
        super.virtualCursorView?.removeFromSuperview()
        //change the z-order of the UI widgets and block that shit
        super.view.addSubview(self.uiview)
        self.view.addSubview(super.virtualCursorView!)
    }

    private func generate_story_graph(sentence_index: Int){
        
        self.shapeLayer?.removeFromSuperlayer()
        let button_start: UIHoverableButton
        let button_end: UIHoverableButton
        var animation_duration: Double
        
        // Set Up Button based upon index
        if (sentence_index == 0){
            button_start = first_button
            button_end = second_button
            animation_duration = 12
        }
        else if (sentence_index == 1){
            button_start = second_button
            button_end = third_button
            animation_duration = 11
        }
        else{
            button_start = third_button
            button_end = fourth_button
            animation_duration = 15
        }
        
        let path = UIBezierPath()
        
        path.move(to: button_start.center)
        //        path.addLine(to: CGPoint(x: 200, y: 50))
        path.addLine(to: button_end.center)
        
        // create shape layer for that path
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        
        // animate it
        
        view.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = animation_duration
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // save shape layer
        
        self.shapeLayer = shapeLayer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        first_button.alpha = 0
        second_button.alpha = 0
        third_button.alpha = 0
        fourth_button.alpha = 0
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    // Bunch of delegate methods to monitor audio play condition
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer , successfully flag: Bool){
        // Succefully Got the Event
        if flag == true{
            if (first_button_touched && !second_button_touched){
                second_button.isHidden = false
                first_audio_finished = true
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.second_button.alpha = 1
                }, completion: nil)
            }
            
            if (first_button_touched && second_button_touched && !third_button_touched){
                third_button.isHidden = false
                second_audio_finished = true
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.third_button.alpha = 1
                }, completion: nil)
            }
            
            if (first_button_touched && second_button_touched && third_button_touched){
                fourth_button.isHidden = false
                third_audio_finished = true
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.fourth_button.alpha = 1
                }, completion: nil)
            }
            
            if (first_button_touched && second_button_touched && third_button_touched && fourth_button_touched){
                fourth_button.isHidden = true
                fourth_audio_finished = true
                attentionButton.isHidden = false
            }
            
            
            
            //            if (first_button_touched && second_button_touched && third_button_touched){
            //                fourth_button.isHidden = false
            //                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            //                    self.fourth_button.alpha = 1
            //                }, completion: nil)
            //            }
            
            
            
        }
    }
    
    private func setup_vid(){
        let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "stop", ofType: "mov")!)
        videoPlayer = AVPlayer(url: fileURL)
        let new_layer = AVPlayerLayer(player: videoPlayer)
        new_layer.frame = self.uiview.frame
        self.uiview.layer.addSublayer(new_layer)
        new_layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        new_layer.zPosition = -1
        
        videoPlayer?.play()
        videoPlayer?.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoPlayer?.currentItem, queue: .main) { [weak self] _ in
            //            self?.videoPlayer?.seek(to: CMTime.zero)
            //            self?.videoPlayer?.play()
            self?.back_to_content_button.isHidden = false
            self?.video_finish_play = true
        }
    }
    
    
    
    
    
    
    
    
}
