//
//  AppDelegate.swift
//  mine_yours
//
//  Created by Frankshammer42 on 11/30/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import UIKit
import ARKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,  willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let wnd = UIWindow(frame: UIScreen.main.bounds)
        
        if ARFaceTrackingConfiguration.isSupported {
            wnd.rootViewController = storyBoard.instantiateViewController(withIdentifier: "mainStoryBoard")
            wnd.makeKeyAndVisible()
            window = wnd
        }else{
            wnd.rootViewController = storyBoard.instantiateViewController(withIdentifier: "unsupportedDevice")
            wnd.makeKeyAndVisible()
            window = wnd
        }
        return true
    }



}

