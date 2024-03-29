//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 30.03.2022.
//

import UIKit

public struct Swipe {
    public var onLeft: DataClosure<UISwipeGestureRecognizer>? {
        didSet {
            didSetDirection?(.left)
        }
    }
    public var onRight: DataClosure<UISwipeGestureRecognizer>? {
        didSet {
            didSetDirection?(.right)
        }
    }
    public var onDown: DataClosure<UISwipeGestureRecognizer>? {
        didSet {
            didSetDirection?(.down)
        }
    }
    public var onUp: DataClosure<UISwipeGestureRecognizer>? {
        didSet {
            didSetDirection?(.up)
        }
    }
    public var onAny: DataClosure<UISwipeGestureRecognizer>? {
        didSet {
            onLeft = onAny
            onRight = onAny
            onDown = onAny
            onUp = onAny
        }
    }
    
    public var didSetDirection: DataClosure<UISwipeGestureRecognizer.Direction>?
}
