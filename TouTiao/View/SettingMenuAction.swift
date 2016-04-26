//
//  SettingMenuAction.swift
//  TouTiao
//
//  Created by plusub on 4/26/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa

class SettingMenuAction {

    class func perform(sender: NSView) {
        let delegate = NSApplication.sharedApplication().delegate as! MainViewController
        
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "退出", action: #selector(delegate.quit), keyEquivalent: "q"))
        
        NSMenu.popUpContextMenu(menu, withEvent: NSApp.currentEvent!, forView: sender)
    }
    
}
