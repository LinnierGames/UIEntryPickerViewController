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
    
    public var scrollView: UIScrollView {
        return self._scrollView
    }
    
    private lazy var _scrollView: ScrollView = {
        let sv = ScrollView()
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
        
        clipsToBounds = true
        
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
    
    /**
     delegate the touches made in self to the scroll view. Since the frame of the
     scroll view does not expand to the bounds of self, touches are limited to the
     frame of the scroll view. This will expand touches made inside self to pan
     the scroll view
     */
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else {
            return nil
        }
        
        if view === self, self.subviews.count > 0 {
            return self.subviews[0] as! UIScrollView
        } else {
            return view
        }
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

}

fileprivate protocol ScrollViewEventDelegate: class {
//    func scrollView(_ scrollView: ScrollView, didTap)
}

fileprivate class ScrollView: UIScrollView {
    
//    unowned var delegate: ScrollViewEventDelegate
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tap(_ gesture: UITapGestureRecognizer) {
        let pageSize = bounds.size
        let location = gesture.location(in: self)
        
        guard location.x <= self.contentSize.width else {
            return
        }
        
        let tappedPageIndex = Int(location.x / pageSize.width)
        self.setContentOffset(CGPoint(x: pageSize.width * CGFloat(tappedPageIndex), y: 0), animated: true)
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}
