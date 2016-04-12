//
//  NetWorkFetcher.swift
//  TouTiao
//
//  Created by tesths on 4/11/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa
import Alamofire
import Kanna

class NetWorkFetcher: NSObject {
    let url = "http://toutiao.io/"
    
    func uniq<S: SequenceType, E: Hashable where E==S.Generator.Element>(source: S) -> [E] {
        var seen: [E:Bool] = [:]
        return source.filter { seen.updateValue(true, forKey: $0) == nil }
    }
    
    func getReleases(done: (model: [TTModel]?) -> ()) {
        Alamofire.request(.GET, url)
            .responseString { response in
                guard let html = response.result.value else {
                    return done(model: nil)
                }
                if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
                    print(doc.title)
                    let snTable = doc.at_css("div[class='posts']")

                    print(doc.title)

//                    // Search for nodes by CSS
//                    for link in snTable!.css("a, link") {
//                        print(link.text)
//                        print(link["href"])
//                    }
                    
                    // Search for nodes by XPath
//                    for link in doc.xpath("//a[@target='_blank'] | //link") {
//                        if link.text?.length > 0 {
//                            print(link.text)
//                        }
//                        
//                        print(link["href"])
//                    }
                }
//                let document = try? XMLDocument(string: html)
//                let body = document?.xpath("//table[@id='latest-builds']/tbody")
//                
////                let model = body?.map { return self.release($0) }.flatMap { return $0 }
//                let model = "23"
//                done(model: nil)
        }
    }
}
