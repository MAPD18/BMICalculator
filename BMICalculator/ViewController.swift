//
//  ViewController.swift
//  BMICalculator
//
//  Created by Rodrigo Silva on 2018-12-13.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var ageOutlet: UITextField!
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet weak var heightOutlet: UITextField!
    
    let genders = ["Male", "Female"]
    var genderSelectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        initFormFromLocalStorage()
    }
    
    // Init TextFields with informations stored at UserDefaults
    func initFormFromLocalStorage() {
        if let name = UserDefaults.standard.string(forKey: AppConstants.name_key) {
            nameOutlet.text = name
        }
        let age = UserDefaults.standard.integer(forKey: AppConstants.age_key)
        ageOutlet.text = String(age)
        
        let height = UserDefaults.standard.float(forKey: AppConstants.height_key)
        heightOutlet.text = String(height)
        
        let gender = UserDefaults.standard.integer(forKey: AppConstants.gender_key)
        genderPickerView.selectRow(gender, inComponent: 0, animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genderSelectedRow = row
        return genders[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        //save user information on UserDefaults storage
        UserDefaults.standard.set(nameOutlet.text!, forKey: AppConstants.name_key)
        UserDefaults.standard.set(Int(ageOutlet.text!), forKey: AppConstants.age_key)
        UserDefaults.standard.set(Float(heightOutlet.text!), forKey: AppConstants.height_key)
        UserDefaults.standard.set(genderSelectedRow, forKey: AppConstants.gender_key)
        
        // Shows an popup giving feedback about the process
        let alert = UIAlertController(title: "Successfull", message: "User Record Saved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onResetClicked(_ sender: Any) {
        // Clear UserDefaults records
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize();
        
        // Clear CoreData Entuty records
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: AppConstants.log_entry_entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            let alert = UIAlertController(title: "Successfull", message: "The App was Reset", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } catch {
            print ("There was an error")
        }
    }
    
}

