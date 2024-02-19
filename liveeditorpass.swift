//
//  liveeditorpass.swift
//  June20Proj
//
//  Created by Rahul on 7/13/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import Firebase

class liveeditorpass: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwTF.resignFirstResponder()
    }
    
      var ref = Database.database().reference()
    @IBOutlet weak var spass: UIButton!
    @IBOutlet weak var passwTF: UITextField!
    @IBOutlet weak var errormess: UILabel!
    @IBAction func submitPass(_ sender: UIButton) {
        print("req")
        if passwTF.text == "" || passwTF.text == " " {
            errormess.text = "Please enter a valid password"
            
        } else {
            if codes.contains(passwTF.text!) {
                self.performSegue(withIdentifier: "create", sender: self)
                
            } else {
                errormess.text = "Password is incorrect."
            }
            
            
        }
        
    }
    
    
    @IBAction func passRequested(_ sender: UIButton) {
print("req")
        self.ref.child("passwordrequests").child(Auth.auth().currentUser!.uid).setValue(Auth.auth().currentUser!.email)
        let alert = UIAlertController(title: "Password Requested", message: "We have put in your request for a password. We will send you an email regarding your request soon.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
        
        spass.isHidden = true
        
    }
    
    
  
    var codes: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
          spass.isHidden = false
        errormess.text = ""
        passwTF.text = ""
        passwTF.placeholder = "Password"
         let userID = Auth.auth().currentUser?.uid
                   let profilePath = ref.child("contests")
                profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                                     let snapValue = snapshot.value as? NSDictionary
                                            //fix google sign in problem (when they don't have an ccount)
                                   
                                                
                                             var allcodes = snapValue?["passwords"] as? [String] ?? [""]
                    self.codes = allcodes
                      
                    
                                           
                                                 })
        
        
        
        
        
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
