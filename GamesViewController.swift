//
//
//  GamesViewController.swift
//  June20Proj
//
//  Created by Rahul on 7/23/21.
//  Copyright © 2021 Rahul. All rights reserved.
//

import UIKit
import SCLAlertView
import UIKit
import FirebaseAuth
import Firebase
import LocalAuthentication

class GamesViewController: UIViewController, UIScrollViewDelegate {
     var ref: DatabaseReference! = Database.database().reference()
     let userID = Auth.auth().currentUser?.uid
    @IBOutlet weak var scrollv: UIScrollView!
    @IBOutlet weak var getStarted: UIButton!
    
    @IBOutlet weak var pgcontrol: UIPageControl!
    
    //change when adding more
  //  let images = ["Image-1", "Image-2", "Image-3", "Image-4", "Image-5"]
    
    let images = ["Image-1", "Image-522"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
       
        if segue.identifier == "pickfriend" {
            let vcer = segue.destination as? UINavigationController
            let vc = vcer?.viewControllers.first as? UsersFriendsTableViewController
         
            vc?.cameFrom = "1v1"
        }
        
        if segue.identifier == "pickfriends" {
                  let vcer = segue.destination as? UINavigationController
                  let vc = vcer?.viewControllers.first as? UsersFriendsTableViewController
               
                  vc?.cameFrom = "multi"
              }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getStarted.layer.cornerRadius = 25
        pgcontrol.numberOfPages = images.count
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named: images[i])
//            let xpos = CGFloat(i)*self.view.bounds.size.width
            let xpos = CGFloat(i)*self.view.bounds.size.width
            imageView.frame = CGRect(x: xpos, y: 0, width: scrollv.frame.size.width, height: scrollv.frame.size.height)
            scrollv.contentSize.width = view.frame.size.width*CGFloat(i+1)
            scrollv.addSubview(imageView)
            
        }
      
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x/scrollView.frame.width
        pgcontrol.currentPage = Int(page)
        if (Int(page)%2 == 0) {
            self.view.backgroundColor = UIColor(named: "default")
            self.getStarted.backgroundColor  = UIColor(named: "reverse")
        } else {
            self.view.backgroundColor = UIColor(named: "reverse")
            self.getStarted.backgroundColor  = UIColor(named: "default")
        }
    
        
        
    }
    
    @IBAction func didStartGame(_ sender: Any) {
              //run action segues instead of printing titles
        switch((scrollv.contentOffset.x/scrollv.frame.width) + 1){
        case 1:
           let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true
                                                                                                                          )
            let alertView = SCLAlertView(appearance: appearancery)
            
            alertView.addButton("Single Betting"){
                let profilePath6 = self.ref.child("users").child(self.userID!)
                                             
                                               profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                                       
                                              
                                                 if(snapshot.hasChild("games")){
                                                    let profilePath5 = self.ref.child("users").child(self.userID!).child("games")
                                                                        
                                                                          profilePath5.observeSingleEvent(of: .value, with: { (snapshot) in
                                                                                  
                                                                         
                                                                            if(snapshot.hasChild("trivia")){
                                                                                self.performSegue(withIdentifier: "cantbetrn", sender: self)
                                                                            } else {
                                                                               
                                                                                 self.performSegue(withIdentifier: "solovai", sender: self)
                                                                            }
                                                                          
                                                                           
                                                                           
                                                           
                                                                           
                                                                          
                                                                                })
                                                    
                                                 } else {
                                                    self.performSegue(withIdentifier: "solovai", sender: self)
                                                   
                                                 }
                                               
                                               
                                                     })
                
            }
            alertView.addButton("1v1") {
                //
                
                let profilePath6 = self.ref.child("users").child(self.userID!)
                                             
                                               profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                                       
                                              
                                                 if(snapshot.hasChild("games")){
                                                    let profilePath5 = self.ref.child("users").child(self.userID!).child("games")
                                                                        
                                                                          profilePath5.observeSingleEvent(of: .value, with: { (snapshot) in
                                                                                  
                                                                         
                                                                            if(snapshot.hasChild("trivia")){
                                                                                self.performSegue(withIdentifier: "cantbetrn", sender: self)
                                                                            } else {
                                                                               
                                                                                 self.performSegue(withIdentifier: "pickfriend", sender: self)
                                                                            }
                                                                          
                                                                           
                                                                           
                                                           
                                                                           
                                                                          
                                                                                })
                                                    
                                                 } else {
                                                    self.performSegue(withIdentifier: "pickfriend", sender: self)
                                                   
                                                 }
                                               
                                               
                                                     })
            }
      
           alertView.addButton("Multiplayer"){
            let profilePath6 = self.ref.child("users").child(self.userID!)
            
              profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                      
             
                if(snapshot.hasChild("games")){
                   let profilePath5 = self.ref.child("users").child(self.userID!).child("games")
                                       
                                         profilePath5.observeSingleEvent(of: .value, with: { (snapshot) in
                                                 
                                        
                                           if(snapshot.hasChild("trivia")){
                                               self.performSegue(withIdentifier: "cantbetrn", sender: self)
                                           } else {
                                              
                                                self.performSegue(withIdentifier: "pickfriends", sender: self)
                                           }
                                         
                                          
                                          
                          
                                          
                                         
                                               })
                   
                } else {
                   self.performSegue(withIdentifier: "pickfriends", sender: self)
                  
                }
              
              
                    })
                      }
           
        
           alertView.showInfo("Pick a Game Mode", subTitle: "Choose the format & number of players you'd like to play with.", closeButtonTitle: "Cancel")
         
     
      
        case 2:
            self.performSegue(withIdentifier: "letsbet", sender: self)
//        case 3:
//            self.performSegue(withIdentifier: "debate", sender: self)
//        case 4:
//            self.performSegue(withIdentifier: "invest", sender: self)
//            
//        case 5:
//            let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true                                      )
//             let alertView = SCLAlertView(appearance: appearancery)
//           alertView.showInfo("COMING SOON", subTitle: "This game mode is not available yet.", closeButtonTitle: "Ok")
//         
//    
            
        default:
            print("ERROR w/ scrollview")
        }
       
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

