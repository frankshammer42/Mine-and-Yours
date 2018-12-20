//
//  postfunction.swift
//  mine_yours
//
//  Created by Frankshammer42 on 12/8/18.
//  Copyright © 2018 Frankshammer42. All rights reserved.
//

import Foundation

func post_to_controller_server(to_pass:String){
//    let index = type_times % 5
//    let to_pass:String = rotations_to_pass[index]
//    type_times += 1
//
    let parameters = ["position_to_rotate": to_pass]
    
    //create the url with URL
    let url = URL(string: "https://mine-yours-heroku.herokuapp.com/api/rotate")! //change the url
    
    //create the session object
    let session = URLSession.shared
    
    //now create the URLRequest object using the url object
    var request = URLRequest(url: url)
    request.httpMethod = "POST" //set http method as POST
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
    } catch let error {
        print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        guard error == nil else {
            return
        }
        
        guard let data = data else {
            return
        }
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        } else {
            print("not a valid UTF-8 sequence")
        }
        
    })
    task.resume()
}

