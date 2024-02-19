//
//  LiveViewController.swift
//  June20Proj
//
//  Created by Rahul on 7/12/20.
//  Copyright © 2020 Rahul. All rights reserved.





import UIKit
import Firebase
import FirebaseAuth
import SCLAlertView
import NotificationBannerSwift

extension Date {
    static func calculateDaysBetweenTwoDates(start: Date, end: Date) -> Int {

        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: start) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: end) else {
            return 0
        }
        return end - start
    }

    static func getFormattedDate(date: Date) -> String{
       
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"


        return dateFormatterPrint.string(from: date);
    }
    static func getFormattedDate2(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yy, h:mm a"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let date: Date? = dateFormatterGet.date(from: string)
       
        return dateFormatterPrint.string(from: date!);
    }
}


extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}

class LiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var parlayed: [String:String] = [:]
    var modeLive: Bool = true
    var makingParlay: Bool = false
    @IBOutlet weak var didChangeType: UISegmentedControl!
    
    @IBAction func didChangeTpe(_ sender: UISegmentedControl) {
        modeLive = !modeLive
        switch modeLive {
        case true:
            tblview.isHidden = false
        default:
            refreshingdata.text = ""
            self.performSegue(withIdentifier: "viewmycontests", sender: self)
        }
        
    }
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"

        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }

        //You can directly use from here if you have two dates

        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let intervalInt = Int(interval)
        return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
    }
    
    @IBAction func test(_ sender: UIButton) {
        print(parlayed)
             if makingParlay {
                 if parlayed[all_comps[(sender as AnyObject).tag].name] == nil {
                 parlayed[all_comps[(sender as AnyObject).tag].name] = all_comps[(sender as AnyObject).tag].date
                 sender.setTitle("Remove", for: .normal)
                 sender.backgroundColor = UIColor.green
                 } else {
                     parlayed.removeValue(forKey: all_comps[(sender as AnyObject).tag].name)
                     sender.setTitle("Select", for: .normal)
                     sender.backgroundColor = UIColor(named: "pink")
                 }
             
             } else {
                 currentCell.current = all_comps[(sender as AnyObject).tag].name
                 currentCell.currentd = all_comps[(sender as AnyObject).tag].date
                 self.performSegue(withIdentifier: "letbet", sender: self)
                 
             }
    }
    @IBAction func didTapButton(_ sender: UIButton) {
        print(parlayed)
        if makingParlay {
            if parlayed[all_comps[(sender as AnyObject).tag].name] == nil {
            parlayed[all_comps[(sender as AnyObject).tag].name] = all_comps[(sender as AnyObject).tag].date
            sender.setTitle("Remove", for: .normal)
            sender.backgroundColor = UIColor.green
            } else {
                parlayed.removeValue(forKey: all_comps[(sender as AnyObject).tag].name)
                sender.setTitle("Select", for: .normal)
                sender.backgroundColor = UIColor(named: "pink")
            }
        
        } else {
            currentCell.current = all_comps[(sender as AnyObject).tag].name
            currentCell.currentd = all_comps[(sender as AnyObject).tag].date
            self.performSegue(withIdentifier: "letbet", sender: self)
            
        }
     
        
     
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
  
        if Auth.auth().currentUser?.uid == "KINKNvmLfwfkAuUApVtOtwbBcJ52" {
        return true
        } else {
            return false
            
        }
    }
 
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MMddyy"
            
            let dateFormatterPrint2 = DateFormatter()
            dateFormatterPrint2.dateFormat = "MM/dd/yy, h:mm a"

            
            let dater = all_comps[indexPath.row].date
            
            let date = dateFormatterPrint2.date(from: dater)

              
            let contest = all_comps[indexPath.row].name
           
            
            let contest_title = dateFormatterPrint.string(from: date!) + contest
            
            var deletingref = self.ref.child("contests").child("live").child(contest_title)
           
            deletingref.removeValue()
            
        
            all_comps = all_comps.filter { $0.name != contest }
            
           tableView.deleteRows(at: [indexPath], with: .left)
    }}
    

    
    var all_comps: [competition] = []
      var ref = Database.database().reference()
  var selectedIndexPath: IndexPath?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if !makingParlay{
        self.expandRow(at: indexPath)
        }
        
      
    }

   

    @IBAction func clicked(_ sender: Any) {
       
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if let path = selectedIndexPath {
            if indexPath == selectedIndexPath {
                return 200
            } else {
                return 100
                
            }
         
        } else {
        return 100
        }
    }
    
  
    func expandRow(at indexPath: IndexPath?) {
   
        selectedIndexPath = indexPath
      
        
        tblview.beginUpdates()

        tblview.endUpdates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tblview.reloadData()
        }

        
        if let ip = indexPath {
            tblview.scrollToRow(at: ip, at: .none, animated: true)
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return all_comps.count
    }
    
    @IBAction func didClickButton(_ sender: Any) {

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LiveEventCell
       
        cell?.backgroundColor = UIColor.white
       
        if makingParlay {
            cell?.enter1.backgroundColor = UIColor(named: "pink")
            cell?.realbutton.backgroundColor = UIColor(named: "pink")
            cell?.enter1.setTitle("Select", for: .normal)
       
            cell?.realbutton.setTitle("Select", for: .normal)
            
        } else {

            cell?.enter1.setTitle("Wager", for: .normal)
            cell?.enter1.backgroundColor = UIColor(named: "telisequa")
            cell?.realbutton.backgroundColor = UIColor(named: "telisequa")
            cell?.realbutton.setTitle("Wager", for: .normal)
       

        }
        cell?.selectionStyle = .blue
      
        if indexPath == selectedIndexPath {
            let backgroundView = UIView()
            backgroundView.backgroundColor = .white
            cell?.selectedBackgroundView = backgroundView
            cell?.backgroundColor = .white
            cell?.textLabel?.alpha = 0
            cell?.textLabel?.text = ""
            
            cell?.cellDelegate = self
            cell?.index = indexPath
            cell?.enter1.tag = indexPath.row
           cell?.realbutton.tag = indexPath.row
            cell?.enter1.isHidden = true
            cell?.realbutton.isHidden = false
            
            cell?.label.isHidden = true
            cell?.category.isHidden = false
            cell?.name2.isHidden = false
            cell?.date.isHidden = false
        
            cell?.name2.text = all_comps[indexPath.row].name
            cell?.date.text = "Date: " + all_comps[indexPath.row].date
            cell?.category.text = "Category: " + all_comps[indexPath.row].category
            cell?.realbutton.layer.cornerRadius = 10
            
            cell?.textLabel?.fadeIn(completion: {
            (finished: Bool) -> Void in
            })
            cell?.textLabel?.textColor = .white
            
            print(indexPath)
            
        } else {

        
            let backgroundView = UIView()
            backgroundView.backgroundColor = .white
            cell?.selectedBackgroundView = backgroundView
            cell?.backgroundColor = .white
            cell?.enter1.isHidden = false
            
                       cell?.realbutton.isHidden = true
                       
                       cell?.category.isHidden = true
                       cell?.name2.isHidden = true
                       cell?.date.isHidden = true
             cell?.enter1.tag = indexPath.row
            cell?.realbutton.tag = indexPath.row
   
            cell?.enter1.layer.cornerRadius = 10
            cell?.label.isHidden = false
            cell?.textLabel?.text = all_comps[indexPath.row].name
            cell?.label.text = all_comps[indexPath.row].date
            cell?.detailTextLabel?.text = all_comps[indexPath.row].date
            cell?.textLabel?.textColor = .black
        }
        
        return cell!
    }
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var acind: UIActivityIndicatorView!
    @IBOutlet weak var refreshingdata: UILabel!
    func viewSetup(){
        print(all_comps)
        tblview.isHidden = true
       
                  navigationItem.rightBarButtonItem = nil
     
               acind.startAnimating()
               acind.isHidden = false
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                   self.refreshingdata.text = "Refreshing Data."
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                       self.refreshingdata.text = "Refreshing Data.."
                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                           self.refreshingdata.text = "Refreshing Data..."
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                               self.refreshingdata.text = "Refreshing Data."
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                   self.refreshingdata.text = "Refreshing Data.."
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                       self.refreshingdata.text = "Refreshing Data..."
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                           self.refreshingdata.text = "Refreshing Data."
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                               self.refreshingdata.text = "Refreshing Data.."
                                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                   self.refreshingdata.text = "Refreshing Data..."
                                                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    self.refreshingdata.text = ""
                                                    var b1 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.handlereload))
                                                    var b2 = UIBarButtonItem(title: "Parlay Builder", style: .plain, target: self, action: #selector(self.buildparlay))
                                                    self.navigationItem.setLeftBarButtonItems([b1,b2], animated: false)
                                                    
                                                    
                                                    
                                                //    self.navigationItem.setRightBarButtonItems([UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handledone)), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleadd))], animated: false)
                                                       self.navigationItem.setRightBarButtonItems([ UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleadd))], animated: false)
                                                    
                                                    
                                                       self.acind.stopAnimating()
                                                       self.tblview.isHidden = false
                                                       self.acind.isHidden = true
                         
                                                    
                                                       let userID = Auth.auth().currentUser?.uid
                                                       
                                                       //change this to match current id then grab current events
                                                       let profilePath = self.ref.child("contests").child("live")
                                                                                   
                                                                                     profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                                                                               let snapValue = snapshot.value as? NSDictionary
                                                                                      //fix google sign in problem (when they don't have an ccount)
                                                                                
                                                                                       
                                                                                       let y = snapshot.children.allObjects as? [DataSnapshot]
                                                                                   var titlery = ""
                                                                                       for x in y! {
                                                                                        var usersids: [String] = []
                                                                                        var side_users: [String: [String]] = [:]
                                                                                        var parlay_users: [String: [[String]]] = [:]
                                                                                            if let postDict = x.value as? Dictionary<String, AnyObject> {
                                                                                                let p = postDict["participants"] as?  Dictionary<String, AnyObject>
                                                                                                                                                                                      
                                                                                                                                                                                                for (keyery, valero) in p! {
                                                                                                                                                                                                  side_users[keyery] = []
                                                                                                                                                                                                    parlay_users[keyery] = []
                                                                                                                                                                                                  let users = p![keyery] as?  Dictionary<String, AnyObject>
                                                                                                                                                                                                  for (keyo, valo) in users! {
                                                                                                                                                                                                                                                                                     print("kevo " + keyo)
                                                                                                                                                                                                      usersids.append(keyo)
                                                                                                                                                                                                if let valuer = valo as? String {
                                                                                                                                                                                                    if valuer.prefix(1) == "P" {
                                                                                                           
                                                                                                                                                                                                                                                                                                          print(keyo + "is a paraly is user")
                                                                                                                                                                                                        titlery = String(valuer.suffix(valuer.count-1))
                                                                                                                                                                                                            parlay_users[keyery]!.append([keyo, String(valuer.suffix(valuer.count-1))])
                                                                                                          
                                                                                                                                                                                                    } else {
                                                                                                                   side_users[keyery]!.append(keyo)
                                                                                                                                                                                                    }
                                                                                                                                                                                                }
                                                                                                                                                                                                else {
                                                                                                                                                                                                    side_users[keyery]!.append(keyo)
                                                                                                                                                                                                }
                                                                                                         
                                                                                                                                                                
                                                                                                                                                                                                
                                                                                                          
                                                                                                                                 
                                                                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                  
                                                                                                                                                                                                  
                                                                                                                                                                                              
                                                                                                                                                                                                }
                                                                                                     //     print(postDict)
                                                                                                
                                                                                               let date = Date()
                                                                                         
                                                                                                
                                                                                                var Strdate = Date.getFormattedDate(date: date)
                                                                                              
                                                                                                
                                                                                                var Strdate2 = Date.getFormattedDate2(string: (postDict["Date"] as? String)!)
                                                                                           
                                                                                                
                                                                                                let dateFormatterGetter = DateFormatter()
                                                                                                     dateFormatterGetter.dateFormat = "MMM dd,yyyy"

                                                                                                     let startDate: Date? = dateFormatterGetter.date(from: Strdate)
                                                                                                    let startDate2: Date? = dateFormatterGetter.date(from: Strdate2)
                                                                                                
                                                                                                var diff: Int = Date.calculateDaysBetweenTwoDates(start: startDate!, end: startDate2!)
                                                                                                
                                                                                               
                                                                                               
                                                                                                
//                                                                                                // initially set the format based on your datepicker date / server String
//                                                                                                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//                                                                                                let myString = formatter.string(from: Date()) // string purpose I add here
//                                                                                                // convert your string to date
//                                                                                                let yourDate = formatter.date(from: myString)
//                                                                                                //then again set the date format whhich type of output you need
//                                                                                                formatter.dateFormat = "dd-MMM-yyyy"
//                                                                                                // again convert your date to string
//                                                                                                let myStringafd = formatter.string(from: yourDate!)
//
//                                                                                                print(myStringafd)
//
//                                                                                                let dateDiff = self.findDateDiff(time1Str: "09:54 AM", time2Str: "12:59 PM")
//                                                                                                print(dateDiff)
                                                                                                
                                                                                               let z = postDict["Options"] as?  Dictionary<String, AnyObject>
                                                                                               
                                                                                                var sidesfc: [sides] = []
                                                                                           //    print(z!["LAC"]!["reward"])
                                                                                                if diff <= 0 && (Auth.auth().currentUser!.uid == (postDict["host_id"] as? String)!) {
                                                                                                                                                                                                   
                                                                                                                                                                                                   
                                                                                                                                                                                                                  let appearancery = SCLAlertView.SCLAppearance(
                                                                                                                                                                                                                      showCloseButton: false
                                                                                                                                                                                                                  )
                                                                                                    let alertView = SCLAlertView(appearance: appearancery)
                                                                                                                                                                                               
                                                                                            
                                                                                               for (keyer, valer) in z! {
                                                                                                   var sider = sides(name: keyer, reward: (valer["reward"]!! as? Float)!)
                                                                                                  // sider.name = keyer
                                                                                                  // sider.reward = (valer["reward"]!! as? Float)!
                                                                                                   sidesfc.append(sider)
                                                                                                
                                                                                                alertView.addButton("\(sider.name)") {
                                                                                                    for (key, value) in side_users {
                                                                                                        
                                                                                                        let farray = value.filter {$0 != Auth.auth().currentUser!.uid}
                                                                                                        if farray != [] {
                                                                                                            for users in farray {
//
                                                                                                                print("\(key == sider.name), \(users)")
                                                                                                                var result: String
                                                                                                                if key == sider.name {
                                                                                                                
                                                                                                                   result = "W"
                                                                                                                } else {
                                                                                                              
                                                                                                                 
                                                                                                                    result = "L"
                                                                                                                }
                                                                                                                print(result)
                                                                                                                self.ref.child("users").child(users).child("current_contests").child(x.key).child("0").setValue(result)
                                                                                                                
                                                                                                            }
                                                                                                        }
                                                                                                        
                                                                                                    }
                                                                                                      for (key, value) in parlay_users {
                                                                                                        var result: [String:String] = [:]
                                                                                                                                                                                                
                                                                                                        """

                                                                                                            confirming that the user isnt in parlay ppl
                                                                                                            for person in value{
                                                                                                            if person[0] != Auth.auth().currentUser!.uid {}
                                                                                                                }
                                                                                                            """
                                                                                                        
                                                                                                     
                                                                                                                                                                                                            if value != [] {
                                                                                                                                                                                                                for users in value {
                                                                                                    //
                                                                                                                                                                                                                
                                                                                                                                                                                                                
                                                                                                            print("FOR")
                                                                                                                                                                                                                    
                                                                                                                                                                                                                    print(users[1])
                                                                                                                                                                                                                    print("\(key == sider.name), \(users[0])")
                                                                                                                                                                                                                    
                                                                                                                                                                                                                    if key == sider.name {
                                                                                                                                                                                                                    
                                                                                                                                                                                                                        result[users[1]] = "true"
                                                                                                                                                                                                                    } else {
                                                                                                                                                                                                                  
                                                                                                                                                                                                                     
                                                                                                                                                                                                                        result[users[1]] = "false"
                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                         
                                                                                                                                                                                                                    let profilePathery = self.ref.child("users").child(users[0]).child("current_parlay_contests")
                                                                                                                                                                                                                      
                                                                                                                                                                                                                        profilePathery.observeSingleEvent(of: .value, with: { (snapshot) in
                                                                                                                                                                                                                                  let snapContests = snapshot.value as? NSDictionary
                                                                                                                           
                                                                                                                                                                                                                            print("TODAYY")
                                                                                                                          
                                                                                                          
                                                                                                                                                                                                                            
                                                                                                                          //fix google sign in problem (when they don't have an ccount)
                                                                                                                            print(snapContests)
                                                                                                                                                                                                                            for keyery in snapContests!.allKeys {
                                                                                                                                                                                                                                var indexier = 0
                                                                                                                                                                                                                                if (keyery as! String).contains(x.key) {
                                                                                                                                                                                                                                    self.ref.child("users").child(users[0]).child("current_parlay_contests").child(keyery as! String).child(x.key + UUID().uuidString).setValue(result[keyery as! String])
                                                                                                                                                                                                                                    self.ref.child("users").child(users[0]).child("current_parlay_contests").child(keyery as! String).child(x.key).removeValue()
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                            indexier += 1
                                                                                                                                                                                                                                
                                                                                                                                                                                                                            }
                                                                                                                                                                                                              
                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                              })
                                                                                                                                                                                                                    
                                                                                                                                                                                                                    
                                                                                                                                                                                                                }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            
                                                                                                                                                                                                        }
                                                                                                            //remove contest from firebase
                                                                                                    self.ref.child("contests").child("live").child(x.key).removeValue()
                                                                                                    let banner = NotificationBanner(title: "Winner Selected", subtitle: "You have selected the winner for \(x.key). All participants will be notified", leftView: nil, rightView: nil, style: .success, colors: nil)
                                                                                                    
                                                                                                    banner.autoDismiss = false
                                                                                                    banner.show()
                                                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                                                                                                        banner.dismiss()
                                                                                                    })
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                               }
                                                                                                              
                                                                                                
                                                                                               }
                                                                                                    
                                                                                                    alertView.addButton("Game in Progress") {
                                                                                                        print(alertView.dismiss(animated: true, completion: nil))
                                                                                                                                                                                                                  }
                                                                                                 
                                                                                                    alertView.showEdit("Pick a side", subTitle: "Please pick the correct winner. You will lose editing permissions if you pick the wrong side on purpose")
                                                                                                    }
                                                                                               
                                                                                               
                                                                                               var comp = competition(category: (postDict["Category"] as? String)!, date: (postDict["Date"] as? String)!, host: (postDict["host_id"] as? String)!, name: (postDict["Name"] as? String)!, options: sidesfc)
                                                                                                
                                                                                              
                                                                                            
                                                                                              
                                                                                                
                                                                                              
                                                                                                  
                                                                                    
                                                                                                           
                                                                                                                                                                                                          
                                                                                                                                                                                                              
                                                                                                                                                                                                         var datery = postDict["Date"]!
                                                                                                                                                                                                              
                                                                                                                                                                                                          let dateGetter = DateFormatter()
                                                                                                                                                                                                                                                                                                      dateGetter.dateFormat = "MM/dd/yy, HH:mm a"
                                                                                                                                                                                                              let formattedbakery: Date? = dateGetter.date(from: datery as! String)
                                                                                                
                                                                                                var utfdate = Date()
                                                                                                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: utfdate)
                                                                                                dateComponents.hour = dateComponents.hour! - 5
                                                                                                let finishedDate = Calendar.current.date(from: dateComponents)
                                                                                            
                                                                                          
                                                                                                if self.all_comps.contains(comp) ||  usersids.contains(Auth.auth().currentUser!.uid) || formattedbakery! < finishedDate! {
                                                                                                    print(comp)
                                                                                                    print(formattedbakery)
                                                                                                    print(Date())
                                                                                                    print(formattedbakery! < Date() )
                                                                                                    
                                                                                                    print("above is overdue")
                                                                                            
                                                                                                    
                                                                                                } else {
                                                                                               
                                                                                                    
                                                                                                
                                                                                                  
                                                                                               self.all_comps.append(comp)
                                                                                                }
                                                                                            
                                                                                                
                                                                                               DispatchQueue.main.async {
                                                                                                         self.tblview.reloadData()
                                                                                               }
                                                                                                                                                                                    
                                                                                         
                                                                                               
                                                                                                        
                                                                                                         
                                                                                                      } else {
                                                                                                      
                                                                                                      }
                                                                   
                                                                                       }
                                                                                       
                                                                                   
                                                                                     
                                                                                        
                                                                                 
                                                                      
                                                                               
                                                                             
                                                                                          
                                                                                        
                                                               
                                                                                               })
                                                      
                                                       DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                
                                                           
                                                           self.tblview.reloadData()
                                                           
                                                           UIView.animate(withDuration: 5.0) {
                                   
                                                             
                                                                     }
                                               
                                                       
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                                          
                                                                    UIView.animate(withDuration: 3.0) {
                                                                                                              
                                                                                                                                                                     
                                                                                                                                                                             }
                                                        }
                                                                    
                                                        }
                                                      
                                                       
                                                   }
                                                   
                                               }
                                             
                                               
                                           }
                                           
                                       }
                                       
                                       
                                   }
                                   
                               }
                           }
                       }
                   }
               }
    }
    override func viewDidAppear(_ animated: Bool) {
         tblview.isHidden = true
        viewSetup()
        
     
    }
    override func viewDidLoad() {
        
        print(all_comps)
        super.viewDidLoad()
         
        tblview.delegate = self
        tblview.dataSource = self
      tblview.isHidden = true
        self.didChangeType.isHidden=true
  
        // Do any additional setup after loading the view.
    }
    @objc func handleadd(){
        self.performSegue(withIdentifier: "askforpass", sender: self)
        
        //
    }
    @objc func buildparlay(){
     
        if makingParlay {
            makingParlay = false
            tblview.allowsMultipleSelection = false
           
            var b1 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.handlereload))
            var b2 = UIBarButtonItem(title: "Parlay Builder", style: .plain, target: self, action: #selector(self.buildparlay))
            self.navigationItem.setLeftBarButtonItems([b1,b2], animated: false)
            if parlayed != [:]{
                
                if parlayed.count >= 10 {
                    let appearancery2 = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                    )
                    let alertView2 = SCLAlertView(appearance: appearancery2)
                    alertView2.addButton("Ok") {
                        print(alertView2.dismiss(animated: true, completion: nil))
                                                                                                                                  }
                 
                    alertView2.showError("Max Parlay Limit", subTitle: "Your parlay cannot have 10+ teams")
                   
                    }else {
                     
                parlays.pars = parlayed
                     
                self.performSegue(withIdentifier: "letparlay", sender: self)
                }
                
                
            }
            tblview.reloadData()
        } else {
            makingParlay = true
            parlayed = [:]
           
            var b1 = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.handlereload))
            var b2 = UIBarButtonItem(title: "Generate Parlay", style: .done, target: self, action: #selector(self.buildparlay))
            self.navigationItem.setLeftBarButtonItems([b1,b2], animated: false)
            tblview.reloadData()
        }
       
       }
    @objc func finishparlay(){
//        if (tblview.indexPathsForSelectedRows == []){
//            buildparlay()
//
//        }
        //self.performSegue(withIdentifier: "back", sender: self)
        
         //if 0 selected, then cancel, dont allow mult select
    }
    
    @objc func handlereload(){

        viewSetup()
    }
    
    @objc func handledone(){

         self.performSegue(withIdentifier: "back", sender: self)
       
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
struct competition: Equatable {
    static func == (lhs: competition, rhs: competition) -> Bool {
        return lhs.name == rhs.name && lhs.date == rhs.date && lhs.host == rhs.host
    }
    
    var category: String
    var date: String
    var host: String
    var name: String
    var options: [sides]
    
}
extension LiveViewController: TableViewNew {
    func onClickCell(index: Int) {
        print("clicked")
    }
}
struct sides {
    var name: String
    var reward: Float
    
}

