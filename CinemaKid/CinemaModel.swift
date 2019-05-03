//
//  CinemaModel.swift
//  CinemaKid
//
//  Created by ktds 10 on 03/05/2019.
//  Copyright © 2019 kt ds. All rights reserved.
//
import UIKit
import Foundation

//let Noti_didReceiveMovieList = NSNotification.Name(rawValue: "didReceiveMovieList")

typealias ClosureUpdateUI = () -> Void

class CinemaModel : NSObject {
    
    var afterUpdateUI:ClosureUpdateUI?
    //@objc dynamic var arrayResult:[[String:Any]] = []
    var arrayResult:[[String:Any]] = []
    
    //@eascaping 별도 스터디 필요
    func requestToServer(closureUpdateUI:ClosureUpdateUI?) {
        
        self.afterUpdateUI = closureUpdateUI
        
        let stringURL = "http://z.ebadaq.com:45070/CinemaKid/movie/list/"
        let url = URL(string: stringURL)!
        
        let request = URLRequest(url: url)
        
        //request.allHTTPHeaderFields
        //request.httpBody
        //request.httpMethod
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        
        let task = session.dataTask(with: request) {
            (data:Data?, resp:URLResponse?, err:Error?) in
            
            guard let d = data else {
                return
            }

            let result = try! JSONSerialization.jsonObject(with: d, options: .allowFragments)
            self.arrayResult = (result as! [String:Any])["data"] as! [[String:Any]]
            print(result)
            
            if let c = self.afterUpdateUI {
                OperationQueue.main.addOperation {
                    c()
                }
            }
            
            //NotificationCenter.default.post(name: Noti_didReceiveMovieList, object: nil)
            
//            OperationQueue.main.addOperation {
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                let vcNavi = appDelegate.window?.rootViewController as! UINavigationController
//                let vcMaster = vcNavi.viewControllers.first as! MasterViewController
//                vcMaster.tableView.reloadData()
//            }
        }
        task.resume()


//        do {
//            let rValue = try String(contentsOf: url, encoding: .utf8)
//
//            let data = rValue.data(using: .utf8)!
//
//            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//
//            let temp = result as! [String:Any]
//            //let movies = temp["data"] as! [[String:Any]]
//
//            self.arrayResult = temp["data"] as! [[String:Any]]
//            //print(movies)
//        } catch {}

    }
    
}
