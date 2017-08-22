//
//  Blackboard3LO.swift
//  Blackboard 3LO
//
//  Created by Scott Hurrey on 8/21/17.
//  Copyright © 2017 Blackboard Developer Community. All rights reserved.
//

import Foundation
import Alamofire

class Blackboard3LOManager
{
    static let sharedInstance = Blackboard3LOManager()
 
    var DOMAIN: String = ""
    var OAUTH_KEY: String = ""
    var OAUTH_SECRET: String = ""

    
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
        
        let authPath:String = "\(DOMAIN)/learn/api/public/v1/oauth2/authorizationcode?redirect_uri=bb3LO://&response_type=code&client_id=\(OAUTH_KEY)&scope=read&state=TEST_STATE"
        if let authURL:NSURL = NSURL(string: authPath)
        {
            UIApplication.shared.open(authURL as URL)
        }
    }
    
    func processOAuthStep1Response(url: URL)
    {
        print("DEBUG: processing authorization code")
        let components = NSURLComponents(url: url as URL, resolvingAgainstBaseURL: false)
        var code:String?
        if let queryItems = components?.queryItems
        {
            for queryItem in queryItems
            {
                if (queryItem.name.lowercased() == "code")
                {
                    code = queryItem.value
                    break
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

