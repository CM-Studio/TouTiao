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
    @IBOutlet weak var timeTextView: NSTextField!

    @IBOutlet weak var headerView: NSView! {
        didSet {
            headerView.wantsLayer = true
            headerView.layer?.backgroundColor = NSColor.whiteColor().CGColor
        }
    }
    @IBOutlet weak var footerView: NSView! {
        didSet {
            footerView.wantsLayer = true
            footerView.layer?.backgroundColor = NSColor.init(red:0.16, green:0.69, blue:0.93, alpha:1.00).CGColor
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PopViewController.reloadData), name:"Reload", object: nil)
    }
    
    @IBAction func toggleSettingButton(sender: NSView) {
        SettingMenuAction.perform(sender)
    }
    @IBAction func gotoTouTiaoWeb(sender: AnyObject) {
                NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://toutiao.io/")!)
    }
    
    func reloadData() {
        fetcher.getReleases {
            result in
            self.model = result!
            self.tableView.reloadData()
            self.setTime()
        }
    }
    
    func setTime() {
        let currentDate = NSDate()
        timeTextView.stringValue = "更新时间 \(currentDate.toShortTimeString())"
    }
    

}


// MARK: - NSTableViewDataSource
extension PopViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return model.count
    }

    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: tableView) as! TTCell
        cellView.configureData(self.model[row])
        return cellView
    }
    
}

extension PopViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let table = notification.object as! NSTableView
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: model[table.selectedRow].href)!)
    }
    
}