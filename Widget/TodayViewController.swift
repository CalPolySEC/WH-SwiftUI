//
//  TodayViewController.swift
//  Widget
//
//  Created by Stephen Parkinson on 6/4/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var i = 0;
    var status: String!
    @IBOutlet weak var statusImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getJsonFromUrl()
        while (status == nil && i <= 10) {
            sleep(1)
            i += 1
        }
        addImageToUIImageView(statusStr: status)
    }
    
    func addImageToUIImageView(statusStr: String) {
        let statImg: UIImage = UIImage(named: statusStr)!
        statusImg.image = statImg
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func getJsonFromUrl() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)
        
        let url = URL(string: "http://thewhitehat.club/api/v1/status")
        session.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
                let jStatus = json["data"] as? Dictionary<String, Any>
                let jStatus2 = jStatus?["status"] as? String ?? "nil"
                self.status = jStatus2
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
}

