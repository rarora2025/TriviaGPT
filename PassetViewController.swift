//
//  passresetViewController.swift
//  June20Proj
//
//  Created by Rahul on 6/17/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class PasSet: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var passbut: UIButton!
    var ref: DatabaseReference! = Database.database().reference()
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           emailAdress.resignFirstResponder()
       }
      
       
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
           emailAdress.endEditing(true)
           if emailAdress.text == "" {
              emailAdress.placeholder = "Password"
               errmess.isHidden = true
           }

           return true
       }
       func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
          
     
           emailAdress.endEditing(true)
            if emailAdress.text == "" {
              emailAdress.placeholder = "Password"
               errmess.isHidden = true
           }
       }
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var errmess: UILabel!
    
    @IBAction func sendmail(_ sender: UIButton) {
     
        if emailAdress.text != "" {
            let userID = Auth.auth().currentUser?.uid
                          let profilePath = self.ref.child("users").child(userID!)
                                            
                                              profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                                        let snapValue = snapshot.value as? NSDictionary
                                                  
                                                 
                                                 var email2 = snapValue?["Email"] as? String ?? "Unknown_User"
                                                
                                          let credentialy = EmailAuthProvider.credential(withEmail: email2, password: self.emailAdress.text!)
                                          Auth.auth().currentUser?.link(with: credentialy, completion: nil)

                                              
                                                   
                         
                                   
                                                   
                                                 
                                              
                                                    })
            
            
            
            
             self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Password").setValue(self.emailAdress.text!)

            self.dismiss(animated: true, completion: nil)
        
        } else {
            errmess.isHidden = false
            errmess.text = "Please enter a valid password."
            
        }
        
    }
    override func viewDidLoad() {
        
        emailAdress.delegate = self
        errmess.isHidden = true
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
