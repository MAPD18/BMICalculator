//
//  BMILogViewController.swift
//  BMICalculator
//
//  Created by Rodrigo Silva on 2018-12-13.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import UIKit
import CoreData

class BMILogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bmiList = [BmiLogEntry]()
    var height : Float = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onAddBMIButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Add new Log Entry", message: "Whats is your weight Today?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Weight"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            let textField = alert.textFields![0] as UITextField
            let bm = BmiLogEntry()
            bm.date = Date()
            bm.weight = Float(textField.text!)!
            self.bmiList.append(bm)
            self.tableView.reloadData()
            
            self.saveLogEntry(entry: bm)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveLogEntry(entry: BmiLogEntry) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: AppConstants.log_entry_entity, in: context)
        let newLogEntry = NSManagedObject(entity: entity!, insertInto: context)
        newLogEntry.setValue(entry.weight, forKey: AppConstants.log_entry_weight)
        newLogEntry.setValue(entry.date, forKey: AppConstants.log_entry_date)
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        height = UserDefaults.standard.float(forKey: AppConstants.height_key)
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: AppConstants.log_entry_entity)
                //request.predicate = NSPredicate(format: "age = %@", "12")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                        let logEntry = BmiLogEntry()
                        logEntry.weight = data.value(forKey: AppConstants.log_entry_weight) as! Float
                        logEntry.date = data.value(forKey: AppConstants.log_entry_date) as! Date
                        bmiList.append(logEntry)
                    }
                    tableView.reloadData()
                } catch {
                    print("Failed")
                }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bmiLogEntryCell", for: indexPath) as! BmiLogEntryCell
        
        cell.weight.text = String(bmiList[indexPath.row].weight)
        cell.date.text = bmiList[indexPath.row].date.description
        let status = calculateBmi(weight: bmiList[indexPath.row].weight)
        cell.status.text = status.rawValue
        cell.backgroundColor = getBackgroundByStatus(status: status)
        return cell
    }
    
    func calculateBmi(weight: Float) -> BmiStatus {
        let bmi = Float(weight)/pow(height, 2)
        switch bmi {
        case 0..<16:
            return BmiStatus.severeThinness
        case 16..<17:
            return BmiStatus.moderateThinness
        case 17..<18.5:
            return BmiStatus.mildThinness
        case 18.5..<25:
            return BmiStatus.normal
        case 25..<30:
            return BmiStatus.overweight
        case 30..<35:
            return BmiStatus.obeseClassI
        case 35..<40:
            return BmiStatus.obeseClassII
        default:
            return BmiStatus.obeseClassIII
        }
    }
    
    func getBackgroundByStatus(status: BmiStatus) -> UIColor {
        switch status {
        case .severeThinness, .obeseClassIII:
            return UIColor(red: 96/255, green: 20/255, blue: 0, alpha: 1)
        case .obeseClassII, .obeseClassI, .moderateThinness:
            return UIColor(red: 176/255, green: 36/255, blue: 0, alpha: 1)
        case .mildThinness, .overweight:
            return UIColor(red: 201/255, green: 115/255, blue: 0, alpha: 1)
        case .normal:
            return UIColor(red: 21/255, green: 196/255, blue: 91/255, alpha: 1)
        }
    }

}

class BmiLogEntry {
    var weight : Float = 0
    var date = Date()
}

enum BmiStatus : String {
    case severeThinness
    case moderateThinness
    case mildThinness
    case normal
    case overweight
    case obeseClassI
    case obeseClassII
    case obeseClassIII
}
