//
//  NSViewController.swift
//  June20Proj
//
//  Created by Rahul on 6/17/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NSViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var upload: UIButton!
    @IBOutlet weak var captionLbl: UILabel!
    
    @IBOutlet weak var acindicator: UIActivityIndicatorView!
    
    @IBOutlet weak var but: UIButton!
    @IBOutlet weak var errmes: UILabel!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameFld.resignFirstResponder()
    }
    @IBOutlet weak var profPic: UIButton!
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image_data = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        let imageData:Data = image_data!.pngData()!
        let imageStr = imageData.base64EncodedString()
        self.dismiss(animated: true, completion: nil)
    }
    
    var ref: DatabaseReference! = Database.database().reference()
    
    @IBOutlet weak var generateRandomUser: UIButton!
    @IBOutlet weak var usernameFld: UITextField!
    
    override func viewDidLoad() {
        var components = DateComponents()
               components.hour = 0
        components.weekday = 1
        components.calendar = Calendar.current
           
               
               let content = UNMutableNotificationContent()
               content.title = "Chat is waiting for you..."
               content.body = "It's time for another round of TriviaGPT"
               content.sound = UNNotificationSound.default
               let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
           
               let request = UNNotificationRequest(identifier: "myRequest", content: content, trigger: trigger)

               UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                   // handle error
               })
   
         
        
        super.viewDidLoad()
        errmes.isHidden = true
         acindicator.isHidden = true
        captionLbl.isHidden = true
        //self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue()
        // Do any additional setup after loading the view.
        
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
            usernameFld.text = randomusername
    }
    @IBAction func generateRandomUsername(_ sender: UIButton) {
    
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
        usernameFld.text = randomusername
    }
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
        myPickerController.allowsEditing = true
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
       
     
    }
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
           // check if an image was selected,
        acindicator.isHidden = false
        acindicator.startAnimating()
        but.isHidden = true
        upload.isHidden = true
          captionLbl.isHidden = false
        captionLbl.text = "Uploading Photo..."
           // since a images are not the only media type that can be selected
        
           if let img = info[.editedImage] as? UIImage{
                profPic.setImage(img, for: .normal)
//            let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
//            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("PhotoURL").setValue(imageURL.absoluteString)
        
            
            let storageRef = Storage.storage().reference().child("\(Auth.auth().currentUser!.uid).png")
            
            
            if let uploadData = self.profPic.imageView!.image!.pngData(){
                storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                  
                }
                       
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.0){
                    storageRef.downloadURL { (url, error) in
                       
                
               
                    
                                 if (error == nil) {
                                     if let downloadUrl = url {
                                        // Make you download string
                                         
                                        
                                        
                                        let downloadString = downloadUrl.absoluteString
                                        if downloadString != nil {
                                             print("test")
                                            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("PhotoURL").setValue(downloadString)
                                            self.acindicator.isHidden = true
                                            self.but.isHidden = false
                                            self.acindicator.stopAnimating()
                                            self.captionLbl.isHidden = true
                                        } else {
                                           // self.ref.child("users").child(Auth.auth().currentUser!.uid).child("PhotoURL").setValue()
                                        }
                                        
                                     }
                                 } else {
                                // Do something if error
                                 }
                    
                    }
                }
               
                  
                   
                
                
            } else {
                
            }
            
            

            
            
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        if usernameFld.text != "" {
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("Username").setValue(usernameFld.text)
              let dateFormatterPrint3 = DateFormatter()
               dateFormatterPrint3.dateFormat = "MMddyy"
                 
                 let dateFormatterPrintDate = DateFormatter()
                      dateFormatterPrintDate.dateFormat = "dd"
                 
                 let dateFormatterPrintMonth = DateFormatter()
                      dateFormatterPrintMonth.dateFormat = "MM"
                 
                 let dateFormatterPrintYear = DateFormatter()
                           dateFormatterPrintYear.dateFormat = "YY"
                 
                 let dateFormatterPrintHour = DateFormatter()
                                  dateFormatterPrintHour.dateFormat = "HH"
                 
                 let dateFormatterPrintMinute = DateFormatter()
                                       dateFormatterPrintMinute.dateFormat = "mm"
              
                  
            
                   let dateFormatterPrint23 = DateFormatter()
                   dateFormatterPrint23.dateFormat = "MM/dd/yy, h:mm a"
                   var currentdate = Date()
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("my_contests").child("loading").setValue(404)
                       
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(100)
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("donation_points").setValue(0)
            
        
            
       
           
            
        } else {
            errmes.isHidden = false
            errmes.text = "Please enter a username."
        }
        
        
        

      
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
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
