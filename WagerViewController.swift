//
//  WagerViewController.swift
//  June20Proj
//
//  Created by Rahul on 7/18/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import DropDown



import NotificationBannerSwift


struct currentCell {
    static var current: String?
    static var currentd: String?
    
    
    
}



extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

class WagerViewController: UIViewController {
  
    
    var name: String = ""
    var dateDate: Int = 0
    var dateMonth: Int = 0
    var dateYear: Int = 0
    var dateHhout: Int = 0
    var dateMinute: Int = 0
    var current: Date?
    
    @IBOutlet weak var errmessage: UILabel!
    @IBAction func submitted(_ sender: UIButton) {

        var utfdate = Date()
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: utfdate)
              dateComponents.hour = dateComponents.hour! - 5
                            let date = Calendar.current.date(from: dateComponents)
                                                                                                
     
        
        if selectAteam.titleLabel?.text != "Select a Team" && date! < current! {
         
            let percentage: Float = Float(datareward[dropDown.indexForSelectedRow!]) / Float(datareward.reduce(0, +))
               
            let diffmult: Float = (1/percentage)-1
      
               print(diffmult)
            let realmult = diffmult*(slider.value*Float(self.rpoints)) + slider.value*Float(self.rpoints)
            

            print(realmult)
            
            self.ref.child("contests").child("live").child(name).child("participants").child((selectAteam.titleLabel?.text)!).child(Auth.auth().currentUser!.uid).setValue(String(Int(realmult).withCommas()))
            
            var arrayOfGue: [String] = []
            arrayOfGue.append("pending")
            arrayOfGue.append(String(Int(realmult).withCommas()))
           
       
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("current_contests").child(name).setValue(arrayOfGue)
         

            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("my_contests").child(name).setValue(Int(arrayOfGue[1]))
            
            var newpoints = Int((rpoints - Int(self.slider.value*Float(self.rpoints))))
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(newpoints)
            let banner = NotificationBanner(title: "Entered Contest", subtitle: "You have successfully wagered points on \((selectAteam.titleLabel?.text)!)", leftView: nil, rightView: nil, style: .info, colors: nil)
            
            banner.autoDismiss = false
            banner.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                banner.dismiss()
            })
            
        
         
        

           
      
            
               
        var components = DateComponents()
               components.hour = dateHhout
               components.minute = dateMinute
               components.day = dateDate
               components.month = dateMonth
               components.year = 2000 + dateYear
               
               let content = UNMutableNotificationContent()
               content.title = "Contest Pending"
               content.body = "Your contest is in progress. You should get your results soon."
               content.sound = UNNotificationSound.default
               let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
           
               let request = UNNotificationRequest(identifier: "myRequest", content: content, trigger: trigger)

               UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                   // handle error
               })
            
            self.dismiss(animated: true, completion: nil)
            
            
        } else {
            errmessage.isHidden = false
            if selectAteam.titleLabel?.text == "Select a Team" {
                errmessage.text = "Please select a Team."
            } else if (date! > current!){
                 errmessage.text = "Contest Expired. nice try..."
                
            }
            
        }
    }
    @IBOutlet weak var toWin: UILabel!
    var currentReward = 0
    var datareward: [Int] = []
      let dropDown = DropDown()
    
    @IBAction func didselectaTeam(_ sender: UIButton) {
            dropDown.show()
    }
    @IBOutlet weak var selectAteam: UIButton!
    var currentContestD = ""
    var currentContestN = ""
     var ref = Database.database().reference()
    var rpoints: Int = 0
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sliderval: UILabel!
    @IBAction func didChangeVal(_ sender: UISlider) {
        self.sliderval.text = "Bet: " + String(Int(self.slider.value*Float(self.rpoints)).withCommas())
        if dropDown.selectedItem != nil {
          
            let percentage: Float = Float(datareward[dropDown.indexForSelectedRow!]) / Float(datareward.reduce(0, +))
         
            
            //formula for converting pct to american odds
            let diffmult: Float = (1/percentage)-1
            
         
            let realmult = diffmult*(slider.value*Float(self.rpoints)) + slider.value*Float(self.rpoints)
         
            toWin.text = "To Win: " + String(Int(realmult).withCommas())
        
        }
        
      //  self.toWin.text = "To Win " + String(winnings)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        errmessage.isHidden = true
        
        toWin.text = "Select a Team"
                

                                // The view to which the drop down will appear on
                                //dropDown.anchorView = self.view
                               // dropDown.center = CGPoint(x: self.view.frame.size.width / 2, y: 1000 )
        //
                                // The list of items to display. Can be changed dynamically
                                dropDown.dataSource = []
                         // Action triggered on selection
        var xView = UIView(frame: CGRect(x: 100, y: 800, width: self.view.frame.size.width, height: self.view.frame.size.height))
     
        dropDown.anchorView = xView
        
                         dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                            self.selectAteam.setTitle(item, for: .normal)
                            self.currentReward = self.datareward[index]
      
                            var percentage: Float = Float(self.datareward[self.dropDown.indexForSelectedRow!]) / Float(self.datareward.reduce(0, +))
                
                            let diffmult: Float = (1/percentage)-1
           
                            var realmult = diffmult*(self.slider.value*Float(self.rpoints)) + self.slider.value*Float(self.rpoints)
                
                         
                                     
                                     
                                    
                                   
                                    
                                    
                            self.toWin.text = "To Win: " + String(Int(realmult).withCommas())
                                   
                                   
                           
                          
                         }
        dropDown.direction = .any
                                DropDown.appearance().textColor = UIColor.white
                                DropDown.appearance().selectedTextColor = UIColor.white
                                DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
                                DropDown.appearance().backgroundColor = UIColor(named: "telisequa")
                                DropDown.appearance().selectionBackgroundColor = UIColor(named: "pink")!
                                DropDown.appearance().cellHeight = 60
                                dropDown.width = self.view.frame.size.width - 80
                                
                                
       
      //  sliderval.text = String(slider.value*Float(rpoints))
        // Do any additional setup after loading the view.
       
               let userID = Auth.auth().currentUser?.uid
               let profilePath = ref.child("users").child(userID!)
            
              profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                        let snapValue = snapshot.value as? NSDictionary
               //fix google sign in problem (when they don't have an ccount)
              
              
           
                var points = snapValue?["points"] as? Int
             
                self.rpoints = points!
             
                self.sliderval.text = "Bet: " + String(Int(self.slider.value*Float(self.rpoints)).withCommas())
              
            

               
              
                    })
        
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
          var currentdate = dateFormatterPrint23.date(from: currentCell.currentd!)
        
      
          
          name = dateFormatterPrint3.string(from: currentdate!) + currentCell.current!
        
        dateDate = Int(dateFormatterPrintDate.string(from: currentdate!))!
        
        dateMonth = Int(dateFormatterPrintMonth.string(from: currentdate!))!
        
        dateYear = Int(dateFormatterPrintYear.string(from: currentdate!))!
        
        dateHhout = Int(dateFormatterPrintHour.string(from: currentdate!))!
        
        dateMinute = Int(dateFormatterPrintMinute.string(from: currentdate!))!
     
        current = currentdate
        
         
        
        let contestPath = ref.child("contests").child("live").child(name)
                 
                   contestPath.observeSingleEvent(of: .value, with: { (snapshot) in
                             let snapValue = snapshot.value as? NSDictionary
                    //fix google sign in problem (when they don't have an ccount)
                   
                    
                  
                    
                
                     var cats = snapValue?["Category"] as? String
               
                    var ops2 = snapValue?["Options"]
                    
                    var contdict = ops2.unsafelyUnwrapped as! NSDictionary
                    
                    for pair in contdict {
                   
                        var curval = pair.value as! NSDictionary
                        self.dropDown.dataSource.append(pair.key as! String)
                        self.datareward.append(curval["reward"]! as! Int)
                     
                        
              
                         

                  
                    }
                  //  print(contdict.count)
                  
                   

                 
                   
                    
                   
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
