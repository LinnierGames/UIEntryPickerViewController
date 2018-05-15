//
//  UIEntryPickerViewController.swift
//  UINumberPicker
//
//  Created by Erick Sanchez on 5/14/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

@objc public protocol UIEntryPickerViewControllerDelegate: class {
    @objc optional func entryPicker(_ entryPickerViewController: UIEntryPickerViewController, didFinishWith selectedIndex: Int)
}

public class UIEntryPickerViewController: UIPickerViewController {
    
    public weak var delegate: UIEntryPickerViewControllerDelegate?
    
    //TODO: use a computed var
    public var entries: [UIEntryPickerView.Entry]
    
    public var defaultEntryIndex: Int = 0
    
    private lazy var pickerView: UIEntryPickerView = {
        let picker = UIEntryPickerView(focusSize: CGSize(width: 72, height: 72), entries: self.entries)
        
        return picker
    }()
    
    public init(headerText: String, messageText: String = "", values: [UIEntryPickerView.Entry]) {
        self.entries = values
        
        super.init(headerText: headerText, messageText: messageText)
    }
    
    public convenience init(headerText: String, messageText: String = "", values: UIEntryPickerView.Entry...) {
        self.init(headerText: headerText, messageText: messageText, values: values)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        entries = []
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - RETURN VALUES
    
    public override func layoutConent() -> [UIView] {
        
        //scroll view picker
        return [pickerView]
    }
    
    // MARK: - VOID METHODS
    
    public func scrollTo(pageIndex: Int) {
        guard pageIndex > 0 else { return }
        
        let pageOffset = CGFloat(pageIndex) * self.pickerView.focusSize.width
        if pageOffset <= self.pickerView.scrollView.contentSize.width {
            self.pickerView.scrollView.setContentOffset(CGPoint(x: pageOffset, y: 0), animated: true)
        }
    }
    
    public override func pressDone(button: UIButton) {
        delegate?.entryPicker?(self, didFinishWith: self.pickerView.selectedPage)
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //scroll to default page
        self.scrollTo(pageIndex: self.defaultEntryIndex)
    }

}
