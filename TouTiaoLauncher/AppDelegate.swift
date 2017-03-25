//
//  AppDelegate.swift
//  TouTiaoLauncher
//
//  Created by tesths on 25/03/2017.
//  Copyright © 2017 tesths. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let killme = Notification.Name("killme")
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    
    let mainAppIdentifier = "com.tt.TouTiao"
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let running = NSWorkspace.shared().runningApplications
        var alreadyRunning = false
        
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killme, object: mainAppIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("TouTiao") //main app name
            
            let newPath = NSString.path(withComponents: components)
            
            NSWorkspace.shared().launchApplication(newPath)
        }
        else {
            self.terminate()
        }
    }
    
    func terminate() {
        //		NSLog("I'll be back!")
        NSApp.terminate(nil)
    }
    
}

