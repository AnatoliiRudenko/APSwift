//
//  AFManager.swift
//  
//
//  Created by Анатолий Руденко on 03.02.2022.
//

import Foundation
import Alamofire

open class AFManager: NSObject {
    
    static var shared = AFManager()
    
    var shouldLog = true
    
    enum HeaderType {
        case none
        case regular
        case temporary
        case adaptive
        case authBasic(user: String, password: String)
    }
    
    struct UnhandledResponse: Decodable { // нужен для обозначения отсутствия необходимости в дешифровке респонса. Может понадобится при работе с дерьмовым бэком
        let nothing: String?
    }
    
    // MARK: - Methods
    
    func externalRequest<Response: Decodable>(_ path: String,
                                              completion: DataClosure<Response?>?) {
        requestData(path,
                    method: .get,
                    headers: nil) { data in
            completion?(self.handleData(data))
        }
    }
    
    func externalArrayRequest<Response: Decodable>(_ path: String,
                                                   completion: DataClosure<[Response]?>?) {
        requestData(path,
                    method: .get,
                    headers: nil) { data in
            completion?(self.handleArrayData(data))
        }
    }
}

// MARK: - Supporting methods
public extension AFManager {
    
    func requestData(_ path: String,
                     method: HTTPMethod,
                     parameters: [String: Any]? = nil,
                     queryParameters: [String: Any]? = nil,
                     headers: HTTPHeaders?,
                     completion: DataClosure<Data?>?) {
        
        var urlString = path
        if let queryParameters = queryParameters {
            urlString += queryParameters.queryString
        }
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        AF.request(urlString, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
            if self.shouldLog {
                print(response)
            }
            
            if self.shouldLog, let httpStatusCode = response.response?.statusCode {
                print("RESPONSE CODE: \(httpStatusCode)")
            }
            
            switch response.result {
            case .success:
                completion?(response.data)
            case .failure(let error):
                print("Request error: \(error)")
                completion?(nil)
            }
        }
    }
    
    // to override for custom decoding and printing errors
    func checkForErrorResponse(_ data: Data) {}
    
    func handleData<Response: Decodable>(_ data: Data?) -> Response? {
        guard let data = data,
              Response.self != UnhandledResponse.self
        else {
            return nil
        }
        do {
            let result: Response = try data.decodedObject()
            return result
        } catch {
            print("Custom decoding error: \(error)")
            return nil
        }
    }
    
    func handleArrayData<Response: Decodable>(_ data: Data?) -> [Response]? {
        guard let data = data else { return nil }
        do {
            let result: [Response] = try data.decodedArray()
            return result
        } catch {
            print("Custom decoding error: \(error)")
            return nil
        }
    }
}
