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
    let domain: String = "quiet-dusk-4540.herokuapp.com"

    var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    var session: NSURLSession
    var queue = NSOperationQueue.mainQueue()
    
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
    
    func GETrequest(endpoint: String, query: String?, completionFunction: (info: NSDictionary, error: NSError?) -> Void) {
        var urlString = "\(self.protcol)" + "\(self.domain)" + "\(endpoint)"
        if query != nil {
            urlString += "?\(query!)"
        }
        let url = NSURL(fileURLWithPath: urlString)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        var dataTask = self.session.dataTaskWithRequest(request, completionHandler: { (data, httpResponse, error) -> Void in
            if error != nil {
                println(error.description)
            }
            else {
                if let response = httpResponse as? NSHTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        var err: NSError?
                        if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as? NSDictionary {
                            self.queue.addOperationWithBlock({ () -> Void in
                                completionFunction(info: dictionary, error: error)
                            })
                        }
                    default:
                        println(response.statusCode)
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    
    func POSTrequest(endpoint: String, query: String?, dictionary: NSDictionary?, completionFunction: (postResponse: NSDictionary, error: NSError?) -> Void) -> Void {
        var urlString = "\(self.protcol)" + "\(self.domain)" + "\(endpoint)"
        let url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!)
        var error: NSError?
        var postData: NSData?
        if dictionary != nil {
            postData = NSJSONSerialization.dataWithJSONObject(dictionary!, options: nil, error: &error)
        }
        else {
            postData = nil
        }
        if error != nil {
            println(error?.localizedDescription)
        }
//        let length = postData!.length
        request.HTTPMethod = "POST"
//        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        let dataTask = self.session.dataTaskWithRequest(request, completionHandler: { (responseData, httpResponse, error) -> Void in
            if error != nil {
                println(error.description)
            }
            else {
                if let response = httpResponse as? NSHTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        println(response.statusCode)
                        var err: NSError?
                        var parsedData = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: &err) as NSDictionary
                        self.queue.addOperationWithBlock({ () -> Void in
                            completionFunction(postResponse: parsedData, error: error)
                        })
                    default:
                        println(response.statusCode)
                    }
                }
            }
        })
        dataTask.resume()
    }
}