//
//  PopViewController.swift
//  TouTiao
//
//  Created by tesths on 4/1/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa
import Fuzi
//import Kanna

class PopViewController: NSViewController {
    let fetcher = NetWorkFetcher()
    var model = [TTModel]()

    @IBOutlet weak var tableView: NSTableView!
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

        
        fetcher.getReleases {
            result in
            self.model = result!
            self.tableView.reloadData()
        }

    }
    
}

// MARK: - NSTableViewDataSource
extension PopViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return model.count
    }

    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: tableView) as! NSTableCellView
        if tableColumn!.identifier == "TouTiaoCell" {
            cellView.textField!.stringValue = model[row].title
            return cellView
        }
        return cellView
    }
    
}

extension PopViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let table = notification.object as! NSTableView
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: model[table.selectedRow].href)!)
    }
    
}