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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let vc = UINumberPickerViewController()
        self.present(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

