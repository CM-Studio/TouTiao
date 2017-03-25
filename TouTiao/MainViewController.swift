//
//  MainViewController.swift
//  TouTiao
//
//  Created by tesths on 4/1/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    override func awakeFromNib() {
        if let button = statusItem.button {
            button.image = NSImage(named: "TouTiao")
            button.action = #selector(MainViewController.togglePopover(_:))
        }
        popover.behavior = .transient
        popover.contentViewController = PopViewController(nibName: "PopViewController", bundle: nil)
        popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
        popover.behavior = .transient
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
        addToLoginItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    func addToLoginItems() {
//        Process.launchedProcess(
//            launchPath: "/usr/bin/osascript",
//            arguments: [
//                "-e",
//                "tell application \"System Events\" to make login item at end with properties {path:\"/Applications/TouTiao.app\", hidden:false, name:\"Compute for TouTiao\"}"
//            ]
//        )
    }

    func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Reload"), object: nil)

        eventMonitor?.start()
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func quit() {
        NSApplication.shared().terminate(self)
    }
}
