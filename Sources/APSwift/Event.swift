//
//  Event.swift
//  
//
//  Created by Анатолий Руденко on 10.01.2022.
//

import Foundation

class Event<Object>: NSObject {
    
    typealias NotificationWithObject = NotificationObject<Object>
    
    struct NotificationObject<Object> {
        let sender: Event<Object>
        let object: Object?
    }
    
    let notificationName: Notification.Name
    var handleSameRecipientSenders: Bool = false
    
    var didReceiveWithObject: DataClosure<Object>?
    var didReceive: Closure?
    
    init(notificationName: Notification.Name) {
        self.notificationName = notificationName
    }
    
    convenience override init() {
        let name = String(describing: Self.self)
        self.init(notificationName: .init(name))
    }
    
    func subscribe() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.handleNotification(_:)),
            name: self.notificationName,
            object: nil
        )
    }
    
    func post(object: Object? = nil) {
        let data = NotificationWithObject(sender: self, object: object)
        NotificationCenter.default.post(name: self.notificationName, object: data)
    }
    
    @objc
    private func handleNotification(_ notification: Notification) {
        guard let data = notification.object as? NotificationWithObject else { return }
        
        if !self.handleSameRecipientSenders, data.sender == self {
            return
        }
        
        guard notification.name == self.notificationName else { return }
        self.didReceive?()
        
        guard let object = data.object else { return }
        self.didReceiveWithObject?(object)
    }
}
