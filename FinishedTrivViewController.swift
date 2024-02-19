//
//  FinishedTrivViewController.swift
//  June20Proj
//
//  Created by Rahul on 8/7/21.
//  Copyright © 2021 Rahul. All rights reserved.
//
import NotificationBannerSwift
import UIKit
import FirebaseAuth
import Firebase
import LocalAuthentication

class FinishedTrivViewController: UIViewController {
    @IBAction func sharebut(_ sender: Any) {
        let bounds = UIScreen.main.bounds
           UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
           let img = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    //finish
     var ref: DatabaseReference! = Database.database().reference()
    var correct: Int = 0
     let userID = Auth.auth().currentUser?.uid
    @IBOutlet weak var winn: UILabel!
    var winningser: Int = 0
    var wagereder: Int = 0
    var roundser: Int = 0
    var modery: String = ""
    var creds2: [String] = []
    @IBOutlet weak var wagered: UILabel!
    
    @IBOutlet weak var netProfit: UILabel!
    @IBOutlet weak var rounds: UILabel!

    @IBAction func didFinishMatch(_ sender: Any) {
      
    }
    @IBOutlet weak var didFinish: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        ref.child("users").child((Auth.auth().currentUser?.uid)!).child("games").child("trivia").child("current").removeValue()
        ref.child("users").child((Auth.auth().currentUser?.uid)!).child("games").child("trivia").child("current").removeValue()

//        wagered.text = "Total Wagered: " + String(wagereder)
//        winn.text = "Total Won: " + String(winningser)
//        rounds.text = "Total Rounds: " + String(roundser)
//        netProfit.text = "Net Profit: " + String(winningser - wagereder)
        
    
        winn.text = "Total Correct: " + String(winningser/2)
        
        wagered.text = "Total Rounds: " + String(roundser)
        netProfit.text =  "               "
        rounds.text = "               "
        
        
 
        if (winningser - wagereder > 0){
            netProfit.textColor = UIColor.systemGreen
        } else {
            netProfit.textColor = UIColor(named: "incorrect_red")
        }
        let profilePath6 = ref.child("users").child(userID!)
                                     
                                       profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                                let snapValue = snapshot.value as? NSDictionary
                                        var points = snapValue?["points"] as? Int
                                        var usr = snapValue?["Username"] as? String
                                        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("points").setValue(points!+self.winningser - self.wagereder)
                                        
                                        if self.modery != "mult" {
                                              var randomid: String = "trivia-" + NSUUID().uuidString
                                            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("past_games").child(randomid).child("wagered").setValue(self.wagereder)
                                            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("past_games").child(randomid).child("won").setValue(self.winningser)
                                            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("past_games").child(randomid).child("rounds").setValue(self.roundser)
                                              } else {
//                                            self.netProfit.isHidden = true
//                                            self.winn.isHidden = true
   //                                         self.wagered.text = "Total Correct: " + String(self.correct)
                                            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("pending").child(self.creds2[0]).removeValue()
                                            self.ref.child("games").child("trivia").child(self.creds2[1]).child("stats").child(self.userID!).setValue(self.correct)
                                            self.ref.child("games").child("trivia").child(self.creds2[1]).child("unconfirmed").child(usr!).removeValue()
                                            self.gameOverCheck(gameID: self.creds2[1])
                                              }
                                       
                                             })
    }
    public func gameOverCheck(gameID: String){
        
       
        let profilePath6 =  self.ref.child("games").child("trivia").child(gameID)
        profilePath6.observeSingleEvent(of: .value, with: { [self] (snapshot) in
                                                      let snapValue = snapshot.value as? NSDictionary
                            
                                                                                
                                                                                   
                                                                                  
                                                if snapshot.hasChild("unconfirmed"){
                                                    
                                                } else {
                                                    //everyone gone
                                                    self.ref.child("games").child("trivia").child(gameID).child("status").setValue("complete")
                                                    
                                             
                                                    var stats = snapValue?["stats"] as? [String:Int]
                                                    var highscore: Int = -1
                                                    for (user, correct) in stats! {
                                                        if correct > highscore {
                                                            highscore = correct
                                                        }
                                                       // self.ref.child("users").child(user).child("update").child("mult-triv-")
                                                    }
                                                    //add winners
                                                    var winners: [String] = []
                                                    var singleSum = 0
                                                    for (user2, correct2) in stats! {
                                                        if (correct2 == highscore){
                                                            singleSum += 1
                                                            let profilePathery =  self.ref.child("users").child(user2)
                                                            //1112
                                                            let profilePath = ref.child("users").child(user2)
                                                         
                                                         profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                                                                              let snapValue2 = snapshot.value as? NSDictionary
                                                                                     //fix google sign in problem (when they don't have an ccount)
                                                                            
                                                                                         
                                                                                      var allfriends = snapValue2?["Username"] as? String ?? "Anonymous"
                                                         
                                                                                    winners.append(allfriends)
                                                                                    self.ref.child("games").child("trivia").child(self.creds2[1]).child("winners").setValue(winners)
                                                             var sum = snapValue?["winnings"] as? Int
                                                             singleSum = sum!/singleSum
                                                             
                                                             var loss = snapValue?["wagers"] as? Int
                                                              var rds = snapValue?["totalRounds"] as? Int
                                                             var wins = singleSum-loss!
                                                             var disc: String = String(rds!) + "-round multiplayer trivia; Winners = " + winners.joined(separator: ", ")
                                                             for (usery, correcty) in stats! {
                                                                 if correcty == highscore {
                                                                     self.ref.child("users").child(usery).child("update").child(disc).setValue(wins)
                                                                 } else {
                                                                     self.ref.child("users").child(usery).child("update").child(disc).setValue(-1*loss!)
                                                                 }
                                                                
                                                             }
                                                             
                                                                                    
                                                                                          })
                                                            //1112
                                                          //  winners.append(user2)
                                                                                                                        
                                                            
                                                            
                                                        }
                                                }
                                                    
                                                 
                                                                                        
                                                                                         
                                                }
                              
                                             
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
