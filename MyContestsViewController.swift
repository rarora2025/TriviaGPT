//
//  MyContestsViewController.swift
//  June20Proj
//
//  Created by Rahul on 8/15/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
import Firebase
class MyContestsViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        
//        if contests[0]["loading"] != 404{
//            var full = Array((contests[indexPath.row]).keys)[0]
//            var chars = full.count
        cell.textLabel?.text = contests[indexPath.row]
//            var date = Array((contests[indexPath.row]).keys)[0].prefix(6)
//        
//
//            // Create Date Formatter
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMddyy"
//            var obj = dateFormatter.date(from: String(date))
//
//            if obj! > Date(){
//                           cell.detailTextLabel?.textColor = UIColor.systemYellow
//                           cell.detailTextLabel?.text = "Pending: " + String(Array((contests[indexPath.row]).values)[0]) + " points"
//            } else if Array((contests[indexPath.row]).values)[0] < 0 {
//                  cell.detailTextLabel?.textColor = UIColor.systemRed
//                 cell.detailTextLabel?.text = String(Array((contests[indexPath.row]).values)[0]) + " possible points"
//                
//            } else {
//                cell.detailTextLabel?.textColor = UIColor.systemGreen
//                cell.detailTextLabel?.text = "+" + String(Array((contests[indexPath.row]).values)[0]) + " points"
//                
//            }
//            
            
         
  
        
       
        print(contests)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contests.count
    }
    
     var ref = Database.database().reference()
    var contests: [String]  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Contests"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handlereload))
                   
        
            let userID = Auth.auth().currentUser?.uid
        let profilePath = ref.child("users").child(userID!).child("past_games")
            profilePath.observeSingleEvent(of: .value, with: { (snapshot) in
                                                 let snapValue = snapshot.value as? NSDictionary
                                        //fix google sign in problem (when they don't have an ccount)
                               
                                            
            
            var names = snapValue!.allKeys
            var changes = snapValue!.allValues
                
                
                self.contests.remove(at: 0)
                for (index, name) in names.enumerated() {
                  
     
                    
                   // contest[name as! String] = changes[index] as! Int
                    self.contests.append(name as! String)

                }
        
                print(self.contests)
    
                self.tableView.reloadData()
                print(self.contests)
                

                                    
                
    
                
                
                
                                           
                                            
                                    
                                     
                                     

                                       
                                             })
        // Do any additional setup after loading the view.
    }
    @objc func handlereload(){
        self.performSegue(withIdentifier: "dismissMyContests", sender: self)
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
