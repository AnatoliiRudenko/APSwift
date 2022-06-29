//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 15.06.2022.
//

import Foundation

public extension URLRequest {
    
    // run po print(request.curlString) in debug console
    // or print(request.curlString) from code
    // to get desired string printed without extra backslashes
    var curlString: String {
        let method = "--location --request " + "\(self.httpMethod ?? "GET") "
        let apostrophe = #"'"#
        let url: String = "\(apostrophe)\(self.url?.absoluteString ?? "")\(apostrophe)"
        
        var cURL = "curl "
        var header = ""
        var data = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key, value) in httpHeaders {
                header += " --header " + "\(apostrophe)\(key): \(value)\(apostrophe)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = " --data \(apostrophe)\(bodyString)\(apostrophe)"
        }
        
        cURL += method + url + header + data
        return cURL
    }
}
