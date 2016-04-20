//
//  PopViewController.swift
//  TouTiao
//
//  Created by tesths on 4/1/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa
import AEXML
import Fuzi
//import Kanna

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
        
        guard let
            xmlPath = NSBundle.mainBundle().pathForResource("test", ofType: "xml"),
            data = NSData(contentsOfFile: xmlPath)
            else { return }
        
        
        let html = String(data: data, encoding: NSUTF8StringEncoding)
        let document = try? XMLDocument(string: html!)
//        let body = document?.xpath("//div[@id='daily']/div[@posts]")
//        print(body)
        
        for element in document!.xpath("//div[@id='daily']") {
            
            for t in element.xpath(".//div[@class='post']") {
                print(t)
            }

//            print("\(element)")
        }
        
//        if let doc = Kanna.HTML(html: html!, encoding: NSUTF8StringEncoding) {
//            print(doc.body)
//            
//            let css = "html > body > div[id='main']"
//
//            if let snTable = doc.at_css(css) {
//                for (indexTd, td) in snTable.css("a, link").enumerate() {
//                    print(td.text)
//                }
//            }
//            // Search for nodes by CSS
//            for link in doc.css("a, link") {
//                print(link.text)
//                print(link["href"])
//            }
//            
//            // Search for nodes by XPath
//            for link in doc.xpath("//a | //link") {
//                print(link.text)
//                print(link["href"])
//            }
//        }
        
        let css = "body > div[id='main'] > div[class='hero']"
//        for (indexTd, td) in doc.css(css).enumerate() {
//            print(td)
//        }
//        do {
//            // if encoding is omitted, it defaults to NSUTF8StringEncoding
//            let doc = try HTMLDocument(string: html!, encoding: NSUTF8StringEncoding)
//            if let root = doc.root {
//                print("Root Element: \(root.tag)")
//            }
//            // CSS queries
//            if let elementById = doc.firstChild(css: "#daily") {
//                print(elementById.stringValue)
//                
//            }
//            for link in doc.css("a, link") {
//                print(link.rawXML)
//                print(link["href"])
//            }
//            let css = "body > div[id='main'] > div[class='hero']"
//            var blockElement:XMLElement? = nil
//            print("CSS Search: \(css)")
//            
//            let t = doc.css(css)
//            
//            
//            for (index, element) in doc.css(css).enumerate() {
//                print(element)
//            }
//            
//        } catch let error {
//            print(error)
//        }
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