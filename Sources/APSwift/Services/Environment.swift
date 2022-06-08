//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 09.06.2022.
//

import Foundation

public enum Environment {
    
    case debug
    case testFlight
    case prod
    
    init() {
        if Environment.isTestFlight {
            self = .testFlight
        }
        if Environment.isDebug {
            self = .debug
        }
        self = .prod
    }
}

private extension Environment {
    
    static var isTest: Bool {
        isTestFlight || isDebug
    }
    
    static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
