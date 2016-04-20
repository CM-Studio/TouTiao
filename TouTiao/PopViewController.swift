//
//  PopViewController.swift
//  TouTiao
//
//  Created by tesths on 4/1/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa

class PopViewController: NSViewController {
    let fetcher = NetWorkFetcher()

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
        fetcher.getReleases{
            result in
            print(result)
        }
        
        fetcher.gettest {
            result in
            print(result)
        }
    }
    
}

// MARK: - NSTableViewDataSource
extension PopViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return 5
    }

    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: tableView) as! NSTableCellView
        if tableColumn!.identifier == "TouTiaoCell" {
            cellView.textField!.stringValue = "123"
            return cellView
        }
        
        return cellView
    }
}

extension PopViewController: NSTableViewDelegate {
    
}