//
//  token.swift
//  Blackboard 3LO
//
//  Created by Scott Hurrey on 8/21/17.
//  Copyright © 2017 Blackboard Developer Community. All rights reserved.
//

import Foundation

class Token {
    static let sharedInstance = Token()
    
    var access_token: String?
    var user_id: String?
}
