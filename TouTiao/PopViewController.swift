//
//  PopViewController.swift
//  TouTiao
//
//  Created by tesths on 4/1/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa

class PopViewController: NSViewController {
    @IBOutlet weak var headView: NSView! {
        didSet {
            headView.wantsLayer = true
            headView.layer?.backgroundColor = NSColor(red:0.16, green:0.69, blue:0.93, alpha:1.00).CGColor
        }
    }
    @IBOutlet weak var titleLabel: NSTextField! {
        didSet {
            titleLabel.font = NSFont.systemFontOfSize(14)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

// MARK: - NSTableViewDataSource
extension PopViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return 4
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        // 2
        if tableColumn!.identifier == "content" {
            // 3
            cellView.textField!.stringValue = "test"
            return cellView
        }
        
        return cellView
    }
}
