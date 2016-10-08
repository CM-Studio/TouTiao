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
    let webHome = "https://toutiao.io"
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var timeTextView: NSTextField!

    @IBOutlet weak var headerView: NSView! {
        didSet {
            headerView.wantsLayer = true
            headerView.layer?.backgroundColor = NSColor.white.cgColor
        }
    }
    @IBOutlet weak var footerView: NSView! {
        didSet {
            footerView.wantsLayer = true
            footerView.layer?.backgroundColor = NSColor.init(red:0.16, green:0.69, blue:0.93, alpha:1.00).cgColor
        }
    }
    @IBOutlet weak var titleLabel: NSTextField! {
        didSet {
            titleLabel.font = NSFont.systemFont(ofSize: 14)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        NotificationCenter.default.addObserver(self, selector: #selector(PopViewController.reloadData), name:NSNotification.Name(rawValue: "Reload"), object: nil)
    }
    
    @IBAction func toggleSettingButton(_ sender: NSView) {
        SettingMenuAction.perform(sender)
    }
    @IBAction func gotoTouTiaoWeb(_ sender: AnyObject) {
                NSWorkspace.shared().open(URL(string: webHome)!)
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
        let currentDate = Date()
        timeTextView.stringValue = "更新时间 \(currentDate.toShortTimeString())"
    }
    

}


// MARK: - NSTableViewDataSource
extension PopViewController: NSTableViewDataSource {
    func numberOfRows(in aTableView: NSTableView) -> Int {
        return model.count
    }

    
    @objc(tableView:viewForTableColumn:row:) func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: tableView) as! TTCell
        cellView.configureData(self.model[row])
        return cellView
    }
    
}

extension PopViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        print(URL(string: model[table.selectedRow].href))
        NSWorkspace.shared().open(URL(string: webHome + model[table.selectedRow].href)!)
    }
    
}
