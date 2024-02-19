//
//  InvestViewController.swift
//  June20Proj
//
//  Created by Rahul on 3/17/22.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SCLAlertView

struct currentDebate {
    static var name: String = ""
}
class DebateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var array: [String] = []
    var arrOfnames: [String] = []
    var arrOfprices: [Int] = []
    var ref: DatabaseReference! = Database.database().reference()
    var database = Database.database()
    let userID = Auth.auth().currentUser?.uid

    @IBOutlet weak var tblview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentDebate.name = arrOfnames[indexPath.row]
        let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true)
        let alertView = SCLAlertView(appearance: appearancery)
        let profilePath0 = ref.child("games").child("debates").child(currentDebate.name)
                  
                  profilePath0.observeSingleEvent(of: .value, with: { (snapshot) in
                      
                      
                
                      let snapValue = snapshot.value as? NSDictionary
                      //fix google sign in problem (when they don't have an ccount)
                      
                      
                      for (key, val) in snapValue!{
                 
                        alertView.addButton(String(describing: key)){
                            self.ref.child("games").child("debates").child(currentDebate.name).child(String(describing: key)).setValue((val as! Int) + 1)
                            self.ref.child("users").child(self.userID!).child("debates").child(currentDebate.name).setValue(key)
                            self.performSegue(withIdentifier: "doned", sender: self)
                                
                        }
                        
                        
                      }
                    alertView.showInfo("Choose a Side", subTitle: "Win \(currentDebate.name.components(separatedBy: "-").last!) cc if you pick the winning side.", closeButtonTitle: "Cancel")
              

                    
                  })
        
                                          
                                          
  

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "temp")
        cell.textLabel?.text = array[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func china(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tblview.dataSource = self
        tblview.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(china))
        
        // Do any additional setup after loading the view.
        var doNotAdd: [String] = []
        let profilePatherie = ref.child("users").child(Auth.auth().currentUser!.uid).child("debates")
                   
                   profilePatherie.observeSingleEvent(of: .value, with: { (snapshot) in
                       
                       
                 
                       let snapValue = snapshot.value as? NSDictionary
                    if snapValue != nil {
                        
                    for (key, value) in snapValue!{
                        
                        doNotAdd.append(String(describing: key))
                    }
                       //fix google sign in problem (when they don't have an ccount)
                    }
                    
                   
                    let profilePath0 = self.ref.child("games").child("debates")
                               
                               profilePath0.observeSingleEvent(of: .value, with: { (snapshot) in
                                   
                                   
                             
                                   let snapValue = snapshot.value as? NSDictionary
                                   //fix google sign in problem (when they don't have an ccount)
                                   
                                   
                                   for (key, val) in snapValue!{
                                       self.arrOfnames.append(key as! String)
                       
                                       var word = ""
                                       word += String(describing: key)
                                    if word.contains("End") || doNotAdd.contains(word){
                                       } else {
                                       self.array.append(word)
                                       }
                                   }
                                   self.tblview.reloadData()
                                   
                              
                                 
                                 
                                 
                                 
                           
                          
                                 
                               })
                       
              
                     
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
