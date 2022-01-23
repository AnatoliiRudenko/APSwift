//
//  ImageManager.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 16.12.2021.
//

import UIKit
import Kingfisher

enum ImageManager {
    
    static var urlStringPrefix: String?
}

// MARK: - Full URL String methods
extension ImageManager {
    
    static func load(urlSting: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlSting = urlSting,
              let url = URL(string: urlSting)
        else {
            completion(nil)
            return
        }
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    static func load(urlStrings: [String?], completion: @escaping DataClosure<[UIImage?]>) {
        let dispatchGroup = DispatchGroup()
        var dict = [Int: UIImage?]()
        for (index, urlString) in urlStrings.enumerated() {
            dispatchGroup.enter()
            load(urlSting: urlString, completion: { image in
                dict[index] = image
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            completion(dict.valuesSortedByKey)
        }
    }
}

// MARK: - Suffix URL String methods
extension ImageManager {
    
    static func load(urlStringSuffix: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlStringPrefix = urlStringPrefix,
              let urlStringSuffix = urlStringSuffix,
              let url = URL(string: urlStringPrefix + urlStringSuffix)
        else {
            completion(nil)
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    static func load(urlStringsSuffixes: [String?], completion: @escaping DataClosure<[UIImage?]>) {
        let dispatchGroup = DispatchGroup()
        var dict = [Int: UIImage?]()
        for (index, urlStringSuffix) in urlStringsSuffixes.enumerated() {
            dispatchGroup.enter()
            load(urlStringSuffix: urlStringSuffix) { image in
                dict[index] = image
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(dict.valuesSortedByKey)
        }
    }
}

// MARK: - YouTube Thumbnail
extension ImageManager {
    
    static func load(youtubeID: String?, completion: @escaping (UIImage?) -> Void) {
        guard let youtubeID = youtubeID,
              let url = URL(string: "https://img.youtube.com/vi/\(youtubeID)/default.jpg")
        else {
            completion(nil)
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}
