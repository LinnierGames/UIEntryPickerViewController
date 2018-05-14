//
//  UINumberPickerViewController.swift
//  UINumberPicker
//
//  Created by Erick Sanchez on 5/14/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

public class UINumberPickerViewController: UIViewController {
    
    public var headerText: String
    
    public var messageText: String
    
    public var dismissButtonTitle: String = "Done"
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16.0
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        
        container.layer.cornerRadius = 8.0
        container.backgroundColor = UIColor.lightGray
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    public init(headerText: String, messageText: String = "", values: String...) {
        self.headerText = headerText
        self.messageText = messageText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        headerText = ""
        messageText = ""
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    public override func loadView() {
        super.loadView()
        
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        //Header label
        let headerLabel = UILabel()
        headerLabel.text = self.headerText
        self.stackView.addArrangedSubview(headerLabel)
        
        //Description label
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = self.messageText
        self.stackView.addArrangedSubview(descriptionLabel)
        
        //scroll view picker
        let picker = UIView()
        picker.heightAnchor.constraint(equalToConstant: 72.0).isActive = true
        picker.backgroundColor = .blue
        self.stackView.addArrangedSubview(picker)
        
        //ok button
        let okButton = UIButton(type: .system)
        okButton.setTitle(self.dismissButtonTitle, for: .normal)
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
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.35)
    }

}
