//
//  TTButton.swift
//  TouTiao
//
//  Created by tesths on 25/03/2017.
//  Copyright © 2017 tesths. All rights reserved.
//

import Cocoa

@IBDesignable
class TTButton: NSButton
{
    @IBInspectable var bgColor: NSColor?
    @IBInspectable var textColor: NSColor?
    
    override func awakeFromNib()
    {
        if let textColor = textColor, let font = font
        {
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let attributes =
                [
                    NSForegroundColorAttributeName: textColor,
                    NSFontAttributeName: font,
                    NSParagraphStyleAttributeName: style
                    ] as [String : Any]
            
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            self.attributedTitle = attributedTitle
        }
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        if let bgColor = bgColor
        {
            bgColor.setFill()
            NSRectFill(dirtyRect)
        }
        
        super.draw(dirtyRect)
    }
    
}
