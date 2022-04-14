//
//  Event.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 10.01.2022.
//

import Foundation

// MARK: - Event
open class Event<Object>: NSObject {
    
    // MARK: - Public props
    let notificationName: Notification.Name
    var handlesSameRecipientSenders = false
    var didReceiveWithObject: DataClosure<Object>?
    var didReceive: Closure?
    
    // MARK: - Methods
    open func subscribe() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.handleNotification(_:)),
            name: self.notificationName,
            object: nil
        )
    }
    
    open func post(object: Object? = nil) {
        let data = NotificationObjectType(sender: self, object: object)
        NotificationCenter.default.post(name: self.notificationName, object: data)
    }
    
    // MARK: - Init
    init(notificationName: Notification.Name) {
        self.notificationName = notificationName
    }
    
    convenience override init() {
        let name = String(describing: Self.self)
        self.init(notificationName: .init(name))
    }
    
    // MARK: - Private props
    private typealias NotificationObjectType = NotificationObject<Object>
    
    private struct NotificationObject<Object> {
        let sender: Event<Object>
        let object: Object?
    }
    
    // MARK: - Supporting methods
    @objc
    func handleNotification(_ notification: Notification) {
        guard let data = notification.object as? NotificationObjectType else { return }
        
        if !self.handlesSameRecipientSenders, data.sender == self {
            return
        }
        
        guard notification.name == self.notificationName else { return }
        self.didReceive?()
        
        guard let object = data.object else { return }
        self.didReceiveWithObject?(object)
    }
}
