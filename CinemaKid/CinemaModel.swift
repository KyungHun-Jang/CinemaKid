//
//  CinemaModel.swift
//  CinemaKid
//
//  Created by ktds 10 on 03/05/2019.
//  Copyright © 2019 kt ds. All rights reserved.
//

import Foundation

class CinemaModel {
    
    var arrayResult:[[String:Any]] = []
    
    func requestToServer() {
        let stringURL = "http://z.ebadaq.com:45070/CinemaKid/movie/list/"
        let url = URL(string: stringURL)!
        do {
            let rValue = try String(contentsOf: url, encoding: .utf8)
            
            let data = rValue.data(using: .utf8)!
            
            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            let temp = result as! [String:Any]
            //let movies = temp["data"] as! [[String:Any]]
            
            self.arrayResult = temp["data"] as! [[String:Any]]
            //print(movies)
        } catch {}
    }
    
}
