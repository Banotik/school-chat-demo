//
//  Util.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import Foundation

final class Logger{
    

    static func d(clzz: String, description: String){
        print("\(clzz) : \(description)")
    }
}

final class PubNubApi{
    static let publishKey = "pub-c-fa963e8c-3c58-4cb4-867b-4702f438526d"
    static let subscribeKey = "sub-c-c56ea9ee-0ac6-11e8-91e5-7e24e7929117"
}

