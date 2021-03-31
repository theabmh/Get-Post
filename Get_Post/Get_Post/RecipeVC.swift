//
//  RecipeVC.swift
//  Get_Post
//
//  Created by iroid on 31/03/21.
//  Copyright © 2021 iroid. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController {
    
    var STRID = String()
    let getData = NSMutableData()

    @IBOutlet var Namelbl: UILabel!
    
    @IBOutlet var ingrtv: UITextView!
    
    @IBOutlet var htctv: UITextView!
    
    @IBOutlet var timelbl: UILabel!
    
    var jsondata = NSDictionary()
    
    @IBOutlet var imagevw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(STRID)
        
        var UrlReq = URLRequest(url: URL(string:"http://iroidtechnologies.in/bigfish/Bigfish_cntrl/HealthyFish_Recipes_Detail")!)
        UrlReq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
        UrlReq.httpMethod = "post"
        
        let PostStr = ("recipe_id=\(STRID)")
        
        
        
        
        
        UrlReq.httpBody = PostStr.data(using: .utf8)
        
        let Task = URLSession.shared.dataTask(with: UrlReq){(data,request,error) in
            if let mydata = data {
                print("mydata = >>>",mydata)
                
                do {
                    
                    self.getData.append(mydata)
                     self.jsondata = try JSONSerialization.jsonObject(with: self.getData as Data, options: []) as! NSDictionary
                    print("jsondata >>>>>>>>",self.jsondata)
                    
                    DispatchQueue.main.async {
                        
                        self.Namelbl.text = String(describing:self.jsondata.value(forKey: "name")!)
                        self.timelbl.text = String(describing: self.jsondata.value(forKey: "cooking time")!)
                        self.ingrtv.text = String(describing:self.jsondata.value(forKey: "ingredience")!)
                        self.htctv.text = String(describing:self.jsondata.value(forKey: "how to cook")!)
                        
                        let imageUrl = URL(string:String(describing:self.jsondata.value(forKey: "image")!))
                        let imageData = try? Data(contentsOf:imageUrl!)
                        self.imagevw.image = UIImage(data: imageData!)
                    }
                    
                    
                    
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        Task.resume()
        
    }
    


    

}
