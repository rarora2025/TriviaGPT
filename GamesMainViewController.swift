//
//  GamesMainViewController.swift
//  June20Proj
//
//  Created by Rahul on 8/27/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit

class GamesMainViewController: UIViewController {
    @IBOutlet weak var flip: UIButton!
    @IBOutlet weak var pickanum: UIButton!
    @IBOutlet weak var rps: UIButton!
    @IBOutlet weak var roll: UIButton!
    @IBOutlet weak var backgroundone: UIImageView!
    @IBAction func clickedtriv(_ sender: UIButton) {
        //clicked trivia
    }
    
    @IBOutlet weak var scview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundone.layer.cornerRadius = 18
        roll.layer.cornerRadius = 18
        flip.layer.cornerRadius = 18
        rps.layer.cornerRadius = 18
        pickanum.layer.cornerRadius = 18
       UIView.animate(withDuration: 5, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse, .allowUserInteraction], animations: {
                        
                
                 self.scview.backgroundColor = UIColor(named: "telisequa")
                 
                 self.view.backgroundColor = UIColor(named: "telisequa")
                      
                      
                 
                             
            
                        self.scview.backgroundColor = UIColor(named: "pink")
           self.view.backgroundColor = UIColor(named: "pink")
                     
                       
                       //


                    }, completion: nil)
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
