//
//  TFViewController.swift
//  TriviaGPT
//
//  Created by Rahul on 2/17/24.
//  Copyright © 2024 Rahul. All rights reserved.
//

import UIKit

class TFViewController: UIViewController, UISearchTextFieldDelegate {
    @IBAction func didnewtriv(_ sender: Any) {
        if topic.text == "" {
            curtop.topic = "RANDOM"
        } else {
            curtop.topic = topic.text ?? "Random"
        }
    }
    
    @IBOutlet weak var topic: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getStarted.layer.cornerRadius = 25

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var getStarted: UIButton!
    func textFieldDidEndEditing(_ textField: UITextField) {
        topic.endEditing(true)
     
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topic.endEditing(true)
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        topic.resignFirstResponder()
 
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
