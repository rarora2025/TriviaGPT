//
//  FinishInvestViewController.swift
//  June20Proj
//
//  Created by Rahul on 3/23/22.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FinishInvestViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stepp: UIStepper!
    @IBOutlet weak var errmes: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    var database = Database.database()
    let userID = Auth.auth().currentUser?.uid
    var unitser: Int = 1
    var canbet: Bool = false
    
    @IBAction func stepper(_ sender: Any) {
        errmes.isHidden = true
        unitser = Int(stepp.value)
        units.text  = String(describing: unitser)
        cost.text = "Cost: " + String(describing: currentInvestment.price*unitser)
        
    }
    
    @IBAction func didsubmit(_ sender: Any) {
        if currentInvestment.price*unitser <= money && canbet {
             //allowed
            ref.child("users").child(userID!).child("points").setValue(money-currentInvestment.price*unitser)
            ref.child("users").child(userID!).child("investments").child(currentInvestment.name).setValue(unitser)
            self.performSegue(withIdentifier: "finishedinvesting", sender: self)
           
        } else {
            errmes.isHidden = false
            errmes.text = "Not enough currency to do that"
        }
        
    }
    @IBOutlet weak var units: UILabel!
    @IBOutlet weak var cost: UILabel!
    var money: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        errmes.isHidden = true
        name.text = "Name: " + currentInvestment.name
        cost.text = "Cost: " + String(describing: currentInvestment.price*unitser)
        
        let profilePath0 = ref.child("users").child(userID!).child("points")
                   
                   profilePath0.observeSingleEvent(of: .value, with: { (snapshot) in
                    self.money = (snapshot.value as? Int)!
                       //fix google sign in problem (when they don't have an ccount)
                    self.canbet = true
   
                   })

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
