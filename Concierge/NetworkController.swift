//
//  NetworkController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import Foundation

class NetworkController {
    let protcol: String = "https://"
    let domain: String = "salty-earth-1782.herokuapp.com"

    var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    var session: NSURLSession
    var queue = NSOperationQueue.mainQueue()
    
    var numberOfJWTChecks = 0
    
    var storageController = StorageController.sharedInstance
    
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
    
    func GETrequest(endpoint: String, query: String?, completionFunction: (info: AnyObject, error: NSError?) -> Void) {
        var urlString = "\(self.protcol)" + "\(self.domain)" + "\(endpoint)"
        if query != nil {
            urlString += "?\(query!)"
        }
        let url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if self.storageController.user.jwtToken != nil {
            request.setValue(self.storageController.user.jwtToken!, forHTTPHeaderField: "jwt")
        }
        var dataTask = self.session.dataTaskWithRequest(request, completionHandler: { (data, httpResponse, error) -> Void in
            if error != nil {
                println(error.description)
            }
            else {
                if let response = httpResponse as? NSHTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        var err: NSError?
                        if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &err) as? NSDictionary {
                            self.queue.addOperationWithBlock({ () -> Void in
                                completionFunction(info: dictionary, error: error)
                            })
                        }
                        if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &err) as? NSArray {
                            self.queue.addOperationWithBlock({ () -> Void in
                                completionFunction(info: array, error: error)
                            })
                        }
                        else {
                            println("Error on GET: Return Object is not an NSArray or NSDictionary")
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
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        if self.storageController.user.jwtToken != nil {
            request.setValue(self.storageController.user.jwtToken!, forHTTPHeaderField: "jwt")
        }
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
    
    
    func PUTrequest(endpoint: String, query: String?, dictionary: NSDictionary?, completionFunction: (postResponse: NSDictionary, error: NSError?) -> Void) -> Void {
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
        request.HTTPMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        if self.storageController.user.jwtToken != nil {
            request.setValue(self.storageController.user.jwtToken!, forHTTPHeaderField: "jwt")
        }
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