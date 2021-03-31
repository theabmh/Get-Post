//
//  ViewController.swift
//  Get_Post
//
//  Created by iroid on 30/03/21.
//  Copyright © 2021 iroid. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {


    @IBOutlet var Mycv: UICollectionView!
    
    let getdata = NSMutableData()
    var Jsondata = NSArray()
    var jsonDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let urlReq = URLRequest(url: URL(string:"http://iroidtechnologies.in/bigfish/Bigfish_cntrl/HealthyFish_Recipes")!)
        let task = URLSession.shared.dataTask(with: urlReq){(data,request,error) in
            
            if let mydata = data {
                print("mydata >>>>>",mydata)
                
                do{
                    
                    self.Jsondata = try JSONSerialization.jsonObject(with: mydata, options: []) as! NSArray
                    
                    DispatchQueue.main.async {
                        
                        self.Mycv.reloadData()
                    }
                }
                
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    task.resume()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Jsondata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ccell = collectionView.dequeueReusableCell(withReuseIdentifier: "rec", for: indexPath) as! RecipieCVcell
        
        self.jsonDict = self.Jsondata[indexPath.item] as! NSDictionary
        
        ccell.namelbl.text = self.jsonDict.value(forKey: "name") as? String
        ccell.idlbl.text = String(describing:self.jsonDict.value(forKey: "recipe_id")!)
        ccell.difficultlbl.text = String(describing:self.jsonDict.value(forKey: "difficulty")!)
        ccell.timelbl.text = String(describing:self.jsonDict.value(forKey: "cookingtime")!)
        
        let imageurl = URL(string:String(describing:self.jsonDict.value(forKey: "image")!))
        let imagedata = try? Data(contentsOf:imageurl!)
        
        ccell.imagevw.image = UIImage(data: imagedata!)
        return ccell
    
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storybrd = UIStoryboard(name: "Main", bundle: nil)
        let Recipepage = storybrd.instantiateViewController(withIdentifier: "RECIPE") as! RecipeVC
         self.jsonDict = self.Jsondata[indexPath.item] as! NSDictionary
        Recipepage.STRID = String(describing:self.jsonDict.value(forKey: "recipe_id")!)
       
        
    self.navigationController?.pushViewController(Recipepage, animated: true)
        
    }

}
