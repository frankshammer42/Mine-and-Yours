//
//  ViewController.swift
//  mine_yours
//
//  Created by Frankshammer42 on 11/30/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIHeadGazeViewController {

    //Interface Layout
    @IBOutlet weak var uiview: UIView!
    @IBOutlet weak var start_hoverable_button: UIHoverableButton!
    @IBOutlet weak var debug_xy: UILabel!
    
    var audioPlayer: AVAudioPlayer?

   
    
    @IBAction func startBtnTouchDown(_ sender: UIHoverableButton) {
        start_hoverable_button.setTitle("Finger Touched", for: .normal)
    }
    
    @IBAction func startBtnTouchUpInside(_ sender: UIHoverableButton) {
        print("start button clicked")
        audioPlayer?.play()
        
//        start_hoverable_button.setTitle("", for: .normal)
    }
    
    @IBAction func startBtnTouchOutside(_ sender: UIHoverableButton) {
        start_hoverable_button.setTitle("START", for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSound()
        super.sceneview?.isHidden = false
        start_hoverable_button.dwellDuration = 0.8 //Change the duration
        start_hoverable_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        let headGazeRecognizer = UIHeadGazeRecognizer()
        super.virtualCursorView?.addGestureRecognizer(headGazeRecognizer)
        headGazeRecognizer.move = { [weak self] gaze in
            self?.buttonAction(gaze: gaze)
        }
        makecircularWithShadow(button: start_hoverable_button, name: "Start Journey")
        
        blockFingerTouch(toggle: true, asMirror: true)
        
    }
    
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
    
    private func makecircularWithShadow(button: UIButton, name: String="untitled", masksToBounds: Bool = true) {
        button.layer.cornerRadius  = button.frame.height / 2
        button.layer.masksToBounds = masksToBounds
        button.layer.shadowColor   = UIColor.black.cgColor
        button.layer.shadowOffset  = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowRadius  = 1.0
        button.layer.shadowOpacity = 0.5
        guard let button = button as? UIHoverableButton else { return }
        button.name = name
    }

    private func buttonAction(gaze: UIHeadGaze){
        self.start_hoverable_button.hover(gaze: gaze)
        let localCursorPos = gaze.location(in: self.uiview)
        self.debug_xy.text = String.init(format: "(%.2f, %.2f)", localCursorPos.x, localCursorPos.y)
    }
    
    private func blockFingerTouch(toggle enableHeadCtr: Bool, asMirror showFace: Bool = false){
        super.sceneview?.isHidden = false
        self.uiview.removeFromSuperview()
        super.virtualCursorView?.removeFromSuperview()
        //change the z-order of the UI widgets and block that shit
        super.view.addSubview(self.uiview)
        self.view.addSubview(super.virtualCursorView!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }

}

