//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 15.06.2022.
//

import Foundation

public extension URLRequest {
    
    var curlString: String {
        let method = "--location --request " + "\(self.httpMethod ?? "GET") "
        // no matter what I do, the apostrophe always displays as "\'". If you know how to fix that - please let me know. Until then - have to mannulally delete all the \ to get a valid curl
        let apostrophe = #"'"#
        let url: String = "\(apostrophe)\(self.url?.absoluteString ?? "")\(apostrophe)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key, value) in httpHeaders {
                header += " --header " + "\(apostrophe)\(key): \(value)\(apostrophe)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data \(apostrophe)\(bodyString)\(apostrophe)"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
}
