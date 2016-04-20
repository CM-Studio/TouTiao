//
//  NetWorkFetcher.swift
//  TouTiao
//
//  Created by tesths on 4/11/16.
//  Copyright © 2016 tesths. All rights reserved.
//

import Cocoa
import Alamofire

class NetWorkFetcher: NSObject {
    let url = "http://toutiao.io/"
    
    func uniq<S: SequenceType, E: Hashable where E==S.Generator.Element>(source: S) -> [E] {
        var seen: [E:Bool] = [:]
        return source.filter { seen.updateValue(true, forKey: $0) == nil }
    }
    
    
    func getReleases(done: (model: [TTModel]?) -> ()) {
        Alamofire.request(.GET, url)
            .responseData { response in
                guard let html = response.result.value else {
                    return done(model: nil)
                }

        }
    }
}
