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

class SecondViewController: UIHeadGazeViewController {
    
    
    @IBOutlet weak var uiview: UIView!
    @IBOutlet weak var next_button: UIHoverableButton!
    @IBOutlet weak var top_text_view: UITextView!
    @IBOutlet weak var bottom_text_view: UITextView!
    var next_button_appear = false
    weak var shapeLayer: CAShapeLayer?
    
    @IBAction func nextButtonTouchUpInside(_ sender: UIHoverableButton) {
        if (next_button_appear){
            self.performSegue(withIdentifier: "GoToContent", sender: self)
            print("Next Button is clicked")
            audioPlayer?.play()
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
        next_button.dwellDuration = 0.8 //Change the duration
        next_button.backgroundColor = UIColor(red:  192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.9)
        let headGazeRecognizer = UIHeadGazeRecognizer()
        super.virtualCursorView?.addGestureRecognizer(headGazeRecognizer)
        headGazeRecognizer.move = { [weak self] gaze in
            self?.buttonAction(gaze: gaze)
        }
//        animate_line()
        Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(button_appear), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(animate_line), userInfo: nil, repeats: false)
        makecircularWithShadow(button: next_button, name: "NEXT")
        blockFingerTouch(toggle: true, asMirror: true)
        
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
        self.next_button.hover(gaze: gaze)
    }
    
    @objc func button_appear() {
        next_button_appear = true;
        next_button.isHidden = false;
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.next_button.alpha = 1
        }, completion: nil)
    }
    
    private func blockFingerTouch(toggle enableHeadCtr: Bool, asMirror showFace: Bool = false){
        super.sceneview?.isHidden = false
        self.uiview.removeFromSuperview()
        super.virtualCursorView?.removeFromSuperview()
        //change the z-order of the UI widgets and block that shit
        super.view.addSubview(self.uiview)
        self.view.addSubview(super.virtualCursorView!)
    }
    
    @objc private func animate_line(){
        self.shapeLayer?.removeFromSuperlayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: top_text_view.center.x,  y: top_text_view.center.y + 59))
        //        path.addLine(to: CGPoint(x: 200, y: 50))
        path.addLine(to: CGPoint(x: bottom_text_view.center.x ,  y: bottom_text_view.center.y - 18.5))
        
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
        animation.duration = 6
        shapeLayer.add(animation, forKey: "MyAnimation")
        
        // save shape layer
        
        self.shapeLayer = shapeLayer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
