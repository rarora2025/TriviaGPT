//
//  InvestViewController.swift
//  June20Proj
//
//  Created by Rahul on 3/17/22.
//  Copyright © 2022 Rahul. All rights reserved.
//

import UIKit
struct currentInvestment {
    static var name: String = ""
    static var price: Int = 0
}
import FirebaseAuth
import Firebase
class InvestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var array: [String] = []
    var arrOfnames: [String] = []
    var arrOfprices: [Int] = []
    var ref: DatabaseReference! = Database.database().reference()
    var database = Database.database()
    let userID = Auth.auth().currentUser?.uid

    @IBOutlet weak var tblview: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentInvestment.name = arrOfnames[indexPath.row]
        currentInvestment.price = arrOfprices[indexPath.row]
        self.performSegue(withIdentifier: "finish", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell2")
        cell.textLabel?.text = array[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func china(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tblview.dataSource = self
        tblview.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(china))
        
        // Do any additional setup after loading the view.
        
        let profilePath0 = ref.child("games").child("investments")
            
            profilePath0.observeSingleEvent(of: .value, with: { (snapshot) in
                
                
          
                let snapValue = snapshot.value as? NSDictionary
                //fix google sign in problem (when they don't have an ccount)
                
                
                for (key, val) in snapValue!{
                    self.arrOfnames.append(key as! String)
                    self.arrOfprices.append(val as! Int)
                    var word = ""
                    word += String(describing: key)
                    word += ", unit price = "
                    word += String(describing: val as! Int)
                    word += " cc"
                    self.array.append(word)
                }
                self.tblview.reloadData()
                
           
              
              
              
              
        
       
              
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
