//
//  BMILogViewController.swift
//  BMICalculator
//
//  Created by Rodrigo Silva on 2018-12-13.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import UIKit

class BMILogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bmiList = [BmiLogEntry]()
    var height : Float = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onAddBMIButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Weight"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            let textField = alert.textFields![0] as UITextField
            let bm = BmiLogEntry()
            bm.date = Date()
            bm.weight = Int(textField.text!)!
            self.bmiList.append(bm)
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        height = UserDefaults.standard.float(forKey: "height")
        // Do any additional setup after loading the view.
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
        cell.status.text = calculateBmi(weight: bmiList[indexPath.row].weight).rawValue
        
        return cell
    }
    
    func calculateBmi(weight: Int) -> BmiStatus {
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

}

class BmiLogEntry {
    var weight = 0
    var height = 0
    var date = Date()
    var status = ""
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
