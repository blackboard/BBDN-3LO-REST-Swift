//
//  ResultTableViewController.swift
//  Blackboard 3LO
//
//  Created by Scott Hurrey on 8/22/17.
//  Copyright © 2017 Blackboard Developer Community. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ResultTableViewController: UITableViewController {
    
    
    var myMemberships: [Membership]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = Token.sharedInstance.access_token
        let user = Token.sharedInstance.user_id
        
        self.tableView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
        
        
        print("Load Results - access_token: \(token ?? "token") user_id: \(user ?? "user")")
        
        let headers = [
            "Authorization" : "Bearer \(token ?? "token")"
        ]
        
        Alamofire.request("\(Blackboard3LOManager.sharedInstance.DOMAIN)/learn/api/public/v1/users/uuid:\(user ?? "user")/courses?limit=200", headers: headers).responseJSON
            {
                (response) in
                
                let json = JSON(data: response.data!)
                
                for (_,membership) in json["results"] {
                    //print("MEMBERSHIP: \(membership)") // serialized json response
                    
                    let ms = Membership()
                    
                    ms.courseId = membership["courseId"].string
                    ms.courseRoleId = membership["courseRoleId"].string
                    
                    self.myMemberships?.append(ms)
                }
                
                dump(self.myMemberships)
                self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let memberships = self.myMemberships {
            print("COUNT: \(memberships.count)")
            return memberships.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MembershipCell", for: indexPath)
        
        let membership = self.myMemberships?[indexPath.row]
        
        if let membership = membership {
            cell.textLabel?.text = "COURSEID: \(membership.courseId ?? "Course Not Found")"
            if membership.courseRoleId == "Instructor" {
                cell.imageView?.image = UIImage(named: "instructor")
            } else {
                cell.imageView?.image = UIImage(named: "learner")
            }
        }
        
        return cell
    }
}
