//
//  PortfolioViewController.swift
//  June20Proj
//
//  Created by Rahul on 8/12/21.
//  Copyright © 2021 Rahul. All rights reserved.
//

  //check if not multiplayer where I wrote ->  //check if not multiplayer ; sry im in NIAGRA so cant check for that rn
import UIKit
import FirebaseAuth
import Firebase
import LocalAuthentication
import NVActivityIndicatorView

class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  { //UITableViewDelegate, UITableViewDataSource
    var ref: DatabaseReference! = Database.database().reference()
    var source: [String:String] = [:]
    var arr: [String] = []
       let userID = Auth.auth().currentUser?.uid
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = table.dequeueReusableCell(withIdentifier: "china")!
        var keyfir: [String] = Array(source.keys)
         var keysir: [String] = Array(source.values)
        cell.textLabel?.text = String(keyfir[indexPath.row])
        cell.detailTextLabel?.text = String(keysir[indexPath.row])
        cell.detailTextLabel?.isHidden = true
     
        
        return cell
    }
    

    @IBOutlet weak var ac: NVActivityIndicatorView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    public func updateCurr(ID: String, rounds: Int, game: String){
                                                        self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("wagered").setValue(0)
        
                                                            self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("potWinnings").setValue(0)
        
                                                        self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("totalRounds").setValue(rounds)
                                                            self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("roundsFinished").setValue(0)
                                                            self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("totalWinnings").setValue(0)
        
                                                        self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("wagerPerRound").setValue(2)
        
                                                        self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("winningsPerRound").setValue(0)
                                                        self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("correct").setValue(0)
                                                        self.ref.child("users").child(ID).child("games").child("trivia").child("current").child("gameID").setValue(game)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let profilePath6 = self.ref.child("users").child(self.userID!)
                                                 
                                                   profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                                           
                                                  
                                                     if(snapshot.hasChild("games")){
                                                        let profilePath5 = self.ref.child("users").child(self.userID!).child("games")
                                                                            
                                                                              profilePath5.observeSingleEvent(of: .value, with: { (snapshot) in
                                                                                      
                                                                             
                                                                                if(snapshot.hasChild("trivia")){
                                                                                    print("SHENHENNY")
                                                                                    var keyssir: [String] = Array(self.source.values)
                                                                                     var keysssir: [String] = Array(self.source.keys)
                                                                                    curtop.topic = String(keysssir[indexPath.row]).components(separatedBy: "-----")[1]
                                                                                    self.performSegue(withIdentifier: "cantbetter", sender: self)
                                                                                } else {
                                                                                      //check if not multiplayer
                                                                                    var keyssir: [String] = Array(self.source.values)
                                                                                     var keysssir: [String] = Array(self.source.keys)
                                     
                                                                                    print("SHENHEN")
                                                                                    print(String(keysssir[indexPath.row]).components(separatedBy: "-----")[1])
                                                                                    let fullNameArr = String(keysssir[indexPath.row]).components(separatedBy: "-")[0]
                                                                                    curtop.topic = String(keysssir[indexPath.row]).components(separatedBy: "-----")[1]
                                                                                    self.arr.append(keysssir[indexPath.row])
                                                                                    self.arr.append(keyssir[indexPath.row])
                                                                                    
                                                                                    self.updateCurr(ID: self.userID!, rounds: Int(fullNameArr)!, game: String(keyssir[indexPath.row]))
                                                                                      self.performSegue(withIdentifier: "startGm", sender: self)
                                                                                }
                                                                              
                                                                               
                                                                               
                                                               
                                                                               
                                                                              
                                                                                    })
                                                        
                                                     } else {
                                                    //check if not multiplayer
                                                        
                                                                                                                                           var keyssir: [String] = Array(self.source.values)
                                                                                                                                            var keysssir: [String] = Array(self.source.keys)
                                                                                                                   
                                                                                                                                           
                                                                                                                                           let fullNameArr = String(keysssir[indexPath.row]).components(separatedBy: "-")[0]
                                                         print("SHENHENQ")
                                                         print(keysssir)
                                                         curtop.topic = String(keysssir[indexPath.row]).components(separatedBy: "-----")[1]
                                                                                                                                           
                                                                                                                                   
                                                                                                                                           self.arr.append(keysssir[indexPath.row])
                                                                                                                                                                                                                            self.arr.append(keyssir[indexPath.row])
                                                                                                                                           self.updateCurr(ID: self.userID!, rounds: Int(fullNameArr)!, game: String(keyssir[indexPath.row]))
                                                        self.performSegue(withIdentifier: "startGm", sender: self)
                                                       
                                                     }
                                                    
                                                   
                                                   
                                                         })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "startGm" {
              //1-29-24
 
                  let vc = segue.destination as? SoloAI2ViewController
            
                  vc?.creds = arr
                  
                 
               
              }
    }
    override func viewDidLoad() {
        ac.isHidden = false
        ac.type = .lineScalePulseOutRapid
        ac.color = UIColor(named: "default")!
        ac.startAnimating()
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
print()
       
        let profilePath6 = self.ref.child("users").child(self.userID!)
                                              
                                                profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                                          let snapValue = snapshot.value as? NSDictionary
                                               
                                                    if(snapshot.hasChild("pending")){
                                                //        let profilePath6 = self.ref.child("users").child(self.userID!).child()
                                                        var alreadyHas: [[String:String]] = [[:]]

                                                        guard var pendin = snapValue!["pending"] as? [String:String] else {
                                                       
                                                            return
                                                        }
                                                        self.source = pendin
                                                        self.table.reloadData()
                                                        self.ac.stopAnimating()
                                                        self.ac.isHidden = true
                                                        print(pendin)
                                                    }
                                                   
                                                
                                                
                                                      })
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
