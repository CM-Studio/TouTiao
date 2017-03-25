//
//  SettingMenuAction.swift
//  TouTiao
//
//  Created by plusub on 4/26/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa
import ServiceManagement

class SettingMenuAction {
    
    let launcherAppIdentifier = "com.tesths.TouTiaoLauncher"


    var autoLaunch: Bool = true
    let startMenu = NSMenuItem(title: "开机启动", action: #selector(startLogin), keyEquivalent: "")

    func perform(_ sender: NSView) {
        let delegate = NSApplication.shared().delegate as! MainViewController

        let menu = NSMenu()
//        let hotShare = NSMenuItem()
//        hotShare.title = "热门分享"
//        let share7 = NSMenu(title: "最近 7 天")
//        let share30 = NSMenu(title: "最近 30 天")

//        let share30 = NSMenu().addItem(withTitle: "最近 30 天", action: #selector(delegate.quit), keyEquivalent: "q")
//        let hare90 = NSMenu().addItem(withTitle: "最近 90 天", action: #selector(delegate.quit), keyEquivalent: "q")
//        hotShare.submenu = share7
//        hotShare.submenu = share30
//        menu.addItem(NSMenuItem(title: "开机启动", action: #selector(startLogin), keyEquivalent: ""))

        menu.addItem(NSMenuItem(title: "退出", action: #selector(delegate.quit), keyEquivalent: "q"))
        NSMenu.popUpContextMenu(menu, with: NSApp.currentEvent!, for: sender)
    }
    
    @objc func startLogin() {
        autoLaunch = !autoLaunch
        if autoLaunch == true {
            startMenu.title = "开机启动"
        } else {
            startMenu.title = "开机不启动"
        }
        SMLoginItemSetEnabled(launcherAppIdentifier as CFString, autoLaunch)
    }
    
}
