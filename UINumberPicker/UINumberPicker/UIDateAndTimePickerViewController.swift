//
//  UIDateAndTimePickerViewController.swift
//  UIEntryPicker
//
//  Created by Erick Sanchez on 5/15/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

public class UIDateAndTimePickerViewController: UIPickerViewController {
    
    public var date: Date
    
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
        let pickerView = UIDatePicker()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.datePickerMode = .date
        pickerView.date = self.date
        
        let addTimeButton = UIButton(type: .system)
        addTimeButton.setTitle("Add Time", for: .normal)
        
        return [pickerView, addTimeButton]
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
}
