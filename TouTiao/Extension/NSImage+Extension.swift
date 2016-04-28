//
//  NSImage+Extension.swift
//  TouTiao
//
//  Created by plusub on 4/27/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa

extension NSImage {
    
    func tintedImageWithColor(color: NSColor) -> NSImage {
        let tinted = self.copy() as! NSImage
        tinted.lockFocus()
        color.set()
        
        let imageRect = NSRect(origin: NSZeroPoint, size: self.size)
        NSRectFillUsingOperation(imageRect, NSCompositingOperation.CompositeSourceAtop)
        
        tinted.unlockFocus()
        return tinted
    }
}