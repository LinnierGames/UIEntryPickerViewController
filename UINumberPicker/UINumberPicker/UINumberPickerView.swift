//
//  UINumberPickerView.swift
//  UINumberPicker
//
//  Created by Erick Sanchez on 5/14/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

public class UINumberPickerView: UIView {
    
    public enum EntryType {
        case Major(String)
        case Minor(String)
        case EmptyMajor
        case EmptyMinor
    }
    
    public private(set) lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        sv.widthAnchor.constraint(equalToConstant: self.focusSize.width).isActive = true
        sv.heightAnchor.constraint(equalToConstant: self.focusSize.height).isActive = true
        
        sv.clipsToBounds = false
        sv.showsHorizontalScrollIndicator = false
        sv.isPagingEnabled = true
        
        sv.layer.borderColor = UIColor.red.cgColor
        sv.layer.borderWidth = 1.0
        
        return sv
    }()
    
    public private(set) var entries: [EntryType]
    
    public private(set) var focusSize: CGSize
    
    public private(set) var majorAttributes: [NSAttributedStringKey: Any]
    
    public private(set) var minorAttributes: [NSAttributedStringKey: Any]
    
    public init(
        frame: CGRect = CGRect.zero,
        focusSize: CGSize,
        majorAttributes: [NSAttributedStringKey: Any] = [:],
        minorAttributes: [NSAttributedStringKey: Any] = [:],
        entries: [EntryType]) {
        self.entries = entries
        self.focusSize = focusSize
        self.majorAttributes = majorAttributes
        self.minorAttributes = minorAttributes
        
        super.init(frame: frame)
        
        self.initLayout()
    }
    
    public convenience init(frame: CGRect = CGRect.zero, focusSize: CGSize, entries: EntryType...) {
        self.init(frame: frame, focusSize: focusSize, entries: entries)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        entries = []
        self.focusSize = CGSize.zero
        self.majorAttributes = [:]
        self.minorAttributes = [:]
        
        super.init(coder: aDecoder)
        
        self.initLayout()
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    private func initLayout() {
        
        /** contains the labels to be scroll horizontally */
        let horzStackView = UIStackView()
        horzStackView.axis = .horizontal
        horzStackView.alignment = .fill
        horzStackView.distribution = .fillEqually
        horzStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //create uilabels with entry type
        for anEntry in self.entries {
            let entryTextValue: String?
            let entryColorValue: UIColor
            
            switch anEntry {
            case .Major(let string):
                entryTextValue = string
                entryColorValue = .green
            case .Minor(let string):
                entryTextValue = string
                entryColorValue = .blue
            case .EmptyMajor:
                entryTextValue = nil
                entryColorValue = .green
            case .EmptyMinor:
                entryTextValue = nil
                entryColorValue = .blue
            }
            
            let label = UILabel()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: self.focusSize.width).isActive = true
            label.text = entryTextValue
            
            //entry type using a calayer
//            let entryTypeShape = CAShapeLayer()
//            entryTypeShape.frame = CGRect(x: 0, y: label.bounds.height - 4.0, width: label.bounds.width, height: 4.0)
//            entryTypeShape.fillColor = entryColorValue.cgColor
//            label.layer.addSublayer(entryTypeShape)
            
            label.layer.borderColor = UIColor.blue.cgColor
            label.layer.borderWidth = 1.0
            
            horzStackView.addArrangedSubview(label)
        }
        
        //layout scroll view
        self.scrollView.addSubview(horzStackView)
        horzStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        horzStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        horzStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        horzStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        horzStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        let widthConstraint = horzStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        widthConstraint.isActive = true
        
        addSubview(self.scrollView)
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

}
