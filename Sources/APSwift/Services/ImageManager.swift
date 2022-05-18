//
//  ImageManager.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 16.12.2021.
//

import UIKit
import Kingfisher

public enum ImageManager {
    
    static var urlStringPrefix: String?
}

// MARK: - URL methods
public extension ImageManager {
    
    static func load(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url
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
    
    static func load(urls: [URL?], completion: @escaping DataClosure<[UIImage?]>) {
        let dispatchGroup = DispatchGroup()
        var dict = [Int: UIImage?]()
        for (index, url) in urls.enumerated() {
            dispatchGroup.enter()
            load(url: url, completion: { image in
                dict[index] = image
                dispatchGroup.leave()
            })
        }
        dispatchGroup.notify(queue: .main) {
            completion(dict.valuesSortedByKey)
        }
    }
}

// MARK: - Full URL String methods
public extension ImageManager {
    
    static func load(urlString: String?, completion: @escaping (UIImage?) -> Void) {
        load(url: URL(string: urlString ?? ""), completion: completion)
    }
    
    static func load(urlStrings: [String?], completion: @escaping DataClosure<[UIImage?]>) {
        load(urls: urlStrings.map { URL(string: $0 ?? "") }, completion: completion)
    }
}

// MARK: - Suffix URL String methods
public extension ImageManager {
    
    static func load(urlStringSuffix: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlStringPrefix = urlStringPrefix,
              let urlStringSuffix = urlStringSuffix,
              let url = URL(string: urlStringPrefix + urlStringSuffix)
        else {
            completion(nil)
            return
        }
        load(url: url, completion: completion)
    }
    
    static func load(urlStringsSuffixes: [String?], completion: @escaping DataClosure<[UIImage?]>) {
        guard let urlStringPrefix = urlStringPrefix else {
            completion([])
            return
        }
        let urls = urlStringsSuffixes.map { URL(string: urlStringPrefix + ($0 ?? "")) }
        load(urls: urls, completion: completion)
    }
}

// MARK: - YouTube Thumbnail
public extension ImageManager {
    
    static func load(youtubeID: String?, completion: @escaping (UIImage?) -> Void) {
        guard let youtubeID = youtubeID,
              let url = URL(string: "https://img.youtube.com/vi/\(youtubeID)/default.jpg")
        else {
            completion(nil)
            return
        }
        load(url: url, completion: completion)
    }
}
