//
//  NetWorkFetcher.swift
//  TouTiao
//
//  Created by tesths on 4/11/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa
import Alamofire
import Fuzi

class NetWorkFetcher: NSObject {
    let url = "http://toutiao.io/"

    func getReleases(done: (model: [TTModel]?) -> ()) {
        Alamofire.request(.GET, url)
            .responseString { response in
                guard let html = response.result.value else {
                    return done(model: nil)
                }
                
                let document = try? XMLDocument(string: html)
                let body = document!.xpath("//div[@class='post']")
                
                let releases = body.map { return self.release($0) }.flatMap { return $0 }
                done(model: releases)
        }
    }
    
    func release(element: XMLElement) -> [TTModel] {
        var model = [TTModel]()
        let pth = element.xpath(".//h3[@class='title']/a")
        pth.forEach {_ in
            var href = String()
            var title = String()
            pth.forEach { pth in
                href = pth["href"]!
                title = pth.stringValue
            }
            
            model.append(
                TTModel(
                    title: title,
                    href: href
                )
            )
        }
        return model
    }
}
