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
    
    let url = "https://toutiao.io/"
    let Hoturl = "https://toutiao.io/posts/hot/7"

    let Javaurl = "https://toutiao.io/c/java"
    let iOSurl = "https://toutiao.io/c/ios"
    let Weburl = "https://toutiao.io/c/fe"

    func getReleases(url: String, _ done: @escaping (_ model: [TTModel]?) -> ()) {
        Alamofire.request(url, method: .get )
            .responseString { response in
                guard let html = response.result.value else {
                    return done(nil)
                }
                
                let document = try? XMLDocument(string: html)
                let body = document!.xpath("//div[@class='post']")
                
                let releases = body.map { return self.release($0) }.flatMap { return $0 }
                done(releases)
        }
    }
    
    func release(_ element: Fuzi.XMLElement) -> [TTModel] {
        var model = [TTModel]()
        var url = String()
        var href = String()

        var title = String()
        var like = String()
        var comment = String()
        
        let pth = element.xpath(".//div[@class='btn-group-vertical upvote']")
        pth.forEach {tt in
            for (index, element) in tt.xpath(".//span").enumerated() {
                if index == 0 {
                    like = element.stringValue
                    break
                }
            }
        }
        
        let pth1 = element.xpath(".//div[@class='meta']/span")
        pth1.forEach {tt in
            let value = tt.stringValue
            comment = value.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        let pth2 = element.xpath(".//div[@class='meta']")
        pth2.forEach {tt in
            let value = tt.stringValue.components(separatedBy: "\n")
            url = value[1].trimmingCharacters(in: .whitespacesAndNewlines)

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
