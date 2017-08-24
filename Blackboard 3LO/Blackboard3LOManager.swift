//
//* Blackboard3LO.swift
//* Blackboard 3LO
//
//* Created by Scott Hurrey on 8/21/17.
//* Copyright © 2017 Blackboard Developer Community. All rights reserved.
//* Redistribution and use in source and binary forms, with or without
//* modification, are permitted provided that the following conditions are met:
//*
//*  -- Redistributions of source code must retain the above copyright
//*     notice, this list of conditions and the following disclaimer.
//*
//*  -- Redistributions in binary form must reproduce the above copyright
//*     notice, this list of conditions and the following disclaimer in the
//*     documentation and/or other materials provided with the distribution.
//*
//*  -- Neither the name of Blackboard Inc. nor the names of its contributors
//*     may be used to endorse or promote products derived from this
//*     software without specific prior written permission.
//*
//* THIS SOFTWARE IS PROVIDED BY BLACKBOARD INC ``AS IS'' AND ANY
//* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//* DISCLAIMED. IN NO EVENT SHALL BLACKBOARD INC. BE LIABLE FOR ANY
//* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//


import Foundation
import Alamofire

class Blackboard3LOManager
{
    static let sharedInstance = Blackboard3LOManager()
 
    var DOMAIN: String = ""
    var CLIENT_ID: String = ""
    var OAUTH_KEY: String = ""
    var OAUTH_SECRET: String = ""
    
    var nonce: String = ""

    
    // handlers for the OAuth process
    // stored as vars since sometimes it requires a round trip to safari which
    // makes it hard to just keep a reference to it
    var OAuthTokenCompletionHandler:((NSError?) -> Void)?
    
    func hasOAuthToken() -> Bool
    {
        // TODO: implement
        return false
    }
    
    // MARK: - OAuth flow
    
    func startOAuth2Login()
    {
        //var settings: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "bb-config", ofType: "plist"), let settings = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            DOMAIN = (settings["DOMAIN"] as? String)!
            OAUTH_KEY = (settings["OAUTH_KEY"] as? String)!
            OAUTH_SECRET = (settings["OAUTH_SECRET"] as? String)!
        }
        
        nonce = randomAlphaNumericString(length: 32)
        
        print("NONCE: \(nonce)")

        
        //let base64String = nonce!.base64EncodedStringWithOptions(NSDataBase64EncodingOption‌​s(0))
        
        let authPath:String = "\(DOMAIN)/learn/api/public/v1/oauth2/authorizationcode?redirect_uri=bb3LO://&response_type=code&client_id=\(OAUTH_KEY)&scope=read&state=\(nonce)"
        
            if let authURL:NSURL = NSURL(string: authPath)
        {
            UIApplication.shared.open(authURL as URL)
        }
    }
    
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    func processOAuthStep1Response(url: URL)
    {
        print("DEBUG: processing authorization code")
        let components = NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false)
        var code:String?
        if let queryItems = components?.queryItems
        {
            print(queryItems)
            for queryItem in queryItems
            {
                print(queryItem)
                if (queryItem.name.lowercased() == "code")
                {
                    code = queryItem.value
                    print(code!)
                }
                if (queryItem.name.lowercased() == "state")
                {
                    let state = queryItem.value
                    print("NONCE: \(nonce) STATE: \(state!)")
                    
                    if (nonce != state)
                    {
                        //TODO: implement some really cool CSRF handling
                        print("DOH! You are a haxor!")
                    }
                }
            }
        }
        
        if let receivedCode = code
        {
            let authEndpoint = "\(DOMAIN)/learn/api/public/v1/oauth2/token?redirect_uri=bb3LO://&code=" + receivedCode
                
            let body = [ "grant_type" : "authorization_code" ]
            
            var headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            
            if let authorizationHeader = Request.authorizationHeader(user: OAUTH_KEY, password: OAUTH_SECRET) {
                headers[authorizationHeader.key] = authorizationHeader.value
            }

            
            Alamofire.request(authEndpoint, method: .post, parameters: body, headers: headers).responseJSON
            {
                (response) in
                    print(response)
               
                    if let json = response.result.value {
                        print("JSON: \(json)") // serialized json response
                        
                        if let dictionary = json as? [String: Any] {
                            if let access_token = dictionary["access_token"] as? String, let user_id = dictionary["user_id"] as? String {
                                print("access_token: \(access_token) user_id: \(user_id)")
                                
                                Token.sharedInstance.access_token = access_token
                                Token.sharedInstance.user_id = user_id
                                
                                
                            }
                        }
                    }
                
                
            }
        }
    }
    
}

