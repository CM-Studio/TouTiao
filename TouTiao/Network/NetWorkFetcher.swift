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
        var url = String()
        var href = String()

        var title = String()
        var like = String()
        var comment = String()
        
        let pth = element.xpath(".//div[@class='btn-group-vertical upvote']")
        pth.forEach {tt in
            for (index, element) in tt.xpath(".//span").enumerate() {
                if index == 0 {
                    like = element.stringValue
                    break
                }
            }
        }
        
        let pth1 = element.xpath(".//div[@class='meta']/span")
        pth1.forEach {tt in
            print(tt)

            let value = tt.stringValue
            print(value)
            comment = value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        
        let pth2 = element.xpath(".//div[@class='meta']")
        pth2.forEach {tt in
            let value = tt.stringValue.componentsSeparatedByString("\n")
            url = value[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

        }
    
        let pth3 = element.xpath(".//h3[@class='title']/a")
        pth3.forEach {tt in
            pth3.forEach { pth in
                href = pth["href"]!
                title = pth.stringValue
            }
        }
        
        model.append(
            TTModel(
                title: title,
                url: url,
                href: href,
                like: like,
                comment: comment
            )
        )
        
        return model
    }
}
