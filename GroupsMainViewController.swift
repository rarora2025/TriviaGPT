//
//  GroupsMainViewController.swift
//  June20Proj
//
//  Created by Rahul on 5/13/22.
//  Copyright © 2022 Rahul. All rights reserved.
//

//NOT GROUPS< BUT RATHER DONATION

import UIKit
import CardSlider

struct Item: CardSliderItem {
    var image: UIImage
    
    var rating: Int?
    
    var title: String
    
    var subtitle: String?
    
    var description: String?
    
    
}


class GroupsMainViewController: UIViewController, CardSliderDataSource {
    var goingHome = false
    var don = false
    var data = [Item]()
    func item(for index: Int) -> CardSliderItem {
        return data[index]
    }
    
    func numberOfItems() -> Int {
        return data.count
    }
    @objc func buttonAction(sender: UIButton!) {

    
        goingHome = true
        self.dismiss(animated: false, completion: nil)
        
    }
    @objc func buttondonAction(sender: UIButton!) {

       
           don = true
           self.dismiss(animated: false, completion: nil)
           
       }
    
    override func viewDidAppear(_ animated: Bool) {
        
    
        
        if goingHome{
            self.dismiss(animated: false, completion: nil)
           
        }
        if don {
            self.performSegue(withIdentifier: "letsdonate", sender: self)
        }
        data.append(Item(image: UIImage(named: "charity-1")!, rating: nil, title: "SAT Math", subtitle: "Standardized Test", description: "Covers mathematical skills and knowledge, including algebra, geometry, trigonometry, and data analysis, to evaluate students' readiness for college-level math courses."))
        
        data.append(Item(image: UIImage(named: "charity-2")!, rating: nil, title: "APUSH", subtitle: "AP Course/Exam", description: "Covers the history of the United States from pre-Columbian times to the present, including the colonial period, the American Revolution, the Civil War, and the Civil Rights Movement, to provide students with a comprehensive understanding of American history."))
        data.append(Item(image: UIImage(named: "charity-3")!, rating: nil, title: "AP Chem", subtitle: "AP Course/Exam", description: "Covers the fundamental principles of chemistry, including atomic structure, chemical bonding, and chemical reactions, to provide students with a foundational understanding of the chemical world."))
        data.append(Item(image: UIImage(named: "charity-4")!, rating: nil, title: "AP Bio", subtitle: "AP Course/Exam", description: "Covers the fundamental concepts of biology, including cellular processes, genetics, evolution, and ecology, to provide students with a comprehensive understanding of life and living organisms."))
        data.append(Item(image: UIImage(named: "charity-5")!, rating: nil, title: "AP Calculus", subtitle: "AP Course/Exam", description: "Covers the topics of limits, derivatives, integrals, and the Fundamental Theorem of Calculus. Equivalent to first-semester and second-semester college calculus courses, respectively, to provide students with a deep understanding of calculus."))
        data.append(Item(image: UIImage(named: "charity-6")!, rating: nil, title: "AP Statistics", subtitle: "AP Course/Exam", description: "Covers the fundamental principles of statistics, including data analysis, probability, and statistical inference, to provide students with a foundational understanding of statistical methods."))
        data.append(Item(image: UIImage(named: "charity-7")!, rating: nil, title: "APES", subtitle: "AP Course/Exam", description: "Covers the interdisciplinary study of environmental issues, including ecology, geology, and human impacts on the environment, to provide students with a comprehensive understanding of environmental science."))
        data.append(Item(image: UIImage(named: "charity-8")!, rating: nil, title: "AP Physics", subtitle: "AP Course/Exam", description: "Covers the fundamental principles of physics, including mechanics, waves, and electricity, to provide students with a comprehensive understanding of the physical world."))
       
        data.append(Item(image: UIImage(named: "charity-9")!, rating: nil, title: "Precalculus", subtitle: "Math Course", description: "Covers the fundamental concepts of algebra and trigonometry, including functions, equations, and graphs, to provide students with a solid foundation for further study in mathematics."))
        data.append(Item(image: UIImage(named: "charity-10")!, rating: nil, title: "SAT English", subtitle: "Standardized Test", description: "Covers reading and writing skills, including reading comprehension, grammar, and essay writing, to evaluate students' readiness for college-level English courses."))
        
       
        
       
        let vc = CardSliderViewController.with(dataSource: self)
    
        
        vc.title = "Courses"
       
        
//        let button = UIButton(frame: CGRect(x: view.window!.width-150, y: 50, width: 125, height: 50))
//        button.backgroundColor = UIColor(named: "default")
//        button.setTitle("Donate", for: .normal)
//        button.addTarget(self, action: #selector(buttondonAction), for: .touchUpInside)
//
//        let button2 = UIButton(frame: CGRect(x: view.window!.width-150, y: view.window!.height-65, width: 125, height: 25))
//               button2.backgroundColor = UIColor(named: "reverse")
//               button2.setTitle("Return Home", for: .normal)
//               button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        
        vc.modalPresentationStyle = .fullScreen
       // vc.view.addSubview(button)
        //vc.view.addSubview(button2)
        
 
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(gesture:)))
            gesture.direction = direction
            vc.view.addGestureRecognizer(gesture)
        }
        // Do any additional setup after loading the view.
    
   
        present(vc, animated: true)
    }
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print(gesture.direction)
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.down:
            print("down swipe")
        case UISwipeGestureRecognizer.Direction.up:
            print("up swipe")
        case UISwipeGestureRecognizer.Direction.left:
            print("left swipe")
        case UISwipeGestureRecognizer.Direction.right:
            print("right swipe")
        default:
            
            print("other swipe")
        }
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
