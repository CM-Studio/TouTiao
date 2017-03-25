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
    var postUrl : String = ""
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var timeTextView: NSTextField!

    @IBAction func toutiaoPost(_ sender: Any) {
        postUrl = fetcher.url
        reloadData()
    }

    @IBAction func hotPost(_ sender: Any) {
        postUrl = fetcher.Hoturl
        reloadData()
    }
    
    @IBAction func JavaPost(_ sender: Any) {
        postUrl = fetcher.Javaurl
        reloadData()
    }
    
    @IBAction func iOSPost(_ sender: Any) {
        postUrl = fetcher.iOSurl
        reloadData()
    }
    

    @IBAction func WebPost(_ sender: Any) {
        postUrl = fetcher.Weburl
        reloadData()
    }
    
    
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
        
        postUrl = fetcher.url
    }
    
    @IBAction func toggleSettingButton(_ sender: NSView) {
        let menu = SettingMenuAction()
        menu.perform(sender)
    }
    
    func reloadData() {

        fetcher.getReleases(url: postUrl) {
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

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.make(withIdentifier: tableColumn!.identifier, owner: tableView) as! TTCell
        cellView.configureData(self.model[row])
        return cellView
    }
    
}

extension PopViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        print(URL(string: model[table.selectedRow].href)!)
        NSWorkspace.shared().open(URL(string: webHome + model[table.selectedRow].href)!)
    }
    
}
