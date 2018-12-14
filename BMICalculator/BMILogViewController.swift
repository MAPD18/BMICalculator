//
//  BMILogViewController.swift
//  BMICalculator
//
//  Created by Rodrigo Silva on 2018-12-13.
//  Copyright © 2018 Rodrigo Silva. All rights reserved.
//

import UIKit

class BMILogViewController: UIViewController {

    @IBAction func onAddBMIButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Height", style: .default) { (alertAction) in
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Height"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Weight"
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            let textField = alert.textFields![0] as UITextField
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
