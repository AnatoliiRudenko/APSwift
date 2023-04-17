//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 07.02.2023.
//

import Foundation

/**
 Do you need to make several concurrent async calls disregarding the order? Good.
 call() method will return once every call returned
 
 Only to be used with async/await syntax!
 */

public struct ConcurrentTasksHandler<T> {
    
    let tasks: [ConcurrentTask<T>]
    
    public init(tasks: [ConcurrentTask<T>]) {
        self.tasks = tasks
    }
    
    @MainActor
    public func call() async -> [T?] {
        return await withCheckedContinuation({ continuation in
            let group = DispatchGroup()
            var dict = [Int: T?]()
            for (index, task) in tasks.enumerated() {
                group.enter()
                Task {
                    let response = await task.action()
                    dict[index] = response as? T
                    task.callback?(response as? T)
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                continuation.resume(returning: dict.valuesSortedByKey)
            }
        })
    }
}

// MARK: - Example
/*
 let tasks: [ConcurrentTask<Any>] = [.init(action: vm.fetchCodedValues),
                                     .init(action: HPService.shared.getProfile, callback: { object in
                                         print(object as? String)
                                     })]
 let handler = ConcurrentTasksHandler(tasks: tasks)
 await handler.call()
 -> all tasks are completed, callbacks are called
 */
