//
//  DonatingViewController.swift
//  June20Proj
//
//  Created by Rahul on 5/29/22.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class DonatingViewController: UIViewController {
    var ref: DatabaseReference! = Database.database().reference()
    var database = Database.database()
    let userID = Auth.auth().currentUser?.uid
    @IBOutlet weak var errmesage: UILabel!
    @IBOutlet weak var wagerTF: UITextField!
    
    @IBOutlet weak var codeTF: UITextField!
    @IBAction func didSubmit(_ sender: Any) {
        //valid codes: WHO, NAACP, UNHCR, FA, TEAMTREES, TEAMSEAS, PETA, STJUDE, UNICEF, WATER
        //Orgs- COVID (WHO), BLM (NAACP), Ukraine (UNHCR), Hunger (FA), TeamTrees, TeamSeas, Animal (PETA), Cancer (STJUDE), Poverty (Unicef), Water
     
        //check for valid wager
        if let wagered = Int(String(self.wagerTF.text!)) as? Int{
            
        if (codeIsValid(code: String(codeTF.text!))) {
            
           
             let profilePath7 = self.ref.child("users").child(self.userID!)
                       
                       profilePath7.observeSingleEvent(of: .value, with: { (snapshot) in
                           let snapValue = snapshot.value as? NSDictionary
                           
                           var pts = snapValue!["points"] as? Int
                         var donpts = snapValue!["donation_points"] as? Int
                          
                        if (pts! >= wagered) {
                            self.ref.child("users").child(self.userID!).child("points").setValue(pts! - wagered)
                            self.ref.child("users").child(self.userID!).child("donation_points").setValue(donpts! + wagered)
                            let profilePath6 = self.ref.child("charities")
                                       
                                       profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                           let snapValue = snapshot.value as? NSDictionary
                                           
                                        var currentVal = snapValue![String(self.codeTF.text!).uppercased()] as? Int
                                           
                                        self.ref.child("charities").child(String(self.codeTF.text!).uppercased()).setValue(wagered+currentVal!)
                                        self.performSegue(withIdentifier: "jdonated", sender: self)
                                        
                                      
                                                   
                                                 
                                           
                                           
                                           
                                       })
                            
                        } else {
                            
                            self.errmesage.isHidden = false
                            self.errmesage.text = "Not enough cash coins"
                        }
                           
                       })
        } else {
            
            //handle invalid code
             errmesage.isHidden = false
            self.errmesage.text = "Invalid Charity Code"
        }
        } else {
            //handle invalid wager
             errmesage.isHidden = false
            self.errmesage.text = "Invalid Wager (Enter #cc Only)"
        }
    }
    func codeIsValid(code: String)->Bool{
       
        if code.uppercased() == "WHO" {
     
            return true
        } else if code.uppercased() == "NAACP" {
            return true
            
        } else if code.uppercased() == "UNHCR" {
            return true
            
        } else if code.uppercased() == "FA" {
            return true
            
        } else if code.uppercased() == "TEAMTREES" {
            return true
            
        } else if code.uppercased() == "TEAMSEAS" {
            return true
            
        } else if code.uppercased() == "PETA" {
            return true
            
        } else if code.uppercased() == "STJUDE" {
            return true
            
        } else if code.uppercased() == "UNICEF" {
            return true
            
        } else if code.uppercased() == "WATER" {
            return true
            
        }
        return false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        errmesage.isHidden = true
        let returnBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backup))
                                                           
                                                           self.navigationItem.leftBarButtonItem  = returnBarButtonItem
                                              
        // Do any additional setup after loading the view.
    }
    @objc func backup(){
                                                      self.performSegue(withIdentifier: "backwardy", sender: self)
                                                      
                                                      
                                                      
                                                      
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
