//
//  TTCell.swift
//  TouTiao
//
//  Created by plusub on 4/24/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa

class TTCell: NSTableCellView {
    
    @IBOutlet weak var titleTextView: NSTextField!
    @IBOutlet weak var urlTextField: NSTextField!
    @IBOutlet weak var voteTextField: NSTextField!
    @IBOutlet weak var commentTextField: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    
    func configureData(model: TTModel) {
        self.titleTextView.stringValue = model.title
        self.urlTextField.stringValue = model.href
        self.voteTextField.stringValue = model.like
        self.commentTextField.stringValue = model.comment
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

    }
    
}
