//
//  TopicViewController.swift
//  TriviaGPT
//
//  Created by Rahul on 2/17/24.
//  Copyright © 2024 Rahul. All rights reserved.
//

import UIKit
import ChatGPTSwift
import NVActivityIndicatorView
import FirebaseAuth
import Firebase
struct quizzz {
    static var questions: TriviaAPI? = nil

    
    
    
}

struct curmode {
    static var mode: String = "Solo"

    
    
    
}
class TopicViewController: UIViewController {
    let userID = Auth.auth().currentUser?.uid

var ref: DatabaseReference! = Database.database().reference()
    @IBOutlet weak var modeselector: UISegmentedControl!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var acc: NVActivityIndicatorView!
    
    @IBAction func modechanged(_ sender: Any) {
        if modeselector.titleForSegment(at: modeselector.selectedSegmentIndex) == "1v1" {
            modeselector.selectedSegmentIndex = 0
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
            
        } else if modeselector.titleForSegment(at: modeselector.selectedSegmentIndex) == "Multiplayer" {
            modeselector.selectedSegmentIndex = 0
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
    }
    @IBOutlet weak var playbtn: UIButton!
    @IBOutlet weak var topic: UILabel!
    @objc func handleFriends(){
        self.dismiss(animated: true, completion: nil)
    }
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

    @IBAction func didplay(_ sender: Any) {
        //handle button clicked
        let profilePath6 = ref.child("users").child(userID!)
                                
                                  profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                           let snapValue = snapshot.value as? NSDictionary
                               
                                    
                                   
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("type").setValue("bet")
                                           
                           
                                   
                                               
                                              
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("wagered").setValue(0)
                                            
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("potWinnings").setValue(5)
                                            
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("Topic").setValue(self.topic.text)
                                        
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("totalRounds").setValue(5)
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("roundsFinished").setValue(0)
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("totalWinnings").setValue(0)
                                            
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("wagerPerRound").setValue(1)
                                            
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("games").child("trivia").child("current").child("winningsPerRound").setValue(1)
                                        
                                        self.performSegue(withIdentifier: "getToQu", sender: self)
                                    
                                  
                                        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.acc.isHidden = false
        playbtn.layer.cornerRadius = 25
//        playbtn.isHidden = true
//        img.isHidden = true
        self.acc.stopAnimating()
        
        
       // acc.type = .lineScale
     //    self.acindicator.startAnimating()
       // self.acc.startAnimating()
        topic.text = curtop.topic.components(separatedBy:  "---")[0]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleFriends))
        
        Task {
            do {
                //change to num
                var message = "Write me 5 multiple choice questions about " + curtop.topic + """
                 . Each question should have 3 incorrect answers and one correct answers and NO special characters. Make sure the question doesn't exceed 15 words. Make sure no answer choice exceeds 7 words. Output your response EXACTLY in this json format, and escape all quotes within the questions:
                                                          {
                                                              "response_code": 0,
                                                              "results": [
                                                                  {
                                                                      "category": "Biennial Budget Process",
                                                                      "type": "multiple",
                                                                      "difficulty": "easy",
                                                                      "question": "In 2023, the CT General Assembly passed the budget for which biennium period?",
                                                                      "correct_answer": "July 1, 2023, to June 30, 2025",
                                                                      "incorrect_answers": ["July 1, 2022, to June 30, 2024", "January 1, 2023, to December 31, 2024", "January 1, 2024, to December 31, 2025"]
                                                                  },
                                                                                                  {
                                                                                                      "category": "Biennial Budget Process",
                                                                                                      "type": "multiple",
                                                                                                      "difficulty": "easy",
                                                                                                      "question": "In 2023, the CT General Assembly passed the budget for which biennium period?",
                                                                                                      "correct_answer": "July 1, 2023, to June 30, 2025",
                                                                                                      "incorrect_answers": ["July 1, 2022, to June 30, 2024", "January 1, 2023, to December 31, 2024", "January 1, 2024, to December 31, 2025"]
                                                                                                  }
                                                                  
                                                              ]
                                                          }

                """
                let api = ChatGPTAPI(apiKey: "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")
                var response2 = try await api.sendMessage(text: message, model: "gpt-3.5-turbo", systemText: "You're a trivia game show host", temperature: 0.9)
                
                print("CHAT GPT:")
                /*
                 Desired Result:
                 {"response_code":0,"results":[{"category":"Sports","type":"multiple","difficulty":"medium","question":"Which team did Tom Brady play for before joining the Tampa Bay Buccaneers in 2020?","correct_answer":"New England Patriots","incorrect_answers":["Kansas City Chiefs","San Francisco 49ers","Denver Broncos"]}]}
                 */
                
                //debugging going on here:
                print("STUFF")
                print(response2)
                print("STUFF")
                print(message)
                print("DONEE")
                var result2:TriviaAPI?
                do{
                    result2 = try JSONDecoder().decode(TriviaAPI.self, from: response2.data(using: .utf8)!)
                } catch {
                    print("failed to fetch trivia data from https://opentdb.com/api.php?amount=5")
                    print(error.localizedDescription)
                }

                guard let json2 = result2 else {
                    return
                }
                
                
                quizzz.questions = json2
                
               
                DispatchQueue.main.async {
//                    self.img.isHidden = false
//                    self.playbtn.isHidden = false
                    //show button here
                    
                    
                }
//
                
            } catch {
                print(error.localizedDescription)
            }
        }

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
