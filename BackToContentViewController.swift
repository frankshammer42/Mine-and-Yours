//
//  BackToContentController.swift
//  mine_yours
//
//  Created by Frankshammer42 on 12/11/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class BackToContentViewController: UIHeadGazeViewController{
    
    @IBOutlet weak internal var uiview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.sceneview?.isHidden = false
        
        let headGazeRecognizer = UIHeadGazeRecognizer()
        super.virtualCursorView?.addGestureRecognizer(headGazeRecognizer)
        blockFingerTouch(toggle: true, asMirror: true)
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToContent), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func moveToContent() {
        self.performSegue(withIdentifier: "backToContent", sender: self)
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
