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

public class UIEntryPickerViewController: UIViewController {
    
    public weak var delegate: UIEntryPickerViewControllerDelegate?
    
    public var headerText: String
    
    public var messageText: String
    
    //TODO: use a computed var
    public var entries: [UIEntryPickerView.Entry]
    
    public var defaultEntryIndex: Int = 0
    
    public var dismissButtonTitle: String = "Done"
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 24.0
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        
        container.layer.cornerRadius = 12.0
        container.backgroundColor = UIColor.white
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var pickerView: UIEntryPickerView = {
        let picker = UIEntryPickerView(focusSize: CGSize(width: 72, height: 72), entries: self.entries)
        picker.scrollView.delegate = self
        
        return picker
    }()
    
    public init(headerText: String, messageText: String = "", values: [UIEntryPickerView.Entry]) {
        self.headerText = headerText
        self.messageText = messageText
        self.entries = values
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    public convenience init(headerText: String, messageText: String = "", values: UIEntryPickerView.Entry...) {
        self.init(headerText: headerText, messageText: messageText, values: values)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        headerText = ""
        messageText = ""
        entries = []
        
        super.init(coder: aDecoder)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    public func scrollTo(pageIndex: Int) {
        guard pageIndex > 0 else { return }
        
        let pageOffset = CGFloat(pageIndex) * self.pickerView.focusSize.width
        if pageOffset <= self.pickerView.scrollView.contentSize.width {
            self.pickerView.scrollView.setContentOffset(CGPoint(x: pageOffset, y: 0), animated: true)
        }
    }
    
    public override func loadView() {
        super.loadView()
        
        //Header label
        let headerLabel = UILabel()
        headerLabel.text = self.headerText
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textAlignment = .center
        self.stackView.addArrangedSubview(headerLabel)
        
        //Description label
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = self.messageText
        descriptionLabel.textAlignment = .center
        self.stackView.addArrangedSubview(descriptionLabel)
        
        //scroll view picker
        self.stackView.addArrangedSubview(pickerView)
        
        //ok button
        let okButton = UIButton(type: .system)
        okButton.addTarget(self, action: #selector(pressDone(_:)), for: .touchUpInside)
        okButton.setTitle(self.dismissButtonTitle, for: .normal)
        okButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
        self.stackView.addArrangedSubview(okButton)
        
        //Layout
        self.containerView.addSubview(self.stackView)
        self.stackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8.0).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 8.0).isActive = true
        
        self.view.addSubview(self.containerView)
        self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 12.0).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 12.0).isActive = true
        self.containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        self.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16.0).isActive = true
        
        self.view.layoutIfNeeded()
        
        //scroll to default page
        self.scrollTo(pageIndex: self.defaultEntryIndex)
    }
    
    // MARK: - IBACTIONS
    
    @objc private func pressDone(_ button: UIButton) {
        delegate?.entryPicker?(self, didFinishWith: self.pickerView.selectedPage)
        self.presentingViewController?.dismiss(animated: true)
    }
    
    public func show() {
        //TODO: present above all of the views
    }
    
    // MARK: - LIFE CYCLE
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.35)
    }

}

extension UIEntryPickerViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}
