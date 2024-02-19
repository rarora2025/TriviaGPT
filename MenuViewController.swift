//
//  MenuViewController.swift
//  June20Proj
//
//  Created by Rahul on 6/27/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBAction func didclickprof(_ sender: UIButton) {
        performSegue(withIdentifier: "profil", sender: self)
    }
    
    @IBAction func signout(_ sender: UIButton) {
       
     
        let destroyAction = UIAlertAction(title: "Sign Out",
                    style: .destructive) { (action) in
                        self.performSegue(withIdentifier: "signOut", sender: self)
          }
          let cancelAction = UIAlertAction(title: "Cancel",
                    style: .cancel) { (action) in
           // Respond to user selection of the action
          }
               
          let alert = UIAlertController(title: nil,
                      message: nil,
                      preferredStyle: .actionSheet)
          alert.addAction(destroyAction)
          alert.addAction(cancelAction)
               
   
    
               
         if let popoverPresentationController = alert.popoverPresentationController {
              popoverPresentationController.sourceView = self.view
              popoverPresentationController.sourceRect = sender.bounds
            popoverPresentationController.sourceRect.origin.y += 610
            popoverPresentationController.sourceRect.origin.x += 50
          }
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var friendsbut: UIButton!
    @IBOutlet weak var profileBut: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissMenu(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
        profileBut.layer.cornerRadius = 8
        friendsbut.layer.cornerRadius = 8
   
        signOut.layer.cornerRadius = 8
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
