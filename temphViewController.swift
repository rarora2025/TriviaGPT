//
//  temphViewController.swift
//  June20Proj
//
//  Created by Rahul on 6/19/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

//add a notification request at #notif
//show winners for trivia mult- 

import UIKit
import FirebaseAuth
import Firebase
import SCLAlertView
import NVActivityIndicatorView
import StoreKit


                      extension UIImage {
                          func resized(to size: CGSize) -> UIImage {
                              return UIGraphicsImageRenderer(size: size).image { _ in
                                  draw(in: CGRect(origin: .zero, size: size))
                              }
                          }
                        
                      }
extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 50
        self.clipsToBounds = true
    }
}

class temphViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var points: UILabel!
    

    @IBOutlet weak var serr: UIImageView!
    @IBOutlet weak var donationpoints: UILabel!
    
    
    var arr: [String] = []
    
    @IBOutlet weak var acc: NVActivityIndicatorView!
    @IBOutlet weak var friendsbutton: UIButton!
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var settingsicon: UIImageView!
    override func viewDidAppear(_ animated: Bool) {
        
        
     
       

    }
    @IBOutlet weak var aboutbutton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var acindicator: UIActivityIndicatorView!

    
    @IBOutlet weak var profpic: UIImageView!
    @IBOutlet weak var profPhoto: UIImageView!
    var ref: DatabaseReference! = Database.database().reference()
    var database = Database.database()

    let transition = CircularTransition()
    
    @IBOutlet weak var donatebutton: UIButton!
    
    @IBAction func ratenow(_ sender: Any) {
        if #available(iOS 10.3, *) {
               SKStoreReviewController.requestReview()

           } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "6478117752") {
               if #available(iOS 10, *) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)

               } else {
                   UIApplication.shared.openURL(url)
               }
           }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resumeTriv" {
            //1-29-24
                let vc = segue.destination as? SoloAI2ViewController
                vc?.creds = arr
                
               
             
            }
       
        if segue.identifier != "passet" && segue.identifier != "hometofriend" && segue.identifier != "resumeTriv" && segue.identifier != "showgamereq" && segue.identifier != "don" && segue.identifier != "rules"  && segue.identifier != "hist"   {
            let secondVC = segue.destination as! MenuViewController
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
            
        } else {
         
        }
            
            
        
        
    }
   

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = profPhoto.center
        transition.circleColor = UIColor(named: "default")!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = profPhoto.center
        transition.circleColor = UIColor(named: "default")!
        return transition
    }

    
        
    override func viewDidLoad() {
        
       

        super.viewDidLoad()
        friendsbutton.layer.cornerRadius = 18
        self.acc.isHidden = false
       
        
        acc.type = .ballRotateChase
     //    self.acindicator.startAnimating()
        self.acc.startAnimating()
        menuButton.layer.cornerRadius = 18
        aboutbutton.layer.cornerRadius = 18
         donatebutton.layer.cornerRadius = 18
        friendsbutton.isHidden = true
        settingsicon.isHidden = true
        menuButton.isHidden = true
        aboutbutton.isHidden = true
        donatebutton.isHidden = true
        
        var animals: [String] = ["Aardvark",
               "Albatross",
               "Alligator",
               "Alpaca",
               "Ant",
               "Anteater",
               "Antelope",
               "Ape",
               "Armadillo",
               "Donkey",
               "Baboon",
               "Badger",
               "Barracuda",
               "Bat",
               "Bear",
               "Beaver",
               "Bee",
               "Bison",
               "Boar",
               "Buffalo",
               "Butterfly",
               "Camel",
               "Capybara",
               "Caribou",
               "Cassowary",
               "Cat",
               "Caterpillar",
               "Cattle",
               "Chamois",
               "Cheetah",
               "Chicken",
               "Chimpanzee",
               "Chinchilla",
               "Chough",
               "Clam",
               "Cobra",
               "Cockroach",
               "Cod",
               "Cormorant",
               "Coyote",
               "Crab",
               "Crane",
               "Crocodile",
               "Crow",
               "Curlew",
               "Deer",
               "Dinosaur",
               "Dog",
               "Dogfish",
               "Dolphin",
               "Dotterel",
               "Dove",
               "Dragonfly",
               "Duck",
               "Dugong",
               "Dunlin",
               "Eagle",
               "Echidna",
               "Eel",
               "Eland",
               "Elephant",
               "Elk",
               "Emu",
               "Falcon",
               "Ferret",
               "Finch",
               "Fish",
               "Flamingo",
               "Fly",
               "Fox",
               "Frog",
               "Gaur",
               "Gazelle",
               "Gerbil",
               "Giraffe",
               "Gnat",
               "Gnu",
               "Goat",
               "Goldfinch",
               "Goldfish",
               "Goose",
               "Gorilla",
               "Goshawk",
               "Grasshopper",
               "Grouse",
               "Guanaco",
               "Gull",
               "Hamster",
               "Hare",
               "Hawk",
               "Hedgehog",
               "Heron",
               "Herring",
               "Hippopotamus",
               "Hornet",
               "Horse",
               "Human",
               "Hummingbird",
               "Hyena",
               "Ibex",
               "Ibis",
               "Jackal",
               "Jaguar",
               "Jay",
               "Jellyfish",
               "Kangaroo",
               "Kingfisher",
               "Koala",
               "Kookabura",
               "Kouprey",
               "Kudu",
               "Lapwing",
               "Lark",
               "Lemur",
               "Leopard",
               "Lion",
               "Llama",
               "Lobster",
               "Locust",
               "Loris",
               "Louse",
               "Lyrebird",
               "Magpie",
               "Mallard",
               "Manatee",
               "Mandrill",
               "Mantis",
               "Marten",
               "Meerkat",
               "Mink",
               "Mole",
               "Mongoose",
               "Monkey",
               "Moose",
               "Mosquito",
               "Mouse",
               "Mule",
               "Narwhal",
               "Newt",
               "Nightingale",
               "Octopus",
               "Okapi",
               "Opossum",
               "Oryx",
               "Ostrich",
               "Otter",
               "Owl",
               "Oyster",
               "Panther",
               "Parrot",
               "Partridge",
               "Peafowl",
               "Pelican",
               "Penguin",
               "Pheasant",
               "Pig",
               "Pigeon",
               "Pony",
               "Porcupine",
               "Porpoise",
               "Quail",
               "Quelea",
               "Quetzal",
               "Rabbit",
               "Raccoon",
               "Rail",
               "Ram",
               "Rat",
               "Raven",
               "Red deer",
               "Red panda",
               "Reindeer",
               "Rhinoceros",
               "Rook",
               "Salamander",
               "Salmon",
               "Sand Dollar",
               "Sandpiper",
               "Sardine",
               "Scorpion",
               "Seahorse",
               "Seal",
               "Shark",
               "Sheep",
               "Shrew",
               "Skunk",
               "Snail",
               "Snake",
               "Sparrow",
               "Spider",
               "Spoonbill",
               "Squid",
               "Squirrel",
               "Starling",
               "Stingray",
               "Stinkbug",
               "Stork",
               "Swallow",
               "Swan",
               "Tapir",
               "Tarsier",
               "Termite",
               "Tiger",
               "Toad",
               "Trout",
               "Turkey",
               "Turtle",
               "Viper",
               "Vulture",
               "Wallaby",
               "Walrus",
               "Wasp",
               "Weasel",
               "Whale",
               "Wildcat",
               "Wolf",
               "Wolverine",
               "Wombat",
               "Woodcock",
               "Woodpecker",
               "Worm",
               "Wren",
               "Yak",
               "Zebra"]
               
               let adjs: [String] = [
               "Adorable",

               "Delightful",

               "Homely",

               "Quaint",

               "Adventurous",

               "Depressed",

               "Horrible",

               "Aggressive",

               "Determined",

              "Hungry",

               "Real",

               "Agreeable",

               "Different",

               "Hurt",

               "Relieved",

               "Alert",

               "Difficult",

               "Repulsive",

               "Alive",

              "Disgusted",

               "Ill",

               "Rich",

               "Amused",

               "Distinct",

               "Important",

               "Angry",

               "Disturbed",

               "Impossible",

               "Scary",

               "Annoyed",

               
               "Dizzy",

               "Inexpensive",

               "Selfish",

               "Annoying",

               "Doubtful",

               "Innocent",

               "Shiny",

               "Anxious",

               "Drab",

               "Inquisitive",

               "Shy",

               "Arrogant",

               "Dull",

               "Itchy",

              
               "Silly",

               "Ashamed",


              "Sleepy",

               "Attractive",

               "Eager",

               "Jealous",

               "Smiling",

               "Average",

               "Easy",

               "Jittery",

               "Smoggy",

               "Awful",

               "Elated",

               "Jolly",

               "Sore",

               "Joyous",

              "Sparkling",

               "Bad",

               "Embarrassed",

           
               "Splendid",

               "Beautiful",

               "Enchanting",

               "Kind",

               "Spotless",

               "Better",

               "Encouraging",


               "Stormy",

               "Bewildered",

               "Energetic",

              
               "Successful",

               "Blue",

               "Evil",

               "Lonely",

               
               "Super",

               "Blue-eyed",

               "Excited",



               "Blushing",

               "Expensive",

               "Lovely",

               "Talented",

               "Bored",

               "Exuberant",

               
               "Lucky",

               "Tame",

               "Brainy",

               "Tender",

               "Brave",

               "Fair",

               "Magnificent",

               "Tense",

               "Breakable",

               "Faithful",

               "Misty",

               "Terrible",

               "Bright",

               "Famous",

               "Modern",


               "Mushy",

               "Thoughtless",

               "Careful",

              "Filthy",

               "Mysterious",

               "Tired",

             
               "Frantic",

               "Nice",

               "Ugly",

               "Clever",

               "Friendly",

               "Uninterested",

               "Cloudy",

               "Frightened",


               "Obnoxious",

               "Upset",

               "Combative",

               "Gentle",

               "Odd",
               "Uptight",

               "Comfortable",

               "Gifted",

               "Old-fashioned",

             
               "Good",


              "Courageous",

               "Gorgeous",

               "Panicky",

               "Wandering",

               "Crazy",

               
               "Graceful",

               "Perfect",

               "Weary",

               
               "Zany",

               "Defeated",

               "Hilarious",

               "Puzzled",

               "Zealous"
               ]
               var randomnum = String(Int.random(in: 0...99))
               var randomusernamewspaces = adjs.randomElement()! + animals.randomElement()! + randomnum
               let randomusername = String(randomusernamewspaces.filter { !" \n\t\r".contains($0) })
        
        serr.isHidden = true
        points.isHidden = true
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        let profilePath = ref.child("users").child(userID!)
     
       profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                 let snapValue = snapshot.value as? NSDictionary
        //fix google sign in problem (when they don't have an ccount)
       
       
            
            var usernameString = snapValue?["Username"] as? String ?? randomusername
            var mailString = snapValue?["Email"] as? String ?? ""
            var passString = snapValue?["Password"] as? String ?? ""
        
      
        
        var urlString = snapValue?["PhotoURL"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/june20proj.appspot.com/o/KvYdgOcJcRPIN3NKw3NBum3KKBw2.png?alt=media&token=1d6309a0-b13f-4f2d-aea5-3d0716fcc453"//provide a default URL
        
         var points = snapValue?["points"] as? Int
        if snapshot.hasChild("update") {
              var updateRN = snapValue?["update"] as? [String:Int]
                  for (key, val) in updateRN! {
                      let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true
                      )
                      let alertView = SCLAlertView(appearance: appearancery)
                 
                      
                    points = points! + val
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(points)
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("update").child(key).removeValue()
                    alertView.showSuccess("Ended: \(key.components(separatedBy: ";")[0])", subTitle: "\(key.components(separatedBy: ";")[1])", closeButtonTitle: "Ok")
                      
                  }
                  //-round multiplayer trivia; Winners =
              }
  
        if snapshot.hasChild("debates") {
                   print("gotten debate")
                            var updateRN = snapValue?["debates"] as? [String:String]
                                for (key, val) in updateRN! {
                                 
                                   let profilePath = self.ref.child("games").child("debates")
                                   profilePath.observeSingleEvent(of: .value, with: { (snapshotter) in
                                    let snapValue = snapshotter.value as? NSDictionary
                                    if snapshotter.hasChild(key){
                                        print("found your debate")
                                    
                                   
                                    } else {
                                     print("handle debate")
                                        print("End" + key)
                                        let profilePath = self.ref.child("games").child("debates").child("End" + key)
                                                                        profilePath.observeSingleEvent(of: .value, with: { (snapshottery) in
                                                                         let snapper = snapshottery.value as? NSDictionary
                                                                       
                                                                            if (snapper?["Winner"] as? String)! == val {
                                                                                
                                                                                points = points! + Int((key.components(separatedBy: "-").last!))!
                                                                                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(points)
                                                                                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("debates").child(key).removeValue()
                                                                                let appearancery = SCLAlertView.SCLAppearance(showCloseButton: false
                                                                                                     )
                                                                             let alertView = SCLAlertView(appearance: appearancery)
                                                                               
                                                                                alertView.addButton("Claim") {
                                                                                    self.points.text = String(points!.withCommas())
                                                                                }
                                                                                alertView.showSuccess("You won \(key.components(separatedBy: "-").last!) cc from the debate: \(key)", subTitle: "The winning side was \(val)")
                                                                           
                                                                                
                                                                                
                                                                                
                                                                                
                                                                            } else {
                                                                                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("debates").child(key).removeValue()
                                                                                   let appearancery = SCLAlertView.SCLAppearance(showCloseButton: false
                                                                                                        )
                                                                                let alertView = SCLAlertView(appearance: appearancery)
                                                                                  
                                                                                   alertView.addButton("Ok") {
                                                                                     
                                                                                   }
                                                                                    alertView.showSuccess("You were on the losing side of: \(key)", subTitle: "The winning side was \(val)")
                                                                                
                                                                            }
                                                                        
                                                                            
                                                                            
                                                                            
                                                                           
                                                                        })
                                        
                                        
                                    }
                                       
                                       
                                      
                                   })
                                   
                                    
                                    
                                }
                                //-round multiplayer trivia; Winners =
                            }
        if snapshot.hasChild("investments") {
              print("gotten investment")
                       var updateRN = snapValue?["investments"] as? [String:Int]
                           for (key, val) in updateRN! {
                              
                              let profilePath = self.ref.child("games").child("investments").child(key)
                              profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                  let costs = snapshot.value as? Int
                                  if costs! > 1000 {
                                      //investment finished
                                       points = points! + val * (costs!-1000)
                                      self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(points)
                                      self.ref.child("users").child(Auth.auth().currentUser!.uid).child("investments").child(key).removeValue()
                                      self.points.text = String(points!.withCommas())
                                      
                                  } else {
                                      points = points! + val * costs!
                                      self.points.text = String(points!.withCommas())
                                  }
                                  
                                  
                                 
                              })
                              
                            
                               
                           }
                           //-round multiplayer trivia; Winners =
                       }
        var do_points = snapValue?["donation_points"] as? Int
    

                   let url = URL(string: urlString)
                   let data = try? Data(contentsOf: url!)
                    let ogImage = UIImage(data: data!)
            let resizedImage = ogImage!.resized(to: CGSize(width: 100, height: 100))
   
        self.points.text = String(points!.withCommas())
      //  self.donationpoints.text = String(do_points!.withCommas())
        if urlString == "https://firebasestorage.googleapis.com/v0/b/june20proj.appspot.com/o/KvYdgOcJcRPIN3NKw3NBum3KKBw2.png?alt=media&token=1d6309a0-b13f-4f2d-aea5-3d0716fcc453" {
                 self.ref.child("users").child(Auth.auth().currentUser!.uid).child("PhotoURL").setValue("https://firebasestorage.googleapis.com/v0/b/june20proj.appspot.com/o/KvYdgOcJcRPIN3NKw3NBum3KKBw2.png?alt=media&token=1d6309a0-b13f-4f2d-aea5-3d0716fcc453")
                
            }
            self.profPhoto.makeRounded()
                   self.profPhoto.image = resizedImage
      //  self.profName.text = usernameString

        self.acc.stopAnimating()
        self.friendsbutton.isHidden = false
        self.menuButton.isHidden = false
           self.aboutbutton.isHidden = false
        self.settingsicon.isHidden = false
        self.donatebutton.isHidden = false
        UIView.animate(withDuration: 8.0) {
            self.settingsicon.alpha = 0
   
           }

        
        if passString == " " {
            self.performSegue(withIdentifier: "passet", sender: self)
            
            //self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Password").setValue(password)
        }
        
      
                           //to access users info
            
        
        

        



         
        
        
       
             })
     
       let profilePath6 = ref.child("users").child(userID!)
                              
                                profilePath6.observeSingleEvent(of: .value, with: { (snapshot) in
                                        
                               
                                  if(snapshot.hasChild("games")){
                                    let profilePath5 = self.ref.child("users").child(userID!).child("games")
                                                         
                                                           profilePath5.observeSingleEvent(of: .value, with: { (snapshot) in
                                                                   
                                                          //add credentials to array (gameid) pass on creds from hom epage so finished doesnt break...
                                                             if(snapshot.hasChild("trivia")){
                                                                 let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true
                                                                                                                                                                                          )
                                                                            let alertView = SCLAlertView(appearance: appearancery)
                                                                            
                                                                            alertView.addButton("Sure"){
                                                                                self.performSegue(withIdentifier: "resumeTriv", sender: self)
                                                                            }
                                                                           
                                                                           
                                                                           alertView.showInfo("Trivia Game in Progress", subTitle: "You started a trivia game earlier, would you like to finish it?", closeButtonTitle: "I'll pass")
                                                             } else {
                                                                 
                                                             }
                                                           
                                                            
                                                            
                                            
                                                            
                                                           
                                                                 })
                                     
                                  } else if (snapshot.hasChild("pending")) {
                                    //#notif
                                     let appearancery = SCLAlertView.SCLAppearance(showCloseButton: true)
                                     let alertView = SCLAlertView(appearance: appearancery)
                                     
                                     alertView.addButton("View"){
                                         self.performSegue(withIdentifier: "showgamereq", sender: self)
                                     }
                                    
                                    
                                    alertView.showInfo("Pending Game Requests", subTitle: "Somebody sent you a game request.", closeButtonTitle: "Not now")
                                  }
                                
                                
                                      })
        
     
        
      
        let profilePath2 = ref.child("users").child(userID!).child("current_contests")
              
              profilePath2.observeSingleEvent(of: .value, with: { (snapshot) in
                  
                  
            
                  let snapValue = snapshot.value as? NSDictionary
                  //fix google sign in problem (when they don't have an ccount)
                  
                  
                  let y = snapshot.children.allObjects as? [DataSnapshot]
                
                var users_contests: [[String]: String] = [:]
                
                for (index, x) in y!.enumerated() {
                
            
               
                    let z = x.children.allObjects as? [DataSnapshot]
                    //result
                        
                    var name: String = y![index].key
                  
                   
                
                  
                    users_contests[[name, z![1].value as! String]] = z![0].value as! String
                    //wager
                  
                    

                    


                }
                
                
          print(users_contests)
                var resultsArray: [String] = Array(users_contests.values)
                print(resultsArray)
                
                 var nameArray: [[String]] = Array(users_contests.keys) // for Dictionary
                        print(nameArray)
                if resultsArray.count > 0 {
                  
                for x in 0...resultsArray.count - 1 {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                      print("x is ")
                       print(x)
                    if resultsArray[x] == "W" {
                        
                      
                        let appearancery = SCLAlertView.SCLAppearance(
                            showCloseButton: false
                        )
                        let alertView = SCLAlertView(appearance: appearancery)
                        
                        alertView.addButton("Claim") {
                            
                            alertView.dismiss(animated: true)
                            
                            var newPts = Int(self.points.text!)! + Int(nameArray[x][1])!
                            
                            self.points.text = String(newPts)
                            
                            //add to firebase, remove xontest from firebase
                            
                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(newPts)
                            
                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("current_contests").child(nameArray[x][0]).removeValue()
                            
                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("my_contests").child(nameArray[x][0]).setValue(Int(nameArray[x][1]))
                                                                            
                              
                            
                         
                            
                           
                        }
                        
                        alertView.showSuccess("Winner!", subTitle: "You won \(nameArray[x][1]) points in \(nameArray[x][0])")
                        
                        
                        
                    } else if resultsArray[x] == "L"{
                       let appearancery = SCLAlertView.SCLAppearance(
                                                  showCloseButton: false
                                              )
                                              let alertView = SCLAlertView(appearance: appearancery)
                                              
                                              alertView.addButton("Continue") {
                                                  
                                                  alertView.dismiss(animated: true)
                                                  
                                            
                                                  self.ref.child("users").child(Auth.auth().currentUser!.uid).child("current_contests").child(nameArray[x][0]).removeValue()
                                                
                                                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("my_contests").child(nameArray[x][0]).setValue(Int(nameArray[x][1])! * -1)
                                                  
                                               
                                                                                                  
                                                    
                                                  
                                               
                                                  
                                                 
                                              }
                                              
                                              alertView.showError("Loser!", subTitle: "You lost a pontential \(nameArray[x][1]) points in \(nameArray[x][0])")
                                              
                                              
                                              
                        
                    }
                    }
                }
                }
                
              })
        let profilePath0 = ref.child("users").child(userID!).child("current_parlay_contests")
            
            profilePath0.observeSingleEvent(of: .value, with: { (snapshot) in
                
                
          
                let snapValue = snapshot.value as? NSDictionary
                //fix google sign in problem (when they don't have an ccount)
                
                
                let y = snapshot.children.allObjects as? [DataSnapshot]
              
           
              
                for x in y!{
                    var status = "true"
                    var total = (x.children.allObjects as? [DataSnapshot])!.count
                    var index = 0
                    var stake = 0
                    for z in (x.children.allObjects as? [DataSnapshot])!{
                        if index < total-1 {
                        if String(describing: z.value!) == "false" {
                            status = "fail"
                            break
                        }
                        if String(describing: z.value!) == "pending" {
                            status = "pending"
                        }
                        } else if index == total-1 {
                            stake = Int(String(describing: z.value!))!
                        }
                        index = index + 1
                    }
                    if status == "true"{
                      //  print("ADD \(stake) in \(x.key)")
                        let appearancery = SCLAlertView.SCLAppearance(
                                                   showCloseButton: false
                                               )
                                               let alertView = SCLAlertView(appearance: appearancery)
                                               
                                               alertView.addButton("Claim") {
                                                   
                                                   alertView.dismiss(animated: true)
                                                   
                                                var newPts = Int(self.points.text!)! + Int(stake)
                                                   
                                                   self.points.text = String(newPts)
                                                   
                                                   //add to firebase, remove xontest from firebase
                                                   
                                                   self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(newPts)
                                                   
                                                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("current_parlay_contests").child(x.key).removeValue()
                                                   
                                                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("my_contests").child(x.key).setValue(stake)
            
                                                
                                               }
                                               
                        alertView.showSuccess("Winner!", subTitle: "You won \(stake) points in the parlay: id = \(x.key)")
                       
                        
                    } else if status == "fail" {
                        print("notify loss of \(stake) in \(x.key)")
                        
                        let appearancery = SCLAlertView.SCLAppearance(showCloseButton: false)
                                                                  let alertView = SCLAlertView(appearance: appearancery)
                                                                  
                                                                  alertView.addButton("Continue") {
                                                                      
                                                                      alertView.dismiss(animated: true)
                                                                      
                                                                
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("current_parlay_contests").child(x.key).removeValue()
                                                                    
                                        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("my_contests").child(x.key).setValue(stake * -1)
                                                           
                                                                  }
                                                                  
                        alertView.showError("Loser!", subTitle: "You lost a pontential \(stake) points in the parlay: id = \(x.key)")
                                                                  
                    }
                    
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
