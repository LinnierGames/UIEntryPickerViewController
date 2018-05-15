//
//  UICalendarDatePickerViewController.swift
//  UIEntryPicker
//
//  Created by Erick Sanchez on 5/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

public class UICalendarDatePickerViewController: UIDatePickerViewController {
    
    public var isTimeIncluded: Bool = false
    
    public var canAddDate: Bool = true
    
    public var canAddTime: Bool = false
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    public override func layoutConent() -> [UIView] {
        
        //TODO: configure datePickerView
        
        let content = super.layoutConent()
        
        //add time button
        let addTimeButton = UIButton(type: .system)
        addTimeButton.setTitle("Add Time", for: .normal)
        addTimeButton.addTarget(self, action: #selector(pressAddTime(_:)), for: .touchUpInside)
        
        return content + [addTimeButton]
    }
    
    // MARK: - IBACTIONS
    
    @objc private func pressAddTime(_ button: UIButton) {
        let timePickerVc = UIDatePickerViewController(headerText: nil, messageText: "select a time", date: self.date)
        timePickerVc.datePickerMode = .time
        timePickerVc.delegate = self
        self.present(timePickerVc, animated: true)
    }
    
    // MARK: - LIFE CYCLE
    
}

extension UICalendarDatePickerViewController: UIDatePickerViewControllerDelegate {
    public func datePicker(_ datePicker: UIDatePickerViewController, didFinishWith selectedDate: Date) {
        
        //update self.date with only the time from UIDatePickerVc
        self.date = selectedDate
    }
}

// MARK: - UIDatePickerViewControllerDelegate

@objc public protocol UIDatePickerViewControllerDelegate: class {
    @objc optional func datePicker(_ datePicker: UIDatePickerViewController, didFinishWith selectedDate: Date)
}

public class UIDatePickerViewController: UIPickerViewController {
    
    public weak var delegate: UIDatePickerViewControllerDelegate?
    
    public var datePickerMode: UIDatePickerMode = .date
    
    public var date: Date {
        didSet {
            self.datePickerView.setDate(self.date, animated: true)
        }
    }
    
    public private(set) lazy var datePickerView: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.datePickerMode = self.datePickerMode
        pickerView.date = self.date
        pickerView.addTarget(self, action: #selector(changedDatePickerValue(_:)), for: .valueChanged)
        
        return pickerView
    }()
    
    public init(headerText: String?, messageText: String? = "", date: Date) {
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
        return [datePickerView]
    }
    
    public override func pressDone(button: UIButton) {
        delegate?.datePicker?(self, didFinishWith: self.date)
    }
    
    @objc private func changedDatePickerValue(_ datePicker: UIDatePicker) {
        self.date = datePicker.date
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
}
