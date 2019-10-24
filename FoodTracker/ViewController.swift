//
//  ViewController.swift
//  FoodTracker
//
//  Created by Mac on 2019/10/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK:Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
    }
    
    //MARK:UItextFieldDelagate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //set the label value
        mealNameLabel.text = textField.text
    }
    
    //MARK:Action
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default text"
    }
    


}

