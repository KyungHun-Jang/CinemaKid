//
//  MasterViewController.swift
//  CinemaKid
//
//  Created by ktds 10 on 03/05/2019.
//  Copyright © 2019 kt ds. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    let modelCinema = CinemaModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //zeroing weak pointer
        //weak var a = CinemaModel()
        //var b = a
        
        //weak var weakSelf:MasterViewController? = self
        
        modelCinema.requestToServer(){ [weak self] in
//            if let selfStrong = weakSelf {
//                selfStrong.tableView.reloadData()
//            }
            self?.tableView.reloadData()
            
        }
        //modelCinema.afterUpdateUI = {}
        
        //감시하려는 객체에게 옵저버 추가
        //K.V.O
        //modelCinema.addObserver(self, forKeyPath: #keyPath(CinemaModel.arrayResult), options: [.initial, .new], context: nil)
        
        //NotificationCenter.default.addObserver(forName: Noti_didReceiveMovieList, object: nil, queue: .main, using: {_ in self.tableView.reloadData()})
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        OperationQueue.main.addOperation {
//            self.tableView.reloadData()
//        }
//
//    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelCinema.arrayResult.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = modelCinema.arrayResult[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = movie["title"] as? String
        cell.detailTextLabel?.text = movie["genre"] as? String

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

}

