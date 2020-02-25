//
//  RegisterViewController.swift
//  RateModules
//
//  Created by user164220 on 24/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let modules: [Module] = [.module2A, .module2B , .module3A, .module3B]
    var optionChoosed = Module.module2A
    
    @IBAction func tapWhenWriting(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
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
        optionChoosed = modules[row]
        print(optionChoosed)
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func startRatingButton(_ sender: UIButton) {
        performSegue(withIdentifier: RateModuleViewController.showRateModuleSegue, sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
    }
    

}
