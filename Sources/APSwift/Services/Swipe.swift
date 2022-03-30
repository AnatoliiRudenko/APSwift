//
//  File.swift
//  
//
//  Created by Анатолий Руденко on 30.03.2022.
//

import UIKit

public struct Swipe {
    public var onLeft: DataClosure<UISwipeGestureRecognizer>?
    public var onRight: DataClosure<UISwipeGestureRecognizer>?
    public var onDown: DataClosure<UISwipeGestureRecognizer>?
    public var onUp: DataClosure<UISwipeGestureRecognizer>?
    
    internal var didSetDirection: DataClosure<UISwipeGestureRecognizer.Direction>?
}
