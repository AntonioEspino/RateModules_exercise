//
//  RegisterViewController.swift
//  RateModules
//
//  Created by user164220 on 24/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK : - GlobalsVar
    
    let modules: [Module] = [.module2A, .module2B , .module3A, .module3B]
    var optionChosed:Module?
    
    // MARK : - Outlets
    
    @IBOutlet weak var studentNameTextField: UITextField!
    @IBOutlet weak var startRatingOutlet: UIButton!
    @IBOutlet weak var modulePicker: UIPickerView!
    
    // MARK : - Actions
    
    @IBAction func startRatingButton(_ sender: UIButton) {
        optionChosed = modules[modulePicker.selectedRow(inComponent: 0)]
        performSegue(withIdentifier: RateModuleViewController.showRateModuleSegue, sender: self)
    }
    @IBAction func tapWhenWriting(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        updateUI()
    }
    
    // MARK : - ViewControler Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentNameTextField.delegate = self
        updateUI()
    }
    
    // MARK : - Update UI
    
    func updateUI () {
        if studentNameTextField.text == "" {
            startRatingOutlet.isEnabled = false
        }else{
            startRatingOutlet.isEnabled = true
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == RateModuleViewController.showRateModuleSegue,
            let rateModuleViewController = segue.destination as? RateModuleViewController else { return }
        rateModuleViewController.optionChosed = optionChosed
        rateModuleViewController.studentName = studentNameTextField.text
    }
    @IBAction func unwindToRegisterfromRate(unwindSegue: UIStoryboardSegue) {
        studentNameTextField.text = ""
        startRatingOutlet.isEnabled = false    }
    @IBAction func unwindToRegisterfromResultsList(unwindSegue: UIStoryboardSegue) {
        
    }
    
}

// MARK : - DatePickerDelegate

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

// MARK : - TextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateUI()
        return	true
    }
}
