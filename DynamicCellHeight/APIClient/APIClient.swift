//
//  APIClient.swift
//  DynamicCellHeight
//
//  Created by Nagesh on 17/06/18.
//  Copyright © 2018 Nagesh Kumar Mishra. All rights reserved.
//

enum APIStatus : Error {
    case pass
    case fail
}

let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

import Foundation

class APIClient {
    
    // ReuestData will get the data from server and parse it using the Codable concept
    
    func requestData(completion: @escaping ((_ data: AboutCanada?, _ success: APIStatus) -> Void)) {
        
        var aboutCanadaData: AboutCanada?
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: urlString)! as URL
        let queue:OperationQueue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: queue) { (response, responseData, error) in
            if error == nil {
                
                // Data was received and parsed to String,As the content type was text/plain
                guard let dataString = String(data: responseData!, encoding: String.Encoding.ascii) else {
                    completion(nil, .fail) // Data string is null then send fail status 

                    return
                }
                // Converting the datastring to UTF8 format so we can decode using JSONDecoder
                let data :Data = dataString.data(using: String.Encoding.utf8)!
                do {
                    aboutCanadaData = try JSONDecoder().decode(AboutCanada.self, from: data)
                    completion(aboutCanadaData!, .pass)
                }  catch let err {
                    print(err)
                    completion(nil, .fail) // If any error occures send the fail status
                }
            } else {
                completion(nil, .fail)
            }
        }
    }
}
