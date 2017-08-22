//
//  ResultTableViewController.swift
//  Blackboard 3LO
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
