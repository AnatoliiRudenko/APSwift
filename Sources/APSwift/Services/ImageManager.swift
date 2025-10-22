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
    
    static func load(url: URL?) async -> UIImage? {
        guard let url else { return nil }
        let resource = KF.ImageResource(downloadURL: url)

        return await withTaskCancellationHandler(operation: {
            await withCheckedContinuation { continuation in
                var resumed = false
                let lock = NSLock()

                func safeResume(_ image: UIImage?) {
                    lock.lock()
                    defer { lock.unlock() }
                    guard !resumed else { return }
                    resumed = true
                    continuation.resume(returning: image)
                }

                let task = KingfisherManager.shared.retrieveImage(
                    with: resource,
                    options: [.fromMemoryCacheOrRefresh],
                    progressBlock: nil
                ) { result in
                    switch result {
                    case .success(let value):
                        safeResume(value.image)
                    case .failure:
                        safeResume(nil)
                    }
                }

                // If the Task is cancelled before Kingfisher even starts
                if Task.isCancelled {
                    task?.cancel()
                    safeResume(nil)
                }
            }
        }, onCancel: {
            // Cancel any ongoing download if the surrounding Task is cancelled
            KingfisherManager.shared.downloader.cancel(url: url)
        })
    }

    
    static func load(urls: [URL?]) async -> [UIImage?] {
        let tasks: [ConcurrentTask<UIImage>] = urls.compactMap({ url in
            ConcurrentTask(action: { await ImageManager.load(url: url) }, callback: nil)
        })
        let handler = ConcurrentTasksHandler(tasks: tasks)
        let result = await handler.call()
        return result
    }
    
    static func cancel(_ url: URL?) {
        guard let url = url else { return }
        KingfisherManager.shared.downloader.cancel(url: url)
    }
}

// MARK: - Full URL String methods
public extension ImageManager {
    
    static func load(urlString: String?) async -> UIImage? {
        await load(url: URL(string: urlString ?? ""))
    }
    
    static func load(urlStrings: [String?]) async -> [UIImage?] {
        await load(urls: urlStrings.map { URL(string: $0 ?? "") })
    }
}

// MARK: - Suffix URL String methods
public extension ImageManager {
    
    static func load(urlStringSuffix: String?) async -> UIImage? {
        guard let urlStringPrefix = urlStringPrefix,
              let urlStringSuffix = urlStringSuffix,
              let url = URL(string: urlStringPrefix + urlStringSuffix)
        else {
            return nil
        }
        return await load(url: url)
    }
    
    static func load(urlStringsSuffixes: [String?]) async -> [UIImage?] {
        guard let urlStringPrefix = urlStringPrefix else { return [] }
        let urls = urlStringsSuffixes.map { URL(string: urlStringPrefix + ($0 ?? "")) }
        return await load(urls: urls)
    }
}

// MARK: - YouTube Thumbnail
public extension ImageManager {
    
    static func load(youtubeID: String?) async -> UIImage? {
        guard let youtubeID = youtubeID,
              let url = URL(string: "https://img.youtube.com/vi/\(youtubeID)/default.jpg")
        else {
            return nil
        }
        return await load(url: url)
    }
}
