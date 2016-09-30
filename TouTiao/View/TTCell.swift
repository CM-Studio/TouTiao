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
        layer?.backgroundColor = NSColor.white.cgColor
    }
    
    
    func configureData(_ model: TTModel) {
        self.titleTextView.stringValue = model.title
        self.urlTextField.stringValue = model.url
        self.voteTextField.stringValue = model.like
        self.commentTextField.stringValue = model.comment
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    
}
