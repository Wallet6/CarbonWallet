//
//  ViewController.swift
//  JsonData
import Foundation
import UIKit

class Archive: UIViewController {
    
    var firstName = "Georgiana"
    var lastName = "Blanda"
    
    var name = "Georgiana Blanda"
    @IBOutlet weak var label11: UILabel!
    
    @IBOutlet weak var label12: UILabel!
    
    @IBOutlet weak var label13: UILabel!
    
    @IBOutlet weak var label21: UILabel!
    
    @IBOutlet weak var label22: UILabel!
    
    @IBOutlet weak var label23: UILabel!
    
    @IBOutlet weak var label31: UILabel!
    
    @IBOutlet weak var label32: UILabel!
    
    @IBOutlet weak var label33: UILabel!
    
    @IBOutlet weak var label41: UILabel!
    
    @IBOutlet weak var label42: UILabel!
    
    @IBOutlet weak var label43: UILabel!
    
    @IBOutlet weak var label51: UILabel!
    
    @IBOutlet weak var label52: UILabel!
    
    @IBOutlet weak var label53: UILabel!
    
    var list:[DailyStruct] = [DailyStruct]()
    
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //self.label51.text = "Hello"
       
        
        get_data("http://www.my6footprint.com/api/v1/users")
        
        
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
                    if let data_emission_history = data_object["emission_history"] as? NSArray {
                        // print(data_emission_history)
                        for i in 0 ..< data_emission_history.count {
                            let data_single_day = data_emission_history[i] as? NSDictionary
                            let data_date = data_single_day!.object(forKey: "date")
                            let data_distance = data_single_day!.object(forKey: "distance")
                            let data_emission = data_single_day!.object(forKey: "emission")
                            list.append(DailyStruct(data_date as! String, data_distance as! Int, data_emission as! Int))
                        }
                        print(list)

                        return
                    }
                }
            }
        }
    }
}

