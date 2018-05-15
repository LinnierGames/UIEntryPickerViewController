//
//  UIDateAndTimePickerViewController.swift
//  UIEntryPicker
//
//  Created by Erick Sanchez on 5/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

@objc public protocol UIDateAndTimePickerViewControllerDelegate: class {
    @objc optional func dateAndTimePicker(_ dateAndTimePicker: UIDateAndTimePickerViewController, didFinishWith selectedDate: Date, and isTimeIncluded: Bool)
}

public class UIDateAndTimePickerViewController: UIPickerViewController {
    
    public weak var delegate: UIDateAndTimePickerViewControllerDelegate?
    
    public var date: Date
    
    public var isTimeIncluded: Bool = false
    
    public init(headerText: String, messageText: String, date: Date) {
        self.date = date
        
        super.init(headerText: headerText, messageText: messageText)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.date = Date()
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    public override func layoutConent() -> [UIView] {
        
        //date picker
        let pickerView = UIDatePicker()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.datePickerMode = .date
        pickerView.date = self.date
        pickerView.addTarget(self, action: #selector(changedDatePickerValue(_:)), for: .valueChanged)
        
        //add time button
        let addTimeButton = UIButton(type: .system)
        addTimeButton.setTitle("Add Time", for: .normal)
        
        return [pickerView, addTimeButton]
    }
    
    public override func pressDone(button: UIButton) {
        delegate?.dateAndTimePicker?(self, didFinishWith: self.date, and: self.isTimeIncluded)
    }
    
    @objc private func changedDatePickerValue(_ datePicker: UIDatePicker) {
        self.date = datePicker.date
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
}
