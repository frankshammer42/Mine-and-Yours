//
//  ThoughtsViewController.swift
//  mine_yours
//
//  Created by Frankshammer42 on 12/1/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class IndulgeViewController: UIHeadGazeViewController {
    
    @IBOutlet weak var nextHoverableButton: UIHoverableButton!
    @IBOutlet weak var uiview: UIView!
    
    
    var audioPlayer: AVAudioPlayer?
    var next_button_appear = false
  
    
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
    
    @IBAction func nextHoverableTouchUpInside(_ sender: UIHoverableButton) {
        if (next_button_appear){
            self.performSegue(withIdentifier: "GoToIntro", sender: self)
            print("Next Button is clicked")
            audioPlayer?.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.sceneview?.isHidden = false
        loadSound()
        nextHoverableButton.dwellDuration = 0.8 //Change the duration
        nextHoverableButton.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        let headGazeRecognizer = UIHeadGazeRecognizer()
        super.virtualCursorView?.addGestureRecognizer(headGazeRecognizer)
        headGazeRecognizer.move = { [weak self] gaze in
            self?.buttonAction(gaze: gaze)
        }
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(button_appear), userInfo: nil, repeats: false)
        makecircularWithShadow(button: nextHoverableButton, name: "NEXT")
        blockFingerTouch(toggle: true, asMirror: true)
    }
    
    @objc func button_appear() {
        next_button_appear = true;
        nextHoverableButton.isHidden = false;
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.nextHoverableButton.alpha = 1
        }, completion: nil)
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
        self.nextHoverableButton.hover(gaze: gaze)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
