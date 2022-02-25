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
    
    // MARK: - Props
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Methods
    
    func externalRequest<Response: Decodable>(_ path: String,
                                               method: HTTPMethod,
                                               parameters: [String: Any]? = nil,
                                               queryParameters: [String: Any]? = nil,
                                               headers: HTTPHeaders? = nil,
                                               completion: DataClosure<Response?>?) {
      
        let request = createDataRequest(path, method: method, parameters: parameters, queryParameters: queryParameters, headers: headers)
        requestDecodable(request) { (response: Response?) in
            completion?(response)
        }
    }
    
    func externalArrayRequest<Response: Decodable>(_ path: String,
                                                   completion: DataClosure<[Response]?>?) {
        let request = createDataRequest(path, method: method, parameters: parameters, queryParameters: queryParameters, headers: headers)
        requestDecodable(request) { (response: [Response]?) in
            completion?(response)
        }
    }
}

// MARK: - Supporting methods
public extension AFManager {
    
    func requestDecodable<Response: Decodable>(_ request: DataRequest, completion: DataClosure<Response?>?) {
        request.responseDecodable(of: Response.self, decoder: decoder) { response in
            completion?(response.value)
        }
    }
    
    func createDataRequest(_ path: String,
                           method: HTTPMethod,
                           parameters: [String: Any]? = nil,
                           queryParameters: [String: Any]? = nil,
                           headers: HTTPHeaders? = nil) -> DataRequest {
        
        var urlString = path
        if let queryParameters = queryParameters {
            urlString += queryParameters.queryString
        }
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        return AF.request(urlString, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}

public extension AFManager {
    
    struct UnhandledResponse: Decodable { // нужен для обозначения отсутствия необходимости в дешифровке респонса. Может понадобится при работе с дерьмовым бэком
        let nothing: String?
    }
}
