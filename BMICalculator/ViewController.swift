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
    
    let genders = ["Male", "Female"]
    var genderSelectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserProfile")
//        //request.predicate = NSPredicate(format: "age = %@", "12")
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                nameOutlet.text = data.value(forKey: "name") as? String
//                ageOutlet.text = data.value(forKey: "age") as? String
//                //genderPickerView.selectedRow(inComponent: (data.value(forKey: "age") as? Int)!)
//                print(data.value(forKey: "name") as! String)
//            }
//            
//        } catch {
//            
//            print("Failed")
//        }
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
    
    @IBAction func onSaveButtonClicked(_ sender: Any) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let entity = NSEntityDescription.entity(forEntityName: "UserProfile", in: context)
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
//
//        newUser.setValue(nameOutlet.text, forKey: "name")
//        newUser.setValue(Int(ageOutlet.text!), forKey: "age")
//        newUser.setValue(genderSelectedRow, forKey: "gender")
//
//        do {
//            try context.save()
//        } catch {
//            print("ERROR")
//        }
        
        
    }
    
    

}

