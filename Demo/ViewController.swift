//
//  ViewController.swift
//  Demo
//
//  Created by Erick Sanchez on 5/14/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit
import UINumberPicker

class ViewController: UIViewController {

    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let entries: [UINumberPickerView.Entry] = [.major(with: "0"), .minor(with: "15min"), .minor(with: "30min"), .minor(with: "45min"), .major(with: "1hr"), .minor(with: "1hr 30min"), .minor(with: "2hr")]
        let vc = UINumberPickerViewController(headerText: "Duration", messageText: "How long will this task take to complete", values: entries)
        self.present(vc, animated: true)
    }
}

