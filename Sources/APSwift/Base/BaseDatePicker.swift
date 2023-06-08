//
//  File.swift
//  
//
//  Created by Anatolii Rudenko on 08.06.2023.
//

import UIKit

open class BaseDatePicker: UIDatePicker {
    
    public var didSelectDate: DataClosure<Date>?
    
    public init() {
        super.init(frame: .zero)
        addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    open func datePickerValueChanged(_ sender: UIDatePicker) {
        self.didSelectDate?(sender.date)
    }
}
