//
//  ViewController.swift
//  Vivek 2024
//
//  Created by Rahul on 8/19/23.
//

import UIKit
import WebKit
import SafariServices
import SkeletonView
struct wifis {
    static var didConnect = false
}
struct curtop {
    static var topic: String = "Random"

    
    
    
}


extension UIImageView {

    func makeRounded1() {

        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
    }
}

class LBViewController: UIViewController {
    
    
    var articles: Array<myResults> = []
  
    @IBOutlet weak var tableview: UITableView!
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
    
      
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
    
    func gettingData(){

        let url = URL(string: "https://api.npoint.io/b3492e8527257fb69019")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.addValue("c9d5f944", forHTTPHeaderField: "X-test")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                 let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(ArticlesAPI.self, from: data)
                self.articles = Array(response.articles)
                
                print("RESPONSE")
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }

            } catch {
                print("ERROR")
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "background")?.cgImage
        tableview.isSkeletonable = true
        tableview.delegate = self
        tableview.dataSource = self
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        var timer = Timer()
     
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            if wifis.didConnect == false {
               
                    DispatchQueue.main.async {
                        self.gettingData()
                        self.tableview.reloadData()
                        
                        
                        
                    }
                
            }
            })
        
        
//        let button2 = UIButton(type: .custom)
//              //set image for button
//      button2.setImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
//      //add function for button
//      button2.addTarget(self, action: #selector(sharebut), for: .touchUpInside)
//      //set frame
//      button2.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
//
//              let barButton2 = UIBarButtonItem(customView: button2)
//        self.navigationItem.rightBarButtonItems = [barButton2]
        self.navigationItem.title = "Trending"
       
       // self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "pink")]
       
//        let url = "https://api.npoint.io/efbb509ddb1db99f8d34"
//        var result: ArticlesAPI?
//        do{
//            result = try JSONDecoder().decode(ArticlesAPI.self, from: $.getJSON(url))
//        } catch {
//            print("failed to fetch trivia data from https://opentdb.com/api.php?amount=5")
//            print(error.localizedDescription)
//        }

       
    
       
      gettingData()
//            print("HTML------")
//            var request = URLRequest(url: URL(string: "https://www.vivek2024.com/media/?_post_type=post")!)
//            request.httpMethod = "GET"
//            let session = URLSession.init(configuration: URLSessionConfiguration.default)
//            session.dataTask(with: request) {data,response,error in
//                if let data = data {
//                   let contents = String(data: data, encoding: .ascii)
//                    print(contents)
//                }
//            }.resume()
//            print("HTML END------")
            
        
        
    }
   


}
extension LBViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.articles.count != 0 {
            curtop.topic = self.articles[indexPath.row].source + "---" + self.articles[indexPath.row].subtitl
            self.performSegue(withIdentifier: "newtop", sender: self)
            //1-29-24
//            let url = URL(string: self.articles[indexPath.row].link)
//            let vc = SFSafariViewController(url: url!)
//            present(vc, animated: true, completion: nil)
        }
    }
    
}
extension LBViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.articles.count == 0 {
            return 10
        } else {
            return self.articles.count
            
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if self.articles.count == 0 {
            cell.contentView.isSkeletonable = true
           
            cell.contentView.showAnimatedSkeleton()
        } else {
            wifis.didConnect = true
            cell.contentView.hideSkeleton()
            cell.textLabel?.text = self.articles[indexPath.row].source
            cell.textLabel?.textColor = UIColor(named: "telisequa")
            cell.detailTextLabel?.text = self.articles[indexPath.row].subtitl
            cell.detailTextLabel?.textColor = UIColor(named: "pink")
            cell.imageView?.makeRounded1()
            let image = UIImage(named: "liveicon")
                let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
                checkmark.image = image
         
            
                cell.accessoryView = checkmark
//            let url = URL(string:self.articles[indexPath.row].image)
//            
//               if let data = try? Data(contentsOf: url!)
//               {
//                   let image: UIImage = UIImage(data: data)!
//                
//                   cell.imageView!.image = imageWithImage(image: image, scaledToSize: CGSize(width: 50, height: 50))
//                   
//               }
            
        }
        
        
        print(self.articles)
        
       
       
        
        return cell
    }
    
}

struct ArticlesAPI: Codable {
    let articles: [myResults]
    
}
struct myResults: Codable {
    let source: String
    let link: String
    let image: String
    let subtitl: String
    
}
