


import Eureka
import Firebase
import SCLAlertView

class MakeContestViewController: FormViewController {

    
    var ref = Database.database().reference()
    var odds: Array<Float> = []
    @objc func dismisser() {
         self.performSegue(withIdentifier: "contestCreated", sender: self)
    }
    private var myButtonRow: ButtonRow! // Can also just refer to it by tag
         let kMaxCount = 4
    var numOfRows = 0
    @objc func handleDis(){

        self.dismiss(animated: true, completion: nil)
        
        
    }
   
    override func viewDidLoad() {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "contestCreated" {
                tabBarController?.tabBar.isHidden = false
                tabBarController?.selectedIndex = 2
            }
        }
         super.viewDidLoad()
        self.title = "Create a Contest"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleDis))
       

        form +++ Section("About the Contest")
       
          
            <<< TextRow(){ row in
                row.tag = "contest"
                row.title = "Contest Name"
                row.placeholder = "Enter title here"
                
               
            }
          
            
            <<< DateTimeRow(){
                $0.title = "Date/Time (EST)"
                $0.tag = "date"
                var currentDate = Date()
                var dateComponent = DateComponents()
                dateComponent.day = 2
                let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
                $0.value = futureDate
             
      
               
                
            }
       <<< TextRow(){ row in
            row.title = "Category"
            row.placeholder = "Enter category name"
        row.tag = "cats"
           
        }
         //form +++
//            MultivaluedSection(multivaluedOptions: [.Insert, .Delete],
//                                      header: "Sides (4 max)",
//                                      footer: "") {
//                       $0.addButtonProvider = { section in
//                           return ButtonRow(){
//                               $0.title = "Add New Tag"
//                           }
//                       }
//
//                       $0.multivaluedRowToInsertAt = { index in
//
//                           return NameRow() {
//                               $0.placeholder = "Tag Name"
//                           }
//                       }
//
//                       $0 <<< NameRow() {
//                           $0.placeholder = "Tag Name"
//                       }
//
//                   }
       
        form +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: "Sides", footer: "") { section in
          
            section.tag = "mySectionTag"
           
            
            section.addButtonProvider = { _ in
            
                return ButtonRow() { row in
                    
                    self.myButtonRow = row
                        row.title = "Add Side"
                     
                   
                    
                }
                
            }

            section.multivaluedRowToInsertAt = { index in
                 
                self.numOfRows = index
                if index >= self.kMaxCount - 1 {
                    
                    section.multivaluedOptions = [.Delete]
                    self.myButtonRow.hidden = true
                    

                    DispatchQueue.main.async() { // I'm not sure why this is necessary
                        self.myButtonRow.evaluateHidden()
                    }
                }
                

                return NameRow() { row in // any row type you want — although inline rows probably mess this up
                    row.tag = "sider \(index+1)"
                    row.title = "Side #\(index+1)"
                    row.placeholder = "Enter side name"
                 //   row.value = Date()
                }
            }

    
      //

    }
        form +++ Section("Odds (% that each team wins- don't include %)"){section in
           
            
            }
        
        <<< TextRow(){
            $0.tag = "side1"

                                   $0.title = "Odds for Side 1"
                                   $0.placeholder = "Enter a number from 1-10"
                                    $0.value = "5"
            
                                  
                               }
        <<< TextRow(){
                   $0.tag = "side2"

                                         $0.title = "Odds for Side 2 "
                                         $0.placeholder = "Enter a number from 1-10"
            $0.value = "5"
     
                                        
                                     }
        <<< TextRow(){
                   $0.tag = "side3"

                                         $0.title = "Odds for Side 3"
                                         $0.placeholder = "Enter a number from 1-10"
                  
                                        $0.value = "0"
                                     }
        <<< TextRow(){
                  
 $0.tag = "side4"
                                         $0.title = "Odds for Side 4 "
                                         $0.placeholder = "Enter a number from 1-10"
            $0.value = "0"
            
                                        
                                     }
        
        form +++ Section("Host")
              <<< TextRow(){ row in
                   row.tag = "hid"
                  row.title = "Host ID"
                row.value = Auth.auth().currentUser!.uid
                  row.baseCell.isUserInteractionEnabled = false
                 
              }
        <<< TextRow(){ row in
            row.tag = "hemail"
                        row.title = "Host Email"
                row.value = Auth.auth().currentUser!.email
                        row.baseCell.isUserInteractionEnabled = false
                       
                    }
        
            form +++ Section("")
        <<< ButtonRow("create") {
            
            $0.title = "Create Contest"
            $0.cell.backgroundColor = UIColor(named: "telisequa")
            $0.cell.tintColor = .white
            $0.onCellSelection { (x, y) in
                
                
                if ((self.form.rowBy(tag: "contest") as? TextRow)?.value != nil) && ((self.form.rowBy(tag: "date") as? DateTimeRow)?.value != nil) && ((self.form.rowBy(tag: "cats") as? TextRow)?.value != nil) && ((self.form.rowBy(tag: "sider 1") as? NameRow)?.value != nil) && ((self.form.rowBy(tag: "sider 2") as? NameRow)?.value != nil) && ((self.form.rowBy(tag: "side1") as? TextRow)?.value != nil) && ((self.form.rowBy(tag: "side2") as? TextRow)?.value != nil){
                    var sideCount: Int = 0
                    var oddCount: Int = 0
                    var sides: [String] = []
                    var oddstring: [String] = []
         
                    
                    
                    if ((self.form.rowBy(tag: "sider 1") as? NameRow)?.value != nil){
                        sideCount += 1
                        sides.append(((self.form.rowBy(tag: "sider 1") as? NameRow)?.value)!)
                    }
                    if ((self.form.rowBy(tag: "sider 2") as? NameRow)?.value != nil) {
                        sideCount += 1
                        sides.append(((self.form.rowBy(tag: "sider 2") as? NameRow)?.value)!)
                    }
                    if ((self.form.rowBy(tag: "sider 3") as? NameRow)?.value != nil) {
                        sideCount += 1
                        sides.append(((self.form.rowBy(tag: "sider 3") as? NameRow)?.value)!)
                    }
                    if ((self.form.rowBy(tag: "sider 4") as? NameRow)?.value != nil) {
                        sideCount += 1
                        sides.append(((self.form.rowBy(tag: "sider 4") as? NameRow)?.value)!)
                    }
                    
                    if ((self.form.rowBy(tag: "side1") as? TextRow)?.value != nil) && ((self.form.rowBy(tag: "side1") as? TextRow)?.value != "0") {
                        oddCount += 1
                        oddstring.append(((self.form.rowBy(tag: "side1") as? TextRow)?.value)!)
                        
                    }
                    if ((self.form.rowBy(tag: "side2") as? TextRow)?.value != nil) && ((self.form.rowBy(tag: "side2") as? TextRow)?.value != "0") {
                        oddCount += 1
                        oddstring.append(((self.form.rowBy(tag: "side2") as? TextRow)?.value)!)
                        
                    }
                    if ((self.form.rowBy(tag: "side3") as? TextRow)?.value != nil) && ((self.form.rowBy(tag: "side3") as? TextRow)?.value != "0") {
                        oddCount += 1
          
                        if let val = (self.form.rowBy(tag: "side3") as? TextRow)?.value {
                            oddstring.append(val)
                        
                        }
                       
                       // oddstring.append(((self.form.rowBy(tag: "side3") as? TextRow)?.value)!)
                        
                    }
                    if ((self.form.rowBy(tag: "side4") as? TextRow)?.value != nil) && ((self.form.rowBy(tag: "side4") as? TextRow)?.value != "0") {
                        oddCount += 1
                        if let val2 = (self.form.rowBy(tag: "side4") as? TextRow)?.value {
                                                   oddstring.append(val2)
                                               }
                    //    oddstring.append(((self.form.rowBy(tag: "side4") as? TextRow)?.value)!)
                        
                    }
                    
                
           
                    if oddstring.count != sides.count {
                        let alert = UIAlertController(title: "Error Matching Odds", message: "It seems like you didn't fill in an equal number of sides and odds. Make sure that you do not have any sides with odds of 0.", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                       
                            
                       }))
                      
                        self.present(alert, animated: true)
                          
                    
                         
                    } else {
                        
                        
                        
                  //  print((self.form.rowBy(tag: "contest") as? TextRow)?.value)
                        if let contest = (self.form.rowBy(tag: "contest") as? TextRow)?.value {
                            if let date = (self.form.rowBy(tag: "date") as? DateTimeRow)?.value {
                                if let category = (self.form.rowBy(tag: "cats") as? TextRow)?.value {
                                    
                                    self.odds = oddstring.map { Float($0)!}
                                    
                                    
                                
                                    let dateFormatterPrint = DateFormatter()
                                    dateFormatterPrint.dateFormat = "MMddyy"
                                    
                                    let dateFormatterPrint2 = DateFormatter()
                                       dateFormatterPrint2.dateFormat = "MM/dd/yy, h:mm a"
                                    
                                    let dateFormatterPrint3 = DateFormatter()
                                    dateFormatterPrint3.dateFormat = "M"
                                    
                                    let dateFormatterPrint4 = DateFormatter()
                                    dateFormatterPrint4.dateFormat = "d"
                                    
                                    let dateFormatterPrint5 = DateFormatter()
                                    dateFormatterPrint5.dateFormat = "yyyy"
                                    
                                    let dateFormatterPrint6 = DateFormatter()
                                    dateFormatterPrint6.dateFormat = "HH"
                                    
                                    let dateFormatterPrint7 = DateFormatter()
                                        dateFormatterPrint7.dateFormat = "mm"


          
                                    
                                        let contest_title = dateFormatterPrint.string(from: date) + contest
                                    let dater = dateFormatterPrint2.string(from: date)
                                    
                                    let month = dateFormatterPrint3.string(from: date)
                                    let day = dateFormatterPrint4.string(from: date)
                                    
                                     let yr = dateFormatterPrint5.string(from: date)
                                    
                                    let hr = dateFormatterPrint6.string(from: date)
                                    
                                            let min = dateFormatterPrint7.string(from: date)
                        
                                    
                                    //set category
                                    self.ref.child("contests").child("live").child(contest_title).child("Category").setValue(category)
                                    
                                    
                                    //name
                                    self.ref.child("contests").child("live").child(contest_title).child("Name").setValue(contest)
                                    
                                    //set date
                                    self.ref.child("contests").child("live").child(contest_title).child("Date").setValue(dater)
                                    
                                    
                                    //set host
                                    self.ref.child("contests").child("live").child(contest_title).child("host_id").setValue(Auth.auth().currentUser!.uid)
                                    
                                    //set options and their odds within them
                                    
                                    for (indexer, side) in sides.enumerated() {
                                        self.ref.child("contests").child("live").child(contest_title).child("participants").child(side).child(Auth.auth().currentUser!.uid).setValue(0)
                                        self.ref.child("contests").child("live").child(contest_title).child("Options").child(side).child("reward").setValue(self.odds[indexer])
                                        
                                        
                                    }
                                    
                                    let app = SCLAlertView.SCLAppearance(
                                                                 showCloseButton: false // if you dont want the close button use false
                                                             )
                                                        
                                                          let av = SCLAlertView(appearance: app)
                                                          av.addButton("Ok", target:self, selector:#selector(self.dismisser))
                                                          av.showSuccess("Success", subTitle: "Successfully created your contest. This may take a moment to process. ")
                                    
                                     
                                    var components = DateComponents()
                                           components.hour = Int(hr)
                                           components.minute = Int(min)
                                           components.day = Int(day)
                                           components.month = Int(month)
                                           components.year = Int(yr)
                                           
                                           let content = UNMutableNotificationContent()
                                           content.title = "Set the Results for \(contest)"
                                           content.body = "Everyone's waiting, please set the results as soon as possible."
                                           content.sound = UNNotificationSound.default
                                           let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                                       
                                           let request = UNNotificationRequest(identifier: "myRequest2", content: content, trigger: trigger)

                                           UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                                               // handle error
                                           })
                                                 
                                                          
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                      
                       
                       
                        
                        
                      
                    }
             
          
                } else {
                    let alert = UIAlertController(title: "Missing Credentials", message: "Please make sure you have filled in all of the fields and that you have at least TWO sides", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    
                }
              
                               
                
                    //self.performSegue(withIdentifier: "contestCreated", sender: self)
            }
        }
        
        
        
        
       
}
}
