//
//  ParlayViewController.swift
//  June20Proj
//
//  Created by Rahul Arora on 1/5/22.
//  Copyright © 2022 Rahul. All rights reserved.
//

//TODO: confirm u cant bet when in parlay after expired, add to firebase, title to button
import DropDown
import UIKit
import Firebase
import FirebaseAuth
import NotificationBannerSwift

struct parlays {
    static var pars: [String:String]?

    
    
    
}
class ParlayViewController: UIViewController {
    var oddsmult: Float = 1.0
    var dateDate: Int = 0
    var dateMonth: Int = 0
    var dateYear: Int = 0
    var dateHhout: Int = 0
    var dateMinute: Int = 0
    var realdub: Int = 1
     var names: [String] = []
    var dateries: [Date] = []
    @IBOutlet weak var errormessage: UILabel!
    @IBOutlet weak var didsubmit: UIButton!
      var realpoints: Int = 0
    @IBAction func submitparlay(_ sender: Any) {
        print(names)
        print(dateries)
        var lcdxceeds: Bool = false
        var utfdate = Date()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: utfdate)
      dateComponents.hour = dateComponents.hour! - 5
              let daterie = Calendar.current.date(from: dateComponents)
        for date in dateries {
            if daterie! > date {
             
                lcdxceeds = true
            }
        }
        
        if !lcdxceeds {
            var titler: String = ""
            
            for namerie in names {
                titler += namerie
            }
            for (indexer, par) in names.enumerated() {
                self.ref.child("contests").child("live").child(par).child("participants").child((arrayOfButtons[indexer].titleLabel?.text)!).child(Auth.auth().currentUser!.uid).setValue("P" + titler)
                
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("current_parlay_contests").child(titler).child(par).setValue("pending")
             
              
                
            }
            self.ref.child("users").child(Auth.auth().currentUser!.uid).child("current_parlay_contests").child(titler).child("stake").setValue(String(realdub.withCommas()))
            
            
            var newpoints = Int((realpoints - Int(self.slidiner.value*Float(self.realpoints))))
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("points").setValue(newpoints)
            let banner = NotificationBanner(title: "Entered Contest", subtitle: "You have successfully wagered points on a \(String(parlays.pars!.count))-team parlay", leftView: nil, rightView: nil, style: .info, colors: nil)
            parlays.pars = nil
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
                              content.title = "Parlay Pending"
                              content.body = "Your parlay is in progress. You should get your results soon."
                              content.sound = UNNotificationSound.default
                              let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            
                                //might cause an error bc myrequest isnt unique
                              let request = UNNotificationRequest(identifier: "myRequest", content: content, trigger: trigger)
            
                              UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                                  // handle error
                              })
            
                           self.dismiss(animated: true, completion: nil)
            
        } else {
                errormessage.isHidden = false
                         
                 errormessage.text = "Contest Expired. nice try..."
            
                           
            
        }


    }
    @IBOutlet weak var slidiner: UISlider!
    @IBOutlet weak var bett: UILabel!
    @IBOutlet weak var winner: UILabel!
    @IBAction func didchangeval(_ sender: Any) {
        calculateCurrentOdds()
    }
    func calculateCurrentOdds(){
        var allsel: Bool = true
               for booleanval in arrayOfButtons{
                   if booleanval.isHidden == false && booleanval.titleLabel?.text == "Select a Team" {
                       allsel = false
                   }
               }
               var curods: [Float] = []
               if allsel {
                didsubmit.isEnabled = true
                 errormessage.text = ""
                   for (index, parss) in parlays.pars!.enumerated() {
                       let percentage: Float = Float(arrayOfReward[index][arrayOfDropDown[index].indexForSelectedRow!]) / Float(arrayOfReward[index].reduce(0, +))
                       var diffmult: Float = (1/percentage)-1
                       if diffmult < 1 {
                           
                           //making them favored
                           diffmult = 1/diffmult
                           diffmult *= -1
                           
                       }
                       diffmult*=100
                       
                       
                       //formula for calculting mulltipliers on site where i was learning multipliers of calculating parlays
                       if diffmult < 0 {
                           diffmult *= -1
                           diffmult += 100
                           diffmult /= (diffmult - 100)
                       } else {
                           diffmult += 100
                           diffmult /= 100
                       }
                       
                       curods.append(diffmult)
                   }
                   
                   var fullodds: Float = 1
                   for odd in curods {
                       fullodds *= odd
                   }
                   oddsmult = fullodds
     
                realdub = Int(oddsmult*(self.slidiner.value*Float(self.realpoints)))
                bett.text = "Bet: " + String(Int(self.slidiner.value*Float(self.realpoints)))
                winner.text = "To Win: " + String(realdub)
                
                   
               } else {
                //handle not finished
                oddsmult = 0
                 didsubmit.isEnabled = false
                errormessage.text = "Please Select for all Contests"
                
        }
    }
    @IBAction func check(_ sender: Any) {
       
        
    }
    
    @IBAction func sc1(_ sender: Any) {
        dropDown1.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc2(_ sender: Any) {
        dropDown2.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc3(_ sender: Any) {
        dropDown3.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc4(_ sender: Any) {
        dropDown4.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc5(_ sender: Any) {
        dropDown5.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc6(_ sender: Any) {
        dropDown6.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc7(_ sender: Any) {
        dropDown7.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc8(_ sender: Any) {
        dropDown8.show()
         self.calculateCurrentOdds()
    }
    @IBAction func sc9(_ sender: Any) {
        dropDown9.show()
         self.calculateCurrentOdds()
    }
    @IBOutlet weak var select1: UIButton!
    @IBOutlet weak var select2: UIButton!
    @IBOutlet weak var select3: UIButton!
    @IBOutlet weak var select4: UIButton!
    @IBOutlet weak var select5: UIButton!
    @IBOutlet weak var select6: UIButton!
    @IBOutlet weak var select7: UIButton!
    @IBOutlet weak var select8: UIButton!
    @IBOutlet weak var select9: UIButton!
    var arrayOfButtons: [UIButton] = []
    var arrayOfDropDown: [DropDown] = []
    var arrayOfReward: [[Int]] = []
    var ref = Database.database().reference()
    var datareward1: [Int] = []
    let dropDown1 = DropDown()
    var datareward2: [Int] = []
    let dropDown2 = DropDown()
    var datareward3: [Int] = []
    let dropDown3 = DropDown()
    var datareward4: [Int] = []
    let dropDown4 = DropDown()
    var datareward5: [Int] = []
    let dropDown5 = DropDown()
    var datareward6: [Int] = []
    let dropDown6 = DropDown()
    var datareward7: [Int] = []
    let dropDown7 = DropDown()
    var datareward8: [Int] = []
    let dropDown8 = DropDown()
    var datareward9: [Int] = []
    let dropDown9 = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didsubmit.isEnabled = false
        errormessage.text = ""
        
                let userID = Auth.auth().currentUser?.uid
                let profilePath = ref.child("users").child(userID!)
             
               profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                         let snapValue = snapshot.value as? NSDictionary
                //fix google sign in problem (when they don't have an ccount)
               
               
            
                 var points = snapValue?["points"] as? Int
              
                 self.realpoints = points!
                
                
               
             

                
               
                     })


        dropDown1.dataSource = []
        dropDown2.dataSource = []
        dropDown3.dataSource = []
        dropDown4.dataSource = []
        dropDown5.dataSource = []
        dropDown6.dataSource = []
        dropDown7.dataSource = []
        dropDown8.dataSource = []
        dropDown9.dataSource = []
        
        
        arrayOfDropDown = [dropDown1, dropDown2, dropDown3, dropDown4, dropDown5, dropDown6, dropDown7, dropDown8, dropDown9]
        arrayOfReward = [datareward1, datareward2,datareward3, datareward4, datareward5, datareward6, datareward7, datareward8, datareward9]
        arrayOfButtons = [select1, select2, select3, select4, select5, select6, select7, select8, select9]
        if parlays.pars!.count < 9 {
            var currentind = parlays.pars!.count
           
            while currentind < 9 {
                arrayOfButtons[currentind].isHidden = true
                currentind += 1
                
            }
        }
     
      
        
        var xView = UIView(frame: CGRect(x: 100, y: 800, width: self.view.frame.size.width, height: self.view.frame.size.height))
     
        dropDown1.anchorView = xView
        dropDown2.anchorView = xView
        dropDown3.anchorView = xView
        dropDown4.anchorView = xView
        dropDown5.anchorView = xView
        dropDown6.anchorView = xView
        dropDown7.anchorView = xView
        dropDown8.anchorView = xView
        dropDown9.anchorView = xView
        
                         dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
                             self.select1.setTitle(item, for: .normal)
                            self.calculateCurrentOdds()
                         }
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select2.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
        dropDown3.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select3.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
        dropDown4.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select4.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
        dropDown5.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select5.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
        dropDown6.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.select6.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
        dropDown7.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select7.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
        dropDown8.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select8.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
        dropDown9.selectionAction = { [unowned self] (index: Int, item: String) in
            self.select9.setTitle(item, for: .normal)
            self.calculateCurrentOdds()
        }
            dropDown1.direction = .any
        dropDown2.direction = .any
        dropDown3.direction = .any
        dropDown4.direction = .any
        dropDown5.direction = .any
        dropDown6.direction = .any
        dropDown7.direction = .any
        dropDown8.direction = .any
        dropDown9.direction = .any
        DropDown.appearance().textColor = UIColor.white

                                DropDown.appearance().selectedTextColor = UIColor.white
                                DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
                                DropDown.appearance().backgroundColor = UIColor(named: "telisequa")
                                DropDown.appearance().selectionBackgroundColor = UIColor(named: "pink")!
                                DropDown.appearance().cellHeight = 60
                                dropDown1.width = self.view.frame.size.width - 80
        dropDown2.width = self.view.frame.size.width - 80
        dropDown3.width = self.view.frame.size.width - 80
        dropDown4.width = self.view.frame.size.width - 80
        dropDown5.width = self.view.frame.size.width - 80
        dropDown6.width = self.view.frame.size.width - 80
        dropDown7.width = self.view.frame.size.width - 80
        dropDown8.width = self.view.frame.size.width - 80
        dropDown9.width = self.view.frame.size.width - 80


        var realdates: [Date] = []
        for (keyer, valer) in parlays.pars!{
            let dateFormatterPrint343 = DateFormatter()
            dateFormatterPrint343.dateFormat = "MMddyy"
            
            let dateFormatterPrint23 = DateFormatter()
            dateFormatterPrint23.dateFormat = "MM/dd/yy, h:mm a"
            var currentdate = dateFormatterPrint23.date(from: valer)
            realdates.append(currentdate!)
            
            
            var dater = dateFormatterPrint343.string(from: currentdate!)
            dateries.append(currentdate!)
            names.append(dater+keyer)
        
        }
        var smallestDate: Date = realdates[0]
        for date in realdates {
            if date < smallestDate{
                smallestDate = date
            }
        }
        
      
           var dateMinute: Int = 0
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
              
        dateDate = Int(dateFormatterPrintDate.string(from: smallestDate))!
        
        dateMonth = Int(dateFormatterPrintMonth.string(from: smallestDate))!
        
        dateYear = Int(dateFormatterPrintYear.string(from: smallestDate))!
        
        dateHhout = Int(dateFormatterPrintHour.string(from: smallestDate))!
        
        dateMinute = Int(dateFormatterPrintMinute.string(from: smallestDate))!
        
        
        for (dex, namer) in names.enumerated(){
            let contestPath = ref.child("contests").child("live").child(names[dex])
                     
            contestPath.observeSingleEvent(of: .value, with: { (snapshot) in
                                 let snapValue = snapshot.value as? NSDictionary
                        //fix google sign in problem (when they don't have an ccount)
                       
                        
                      
                        
                    
                         var cats = snapValue?["Category"] as? String
                   
                        var ops2 = snapValue?["Options"]
                        
                        var contdict = ops2.unsafelyUnwrapped as! NSDictionary
                        
                        for pair in contdict {
                       
                            var curval = pair.value as! NSDictionary
                           
                  
                            self.arrayOfDropDown[dex].dataSource.append(pair.key as! String)
                            
                            self.arrayOfReward[dex].append(curval["reward"]! as! Int)
                         
                            
                  
                             

                      
                        }
                      //  print(contdict.count)
                      
                       

                     
                       
                        
                       
                             })
            
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
