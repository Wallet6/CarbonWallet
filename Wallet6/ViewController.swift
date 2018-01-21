//
//  ViewController.swift
//  Wallet6
//
//  Created by Danny Peng on 1/20/18.
//  Copyright © 2018 Danny Peng. All rights reserved.
//

import UIKit
import UICircularProgressRing


class ViewController: UIViewController {
    @IBOutlet weak var ProgressRing: UICircularProgressRingView!
    
    @IBOutlet weak var ArchiveButton: UIButton!
    
    @IBOutlet weak var Welcome: UILabel!
    
    @IBOutlet weak var brand: UIImageView!
    
    struct DailyStruct
    {
        var date: String
        var distance: Int
        var emission: Int
        
        init(_ date:String, _ distance:Int, _ emission:Int)
        {
            self.date = date
            self.emission = emission
            self.distance = distance
        }
    }
    
    var name = "Dr. Jonathan Prosacco"
    
    var dailyAllowance = 0
    var dailyUsage = 0
    
    var list:[DailyStruct] = [DailyStruct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*Put in SYNC function*/
//        ProgressRing.value = 10
//        Welcome.text = "Welcome Georgiana"
        
        DispatchQueue.main.async {
            self.ProgressRing.value = 19
            self.Welcome.text = self.name
            self.brand.image = UIImage(named: "my6footprintlogo-green.png")
            
            self.get_data("http://www.my6footprint.com/api/v1/users")
                    
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func get_data(_ link:String)
    {
        
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            self.extract_data(data)
            
        })
        
        task.resume()
    }
    
    func extract_data(_ data:Data?)
    {
        let json:Any?
        
        if(data == nil)
        {
            return
        }
        
        do{
            json = try JSONSerialization.jsonObject(with: data!, options: [])
        }
        catch
        {
            return
        }
        
        guard let data_array = json as? NSArray else
        {
            return
        }
        
        for i in 0 ..< data_array.count
        {
            if let data_object = data_array[i] as? NSDictionary
            {
                let data_name = data_object["name"]
                if name == data_name as! String{
                    print("HEHEHE")
                    dailyUsage = data_object.object(forKey: "emission_usage") as! Int
                    if let data_emission_history = data_object["emission_history"] as? NSArray {
                      
                        dailyUsage = data_object.object(forKey: "emission_usage") as! Int
                         print(dailyUsage)
                        
                        for i in 0 ..< data_emission_history.count {
                            let data_single_day = data_emission_history[i] as? NSDictionary
                            let data_date = data_single_day!.object(forKey: "date")
                            let data_distance = data_single_day!.object(forKey: "distance")
                            let data_emission = data_single_day!.object(forKey: "emission")
                            list.append(DailyStruct(data_date as! String, data_distance as! Int, data_emission as! Int))
                        }
                        print(list)
                        DispatchQueue.main.sync {
                            dailyUsage = data_object.object(forKey: "emission_usage") as! Int
                            print(dailyUsage)
                            print("REACHED")
                            
                        }
                        
                        return
                        
                    }
                }
            }
        }
    }



}

