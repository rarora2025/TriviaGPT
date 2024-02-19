//
//  FriendsTableViewController.swift
//  June20Proj
//
//  Created by Rahul on 7/7/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import NotificationBannerSwift
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse?, data: Data?, error: Error?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData as Data)
                }
            }
        }
    }
}
    


class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
         let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
         let image = UIImage(data: imageData!)
         return image!
     }
    
    var indicator = UIActivityIndicatorView()

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
    }
    
    var Notsearching: Bool = true
    var filteredUsers = [AUser]()
    var doneFilteringData: Bool = false
    var totalDone = 0
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         if searchBar.text != "" {
             searchBar.endEditing(true)
             
         }
         
         
     }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
           if searchBar.text == "" {
               searchBar.placeholder = "Enter Username or Email"
               return true
           } else {
               
               return true
               
           }
       }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchBar.endEditing(true)
          searchBar.searchTextField.text = ""
          Notsearching = true
          tableView.reloadData()
      }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
           filteredUsers = []

           
           if searchText == "" {
               Notsearching = true
               filteredUsers = Users
              
           } else {
               Notsearching = false
               
               for user in Users {
              
                if user.username!.lowercased().contains(searchText.lowercased()) || user.email!.lowercased().contains(searchText.lowercased())
                                 {
                                   filteredUsers.append(user)
                                 //  filteredaddpeople[name] = address
            
                                  }
                                 }
                       }
               

          
           self.tableView.reloadData()
       }
    
    @IBOutlet weak var searchBar: UISearchBar!
    var ref = Database.database().reference()
    var doneFetchingData: Bool = false
    func someMethodIWantToCall(cell: UITableViewCell){
        
        
        
        var friendsArray: [String] = []
        friendsArray.append(cell.textLabel!.text!)
        friendsArray.append(cell.detailTextLabel!.text!)
       
    
        //friendsArray.append(imageString)
     
        
        
        
        let userID = Auth.auth().currentUser?.uid
          let profilePath = ref.child("users").child(userID!)
          profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                          let snapValue = snapshot.value as? NSDictionary
                 //fix google sign in problem (when they don't have an ccount)
        
           
              var FriendsArr = snapValue?["Friends"] as? [[String]] ?? []
            if FriendsArr.contains(friendsArray) {
                        let alert2 = UIAlertController(title: "Existing Friend", message: "You cannot friend \(friendsArray[0]) because you are already friends", preferredStyle: .alert)
          alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          self.present(alert2, animated: true)
              
            } else {
                let alert = UIAlertController(title: "Friend \(friendsArray[0])?", message: "Are you sure you would like to friend \(friendsArray[0])", preferredStyle: .alert)
                //this is where u put name
                
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    
            
            FriendsArr.append(friendsArray)
              
                 
                    
                    DispatchQueue.main.async {
                                                                                                                self.tableView.reloadData()
                                                                                                            }
                    
                    
                    
                    let banner = NotificationBanner(title: "New Friend", subtitle: "Sucessfully Friended \(friendsArray[0])", leftView: nil, rightView: nil, style: .success, colors: nil)
                    banner.autoDismiss = false
                      DispatchQueue.main.async {
                    banner.show()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        banner.dismiss()
                       
                        
                    })
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Friends").setValue(FriendsArr)
                    self.handleFriends()
                 }))
                
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
               
                
            }
                
                      })
            
        
        
       
        
     //   imagedata.image = UIImage(data:cell.imageView!.image!.pngData()!,scale:1.0)
    //    var indexPathTapped = tableView.indexPath(for: cell)
     //  print(indexPathTapped)
        

        
    }
    

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
        
    }
     

    var cellId = "cellID"
    var Users = [AUser]()
   
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
      //  tableView.reloadData()
        
        searchBar.delegate = self
        
        self.title = "Add a Friend"
        
        indicator.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleFriends))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Friends", style: .plain, target: self, action: #selector(handleFriends))
        Database.database().reference().child("users").observe(.value, with: { (snapshoter) in
          
            self.totalDone = Int(snapshoter.childrenCount)
            self.fetchUser()
             }, withCancel: nil)
            
      
    }
    
    @objc func handleFriends(){
        self.dismiss(animated: true, completion: nil)
        
    }
    func fetchUser(){
        
        
   
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
        
         //   self.totalDone = snapshot.value
        //    print(snapshot.value)
            print()
            if let dictionary = snapshot.value as? [String: AnyObject] {
            //    self.totalDone = dictionary.count
                var theuser = AUser()
                theuser.username = dictionary["Username"] as? String
                theuser.email = dictionary["Email"] as? String
                theuser.photo = dictionary["PhotoURL"] as? String
                theuser.points = snapshot.key
               
                
                
                
   
       
           
                
                if (Auth.auth().currentUser?.email != theuser.email) {
                   
                                        self.Users.append(theuser)
                               
                               
                }
                print("users")
               print(self.Users.count)
                
                print("done")
                print(self.totalDone)
                
                
                if (self.Users.count == self.totalDone - 1) {
              
                    self.doneFetchingData = true
                                     DispatchQueue.main.async {
                                                           self.tableView.reloadData()
                                                       }
                                                       
                    
        
                    
                }
                
                
                
                                                        
                            
                            
                            
                     
                            
                         
                
//
          
               
             
            }
//
//
            
         
        }, withCancel: nil)
      
        
           
      
        
         
        
 
    }
    
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (doneFilteringData){
            
            if(Notsearching){
            var x: FriendsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! FriendsTableViewCell
            
            x.link = self
            
                   let us = Users[indexPath.row]
            
            x.textLabel?.text = us.username
            x.detailTextLabel?.text = "\(us.points!)"
               
               
                //fix size
                //fixfiltered
                
                
                
//            let url = URL(string: us.photo!)
//            let data = try? Data(contentsOf: url!)
//            print(data)
            
       
            //        cell.textLabel?.text = user.username
            //         cell.detailTextLabel?.text = user.email
            //
            //
            //         let url = URL(string: user.photo!)
            //         let data = try? Data(contentsOf: url!)
            //         let ogImage = UIImage(data: data!)
            //
            //         let resizedImage = ogImage!.resized(to: CGSize(width: 50, height: 50))
            //
            //         cell.imageView?.layer.cornerRadius = 24
            //
            //         cell.imageView?.clipsToBounds = true
            //         cell.imageView?.image = resizedImage
            //             indicator.stopAnimating()
            //                      indicator.hidesWhenStopped = true
            return x
            } else {
                     var y: FriendsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! FriendsTableViewCell
                            
                            y.link = self
             
                let us = filteredUsers[indexPath.row]
                            
                            y.textLabel?.text = us.username
                            y.detailTextLabel?.text = "\(us.points!)"
                //            let url = URL(string: us.photo!)
                //            let data = try? Data(contentsOf: url!)
                //            print(data)
                            
                       
                            //        cell.textLabel?.text = user.username
                            //         cell.detailTextLabel?.text = user.email
                            //
                            //
                            //         let url = URL(string: user.photo!)
                            //         let data = try? Data(contentsOf: url!)
                            //         let ogImage = UIImage(data: data!)
                            //
                            //         let resizedImage = ogImage!.resized(to: CGSize(width: 50, height: 50))
                            //
                            //         cell.imageView?.layer.cornerRadius = 24
                            //
                            //         cell.imageView?.clipsToBounds = true
                            //         cell.imageView?.image = resizedImage
                            //             indicator.stopAnimating()
                            //                      indicator.hidesWhenStopped = true
                            return y
                
                
            }
        } else {
        return self.tableView.dequeueReusableCell(withIdentifier: cellId) as! FriendsTableViewCell
        }
    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

         if(!doneFetchingData){
            print("holding off rn at rows")
            return 0
         } else {
            
            if (doneFilteringData){
                if(!Notsearching){
                    return filteredUsers.count
                } else {
                return Users.count
                }
                    
            } else {
        if Notsearching {
              print("sending \(Users.count)- should be all")
            let userID = Auth.auth().currentUser?.uid
                             let profilePath = self.ref.child("users").child(userID!)
                                   profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                                   let snapValue = snapshot.value as? NSDictionary
                                          //fix google sign in problem (when they don't have an ccount)



                                              let mailString = snapValue?["Email"] as? String ?? ""


                                       for (index, user) in self.Users.enumerated() {

                                         if (user.email == mailString) {

                                            print("removing myself " + user.username!)
                                               self.Users.remove(at: index)
                                        
                                         

                                           }




                                       }
                                    
                                      

                                    self.doneFilteringData = true
                                    DispatchQueue.main.async {
                                                                                              self.tableView.reloadData()
                                                                                          }
                                                                                          
                                               })
           
          
                   

 return 0
               } else {
             print("sending \(filteredUsers.count)")
                   return filteredUsers.count


               }
        }
        }
    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//          print("holding off right now")
//
//        if(doneFetchingData){
//
//
//
//
//
//
//   var cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! FriendsTableViewCell
//       print("should be right")
//        print(Users.count)
//        cell.link = self
//
//        if Notsearching{
//
//        let user = Users[indexPath.row]
//            print("crashed at \(indexPath.row)")
//             print(tableView.numberOfRows(inSection: 0))
//        cell.textLabel?.text = user.username
//         cell.detailTextLabel?.text = user.email
//
//
//         let url = URL(string: user.photo!)
//         let data = try? Data(contentsOf: url!)
//         let ogImage = UIImage(data: data!)
//
//         let resizedImage = ogImage!.resized(to: CGSize(width: 50, height: 50))
//
//         cell.imageView?.layer.cornerRadius = 24
//
//         cell.imageView?.clipsToBounds = true
//         cell.imageView?.image = resizedImage
//             indicator.stopAnimating()
//                      indicator.hidesWhenStopped = true
//
//        } else {
//            let user = filteredUsers[indexPath.row]
//            cell.textLabel?.text = user.username
//             cell.detailTextLabel?.text = user.email
//
//
//             let url = URL(string: user.photo!)
//             let data = try? Data(contentsOf: url!)
//             let ogImage = UIImage(data: data!)
//
//             let resizedImage = ogImage!.resized(to: CGSize(width: 50, height: 50))
//
//             cell.imageView?.layer.cornerRadius = 24
//
//             cell.imageView?.clipsToBounds = true
//             cell.imageView?.image = resizedImage
//            indicator.stopAnimating()
//            indicator.hidesWhenStopped = true
//
//        }
//
//
//
//        return cell
//        } else {
//               return self.tableView.dequeueReusableCell(withIdentifier: cellId) as! FriendsTableViewCell
//        }
//    }
    
    

}
struct AUser {
    var username: String?
    var email: String?
    var photo: String?
    var points: String?
    
    
    
}
