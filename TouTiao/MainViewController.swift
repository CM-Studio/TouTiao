//
//  MainViewController.swift
//  TouTiao
//
//  Created by tesths on 4/1/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    override func awakeFromNib() {
        if let button = statusItem.button {
            button.image = NSImage(named: "TouTiao")
            button.action = #selector(MainViewController.togglePopover(_:))
        }
        popover.behavior = .Transient
        popover.contentViewController = PopViewController(nibName: "PopViewController", bundle: nil)
        popover.appearance = NSAppearance(named: NSAppearanceNameAqua)
        popover.behavior = .Transient
        
        eventMonitor = EventMonitor(mask: [.LeftMouseDownMask, .RightMouseDownMask]) { [unowned self] event in
            if self.popover.shown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
        if !applicationIsInStartUpItems() {
            toggleLaunchAtStartup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    func applicationIsInStartUpItems() -> Bool {
        return itemReferencesInLoginItems().existingReference != nil
    }
    
    func toggleLaunchAtStartup() {
        let itemReferences = itemReferencesInLoginItems()
        let shouldBeToggled = (itemReferences.existingReference == nil)
        let loginItemsRef = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileListRef?
        
        if loginItemsRef != nil {
            if shouldBeToggled {
                if let appUrl: CFURLRef = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
                    LSSharedFileListInsertItemURL(loginItemsRef, itemReferences.lastReference, nil, nil, appUrl, nil, nil)
                }
            } else {
                if let itemRef = itemReferences.existingReference {
                    LSSharedFileListItemRemove(loginItemsRef,itemRef);
                }
            }
        }
    }
    
    func itemReferencesInLoginItems() -> (existingReference: LSSharedFileListItemRef?, lastReference: LSSharedFileListItemRef?) {
        let  itemUrl : UnsafeMutablePointer<Unmanaged<CFURL>?> = UnsafeMutablePointer<Unmanaged<CFURL>?>.alloc(1)
        if let appUrl : NSURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
            let loginItemsRef = LSSharedFileListCreate(
                nil,
                kLSSharedFileListSessionLoginItems.takeRetainedValue(),
                nil
                ).takeRetainedValue() as LSSharedFileListRef?
            
            if loginItemsRef != nil {
                let loginItems = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as NSArray
                if(loginItems.count > 0) {
                    let lastItemRef = loginItems.lastObject as! LSSharedFileListItemRef
                    
                    for i in 0 ..< loginItems.count {
                        let currentItemRef = loginItems.objectAtIndex(i) as! LSSharedFileListItemRef
                        
                        if LSSharedFileListItemResolve(currentItemRef, 0, itemUrl, nil) == noErr {
                            if let urlRef: NSURL = itemUrl.memory?.takeRetainedValue() {
                                if urlRef.isEqual(appUrl) {
                                    return (currentItemRef, lastItemRef)
                                }
                            }
                        }
                    }
                    // The application was not found in the startup list
                    return (nil, lastItemRef)
                    
                } else  {
                    let addatstart: LSSharedFileListItemRef = kLSSharedFileListItemBeforeFirst.takeRetainedValue()
                    return(nil,addatstart)
                }
            }
        }
        
        return (nil, nil)
    }

    func togglePopover(sender: AnyObject?) {
        if popover.shown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("Reload", object: nil)

        eventMonitor?.start()
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func quit() {
        NSApplication.sharedApplication().terminate(self)
    }
}
