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
        return 5
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: tableView) as! NSTableCellView
        
        // 2
        if tableColumn!.identifier == "BugColumn" {
            // 3
            cellView.textField!.stringValue = "123"
            return cellView
        }
        
        return cellView
    }
    
//    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        // 1
//        var cellView: NSTableCellView = tableView.makeViewWithIdentifier("BugColumn", owner: self) as! NSTableCellView
//        
//        // 2
//        if tableColumn!.identifier == "BugColumn" {
//            // 3
//            cellView.textField!.stringValue = "eq"
//            return cellView
//        }
//        
//        return cellView
//    }
}

extension PopViewController: NSTableViewDelegate {
    
}