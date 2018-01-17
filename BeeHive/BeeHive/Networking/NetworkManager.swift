//
//  NetworkManager.swift
//  BeeHive
//
//  Created by Gambrell, John on 1/17/18.
//  Copyright © 2018 JPG. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    func addUser(user: User, completion: () -> Bool){
        
        //http://127.0.0.1:8080/v1/jobmanager/getjobsbymanager/4
        Alamofire.request("http://127.0.0.1:8080/v1/jobmanager/getjobsbymanager/4").response { (response) in
            do {
                let j = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: AnyObject]
                debugPrint(j)
                
            }
            catch _ as NSError {
                print("error")
            }
        }
        }

}
