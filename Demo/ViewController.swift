//
//  ViewController.swift
//  Demo
//
//  Created by Erick Sanchez on 5/14/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit
import UIPickers

class ViewController: UIViewController {
    
    let entries: [UIEntryPickerView.Entry] = [
        .major(with: "None"), .minor(with: "15min"), .minor(with: "30min"), .minor(with: "45min"),
        .major(with: "1hr"), .minor(with: "1hr 30min"),
        .minor(with: "2hr"), .minor(with: "2hr 30min"),
        .minor(with: "3hr"), .minor(with: "3hr 30min"),
        .minor(with: "4hr"), .minor(with: "4hr 30min"),
        .minor(with: "5hr"), .minor(with: "5hr 30min"),
        .minor(with: "6hr"), .minor(with: "6hr 30min"),
        .minor(with: "7hr"), .minor(with: "7hr 30min"),
        .minor(with: "8hr")]

    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var button: UIButton!
    @IBAction func pressButton(_ sender: Any) {
        let vcDate = UIDateAndTimePickerViewController(headerText: "Deadline", messageText: "When is this task due", date: Date(timeIntervalSince1970: 1))
        vcDate.delegate = self
        self.present(vcDate
            , animated: true)
        return
        
        let vc = UIEntryPickerViewController(headerText: "Duration", messageText: "How long will this task take to complete", values: entries)
        vc.delegate = self
        vc.defaultEntryIndex = 4
        self.present(vc, animated: true)
    }
    
    // MARK: - LIFE CYCLE
}

extension ViewController: UIEntryPickerViewControllerDelegate {
    func entryPicker(_ entryPickerViewController: UIEntryPickerViewController, didFinishWith selectedIndex: Int) {
        button.setTitle(entries[selectedIndex].text, for: .normal)
    }
}

extension ViewController: UIDateAndTimePickerViewControllerDelegate {
    func dateAndTimePicker(_ dateAndTimePicker: UIDateAndTimePickerViewController, didFinishWith selectedDate: Date, and isTimeIncluded: Bool) {
        button.setTitle(String(describing: selectedDate), for: .normal)
    }
}

