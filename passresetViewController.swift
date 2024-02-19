//
//  passresetViewController.swift
//  June20Proj
//
//  Created by Rahul on 6/17/20.
//  Copyright © 2020 Rahul. All rights reserved.
//
import NotificationBannerSwift
import UIKit
import FirebaseAuth
class passresetViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var passbut: UIButton!
    func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           emailAdress.resignFirstResponder()
       }
      
       
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
           emailAdress.endEditing(true)
           if emailAdress.text == "" {
              emailAdress.placeholder = "Email Address"
               errmess.isHidden = true
           }

           return true
       }
       func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
          
     
           emailAdress.endEditing(true)
            if emailAdress.text == "" {
              emailAdress.placeholder = "Email Address"
               errmess.isHidden = true
           }
       }
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var errmess: UILabel!
    
    @IBAction func sendmail(_ sender: UIButton) {
        let mailvalidity: Bool = self.isValidEmail(emailAdress.text!)
        if emailAdress.text != "" && mailvalidity == true{
            Auth.auth().sendPasswordReset(withEmail: emailAdress.text!)
            let banner = NotificationBanner(title: "Request Sent", subtitle: "Check your email for further instruction", leftView: nil, rightView: nil, style: .info, colors: nil)
            
            banner.autoDismiss = false
            banner.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                banner.dismiss()
            })
            self.dismiss(animated: true, completion: nil)
        } else {
            errmess.isHidden = false
            errmess.text = "Please enter a valid email."
            
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
