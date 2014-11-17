//
//  NetworkController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import Foundation

class NetworkController {
    let protcol: String = "http://"
    let domain: String = "configURL"

    var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    var session: NSURLSession
    
    init() {
        self.session = NSURLSession(configuration: self.configuration)
    }
    
    class var sharedInstance : NetworkController {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : NetworkController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = NetworkController()
        }
        return Static.instance!
    }
    
    func GETrequest(endpoint: String, query: String?, completionFunction: (info: NSDictionary, error: NSError) -> Void) {
        var urlString = "\(self.protcol)" + "\(self.domain)" + "\(endpoint)"
        if query != nil {
            urlString += "?\(query!)"
        }
        let url = NSURL(fileURLWithPath: urlString)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        var dataTask = self.session.dataTaskWithRequest(request, completionHandler: { (data, httpResponse, error) -> Void in
            
        })
        dataTask.resume()
    }
    
    func POSTrequest(endpoint: String, query: String, info: AnyObject) -> Void {
        var urlString = "\(self.protcol)" + "\(self.domain)" + "\(endpoint)"
        let url = NSURL(fileURLWithPath: urlString)
        var request = NSMutableURLRequest(URL: url!)
        var postData = urlString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let length = postData!.length

        request.HTTPMethod = "POST"
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
    }
}