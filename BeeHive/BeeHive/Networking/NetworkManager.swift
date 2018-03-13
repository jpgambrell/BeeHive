//
//  NetworkManager.swift
//  BeeHive
//
//  Created by Gambrell, John on 1/17/18.
//  Copyright © 2018 JPG. All rights reserved.
//

import UIKit


class NetworkManager: NSObject {
    
    
    
    
    
    
    
    
    func addUser(user: User, completion: @escaping (_ response : Any) -> ()){
        
        
        
//        let headers: HTTPHeaders = [
//            "Accept" : "application/json",
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//
//        Alamofire.request("http://127.0.0.1:8080/v1/hiveadmin/adduser", method:.post, parameters: user.asDictionary(),encoding: URLEncoding.httpBody, headers:headers).responseJSON { response in
//
//            switch response.result {
//            case .success:
//                print("we added user")
//                completion(response.result)
//            case .failure(let error):
//                print("faield to added user")
//                 completion(response.result)
//                print(error.localizedDescription)
//            }
//        }

       
    }
    
    func getUser(userId: String){
        let session = URLSession(configuration: .default)
        
        if let url  = URL(string: "http://127.0.0.1:8080/v1/jobmanager/getjobsbymanager/4")   {
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }
                else if let response = response,
                    let data = data
                {
                print(response)
    
                    let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonResponse!)
                   // print(error)
                }
            }).resume()
                
            }
            
        }
}
