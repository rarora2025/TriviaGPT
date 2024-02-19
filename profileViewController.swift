//check to  make sure that user doesn't change credentials to nothing or exsisting email or something invalid



//  profileViewController.swift
//  June20Proj
//
//  Created by Rahul on 6/28/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
struct MyVariables {
    static var autologin: Bool?
}


class profileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBAction func diddelete(_ sender: Any) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                // An error happened.
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    Database.database().reference().child("users").child(user?.uid ?? "").removeValue()
                    
                }
 
                self.performSegue(withIdentifier: "deleted", sender: self)
                // Account deleted and logout user
                //            do {
                //                try Auth.auth().signOut()
                // take you to root
                //                self.navigationController?.popToRootViewController(animated: true)
                
                
            }
        }
    }
    @IBOutlet weak var logswitch: UISwitch!
    @IBAction func didchangevalues(_ sender: UISwitch) {
        print("changed")
        if logswitch.isOn {
                   MyVariables.autologin = true
                   UserDefaults.standard.set(true, forKey: "switcher")
                   print(MyVariables.autologin)
               } else {
                   MyVariables.autologin = false
                   UserDefaults.standard.set(false, forKey: "switcher")
                    print(MyVariables.autologin)
               }
    }
    
    @IBOutlet weak var didchange: UISwitch!
    @IBAction func didChangeVal(_ sender: UISwitch) {
    }
    @IBOutlet weak var resetEmail: UIButton!

    var isemailvalid = true
    func isValidEmail(_ email: String) -> Bool {
             let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
             let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
             return emailPred.evaluate(with: email)
         }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailTF.text!)
        
    }
    
    @IBOutlet weak var emailTF: UITextField!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.editedImage] as? UIImage{
            let resizedImage2 = img.resized(to: CGSize(width: 100, height: 100))
            self.profPhoto.makeRounded()
            profPhoto.image = resizedImage2
        }
        picker.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var uploadImage: UIButton!
    
    @IBAction func pickNewImg(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
              myPickerController.delegate = self
               myPickerController.allowsEditing = true
               myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
               self.present(myPickerController, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var profPhoto: UIImageView!
    var ref: DatabaseReference! = Database.database().reference()
    var isEditingProf:Bool = false

    @IBOutlet weak var acind: UIActivityIndicatorView!
    override func viewDidLoad() {
        
        var onq = UserDefaults.standard.bool(forKey: "switcher")
        print("on q is " )
        print(onq)
        if onq == true {
             logswitch.setOn(true, animated: true)
             MyVariables.autologin = true
            
        } else {
            MyVariables.autologin = false
            logswitch.setOn(false, animated: true)
            
        }
       
        uploadImage.isHidden = true
        usernameTF.isUserInteractionEnabled = false
         emailTF.isUserInteractionEnabled = false
        super.viewDidLoad()
        acind.hidesWhenStopped = true
        acind.startAnimating()
        let editBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editUser))
        
        self.navigationItem.rightBarButtonItem  = editBarButtonItem
        let returnBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backup))
               
               self.navigationItem.leftBarButtonItem  = returnBarButtonItem
        let userID = Auth.auth().currentUser?.uid
                          let profilePath = ref.child("users").child(userID!)
                       
                         profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                   let snapValue = snapshot.value as? NSDictionary
                          //fix google sign in problem (when they don't have an ccount)
                     
                              
                                          var urlString = snapValue?["PhotoURL"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/june20proj.appspot.com/o/KYDOeR7wnicBWSUgyDYFSX5eq8y2.png?alt=media&token=3296413f-65bd-47e9-aece-8d80c7b9066a"
                        
                            var username = snapValue?["Username"] as? String ?? "Unknown_User"
                            var email = snapValue?["Email"] as? String ?? "Unknown_User"
                      

                                     let url = URL(string: urlString)
                                     let data = try? Data(contentsOf: url!)
                                      let ogImage = UIImage(data: data!)
                              let resizedImage = ogImage!.resized(to: CGSize(width: 100, height: 100))
                              self.profPhoto.makeRounded()
                                     self.profPhoto.image = resizedImage
                            
                            self.usernameTF.text = username
                            self.emailTF.text = email
                            self.acind.stopAnimating()
                           
                          
                         
                              
        //                      Auth.auth().sendPasswordReset(withEmail: mailString) { error in
        //                          // Your code here
        //                      }
                              
                            
                         
                               })

        // Do any additional setup after loading the view.
    }
   
    @objc func editUser(_ sender: UIBarButtonItem){
         isEditingProf = !isEditingProf
        
        if isEditingProf == true {
            sender.title = "Save"
            uploadImage.isHidden = false
            self.usernameTF.isUserInteractionEnabled = true
            self.emailTF.isUserInteractionEnabled = true
            //isediting
            
        } else {
            sender.title = "Edit"
            uploadImage.isHidden = true
             isemailvalid = self.isValidEmail(emailTF.text!)
           
            
            if usernameTF.text == "" || usernameTF.text == " " {
                let userID = Auth.auth().currentUser?.uid
                                  let profilePath = ref.child("users").child(userID!)
                               
                                 profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                           let snapValue = snapshot.value as? NSDictionary
                                  //fix google sign in problem (when they don't have an ccount)
                            
                                
                                    var username = snapValue?["Username"] as? String ?? "Unknown_User"
                           
                                    
                                    self.usernameTF.text = username
                         
                                      
                                    
           
                                       })
  
            
               
                
            } else if emailTF.text == "" || emailTF.text == " " || isemailvalid == false  {
                           let userID = Auth.auth().currentUser?.uid
                                             let profilePath = ref.child("users").child(userID!)
                                          
                                            profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                                      let snapValue = snapshot.value as? NSDictionary
                                             //fix google sign in problem (when they don't have an ccount)
                                       
                                           
                                               var email = snapValue?["Email"] as? String ?? "Unknown_User"
                                         

                                               
                                               self.emailTF.text = email
                                              
               
                                            
                                                  })
                       
                       } else {
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Username").setValue(usernameTF.text)
                           
                           
                           Auth.auth().currentUser?.updateEmail(to: self.emailTF.text!, completion: { (error) in
                               self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Email").setValue(self.emailTF.text)
                           })
                               
                
                
            }
           
                
           
       
            
            //
            let storageRef = Storage.storage().reference().child("\(Auth.auth().currentUser!.uid).png")
            
            
            if let uploadData = self.profPhoto.image!.pngData(){
                storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                  
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0){
                             storageRef.downloadURL { (url, error) in
                                
                                          if (error == nil) {
                                              if let downloadUrl = url {
                                                 let downloadString = downloadUrl.absoluteString
                                                     self.ref.child("users").child(Auth.auth().currentUser!.uid).child("PhotoURL").setValue(downloadString)

                                              }
                                          }
                             
                             }
                         }
            }
            
            
            
            
            //IS VIEWING
            
            
            
            self.usernameTF.isUserInteractionEnabled = false
            self.emailTF.isUserInteractionEnabled = false
            
             
            
        }
        
        
        
    }
   
    @objc func backup(){
        self.dismiss(animated: true, completion: nil)
        
        
        
        
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
