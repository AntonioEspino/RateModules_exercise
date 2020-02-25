//
//  RegisterViewController.swift
//  RateModules
//
//  Created by user164220 on 24/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let modules: [Module] = [.module2A, .module2B , .module3A, .module3B]
    var optionChosed:Module = .module2A
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var startRatingOutlet: UIButton!
    
    @IBAction func startRatingButton(_ sender: UIButton) {
        performSegue(withIdentifier: RateModuleViewController.showRateModuleSegue, sender: self)
    }
    @IBAction func tapWhenWriting(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        if studentNameTextField.text == "" {
                  startRatingOutlet.isEnabled = false
              }else{
                  startRatingOutlet.isEnabled = true
              }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        studentNameTextField.delegate = self
       
    }
    override func viewWillAppear(_ animated: Bool) {
        studentNameTextField.text = ""
        startRatingOutlet.isEnabled = false
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == RateModuleViewController.showRateModuleSegue,
     let rateModuleViewController = segue.destination as? RateModuleViewController else { return }
        rateModuleViewController.optionChosed = optionChosed
        rateModuleViewController.studentName = studentNameTextField.text
    }
    @IBAction func unwindToRegister(unwindSegue: UIStoryboardSegue) {
        
    }
    

}
extension RegisterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modules[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modules.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        optionChosed = modules[row]
      
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if studentNameTextField.text == "" {
            startRatingOutlet.isEnabled = false
        }else{
            startRatingOutlet.isEnabled = true
        }
        
        return	true
    }
}
