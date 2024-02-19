//
//  UsersFriendsTableViewController.swift
//  June20Proj
//
//  Created by Rahul on 7/8/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import Firebase

class UsersFriendsTableViewController: UITableViewController {
    var cameFrom: String = ""
    var selected: String = ""
    var selID: String = ""
    var multPeopleSel: [String:String] = [:]
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfriend"
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            friends.remove(at: indexPath.row)
     
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Friends").setValue(friends)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
    
    var friends: [[String]] = []
    var ref = Database.database().reference()
    @objc func handleBack(){
        //
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleDone(){
       
        if(multPeopleSel.count == 0){
            self.dismiss(animated: false, completion: nil)
        } else {
            
            self.performSegue(withIdentifier: "setupmult1v1", sender: self) //setupmult1v1
 
        }
       
    }
    
    
    @objc func handlefriend() {
        self.performSegue(withIdentifier: "addfriend", sender: self)
    }
    
    @objc func warntofriend() {
         let alert = UIAlertController(title: "Privacy Concerns", message: "In order to protect yourself, it is recommended to only friend people you know. To unfriend, swipe left. Your friends list is kept anonymous", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
      
        self.present(alert, animated: true)
          
      }
 
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if (cameFrom == "multi"){
            multPeopleSel.removeValue(forKey: self.friends[indexPath.row][0])
            
          
       }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(cameFrom == "1v1"){
            selected = self.friends[indexPath.row][0]
              
                selID = self.friends[indexPath.row][1]
            self.performSegue(withIdentifier: "setup1v1", sender: self)

            
      
     
        } else if (cameFrom == "multi"){
            multPeopleSel[self.friends[indexPath.row][0]] =  self.friends[indexPath.row][1]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

        if segue.identifier == "setup1v1"  {
    
            let vc = segue.destination as? SoloAIViewController
            var peeps:[String:String] = [:]
            peeps[selected] = selID
            vc?.multOppsIfAny = peeps
            //vc?.opIfAny = selected
            //vc?.opIfAnyID = selID
       
            
        } else if (segue.identifier == "setupmult1v1") {
            let vc = segue.destination as? SoloAIViewController
            vc?.multOppsIfAny = multPeopleSel
        }
    }
    
    
    override func viewDidLoad() {
        
        let topInset = 10
        tableView.contentInset.top = CGFloat(topInset)
        
        super.viewDidLoad()
    
        if(cameFrom == "1v1") {
            self.tableView.allowsSelection = true
            self.navigationItem.rightBarButtonItems = nil
             self.navigationItem.leftBarButtonItems = nil
            self.navigationItem.title = "Select Player to 1v1"
        
        } else if(cameFrom == "multi"){
            self.tableView.allowsMultipleSelection = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
                    self.navigationItem.leftBarButtonItems = nil
                   self.navigationItem.title = "Select Players"
            
            
        } else {
               
        self.title = "My Friends"
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handlefriend)), UIBarButtonItem(image: UIImage(systemName: "lock.shield"), style: .plain, target: self, action: #selector(warntofriend))]
        }
        
        let userID = Auth.auth().currentUser?.uid
           let profilePath = ref.child("users").child(userID!)
        profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                             let snapValue = snapshot.value as? NSDictionary
                                    //fix google sign in problem (when they don't have an ccount)
                           
                                        
                                     var allfriends = snapValue?["Friends"] as? [[String]] ?? [["", ""]]
                                    for friend in allfriends {
                                        
                                        var farray: [String] = []
                                        farray.append(friend[0])
                                         farray.append(friend[1])
                                 
                                        
                                       
                                        self.friends.append(farray)
                                    
                                        
                                        
                
                                        }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
            
                                       
                                        
                                
                                 
                                 

                                   
                                         })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        if friends.count > 0 {
            return friends.count
        } else {
            return 0
        }
        
      
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (friends[0][1] != "") && (friends[0][0] != "") {
            
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "celler")
        let fuser = friends[indexPath.row]
        cell?.textLabel?.text = fuser[0]
        cell?.detailTextLabel?.text = fuser[1]
            cell?.selectionStyle = .gray
            cell?.detailTextLabel?.isHidden = true
//
//            let friendsimage = self.convertBase64StringToImage(imageBase64String: fuser[2])
//        let resizedImage = friendsimage.resized(to: CGSize(width: 50, height: 50))
//
//        cell?.imageView?.layer.cornerRadius = 25
//
//        cell?.imageView?.clipsToBounds = true
//        cell?.imageView?.image = resizedImage
        
     
      
        return cell!
        
        } else {
            let alert = UIAlertController(title: "No Friends", message: "You don't have any friends yet. Would you like to add some?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.performSegue(withIdentifier: "addfriend", sender: self)
            }))
            self.present(alert, animated: true)
            
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "celler")
            cell?.textLabel?.text = ""
            cell?.detailTextLabel?.text = ""
            return cell!
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }

}

