//
//  ViewController.swift
//  JsonData
import Foundation
import UIKit
import Dispatch

class Archive: UIViewController {
    
    var name = "Dr. Jonathan Prosacco"
    
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

        
//        var label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        label.center = CGPoint(x: 160, y: 240)
//        label.textAlignment = NSTextAlignment.center
//        label.text = "I'am a test label"
//        self.view.addSubview(label)
        

        DispatchQueue.main.async {
            self.get_data("http://www.my6footprint.com/api/v1/users")
            
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "artboard_1_1024.png")
            backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)

        }
       
        //get_data("http://www.my6footprint.com/api/v1/users")
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
                        DispatchQueue.main.sync {
                            self.label11.text = self.list[4].date
                            self.label21.text = self.list[3].date
                            self.label31.text = self.list[2].date
                            self.label41.text = self.list[1].date
                            self.label51.text = self.list[0].date
                            
                            self.label12.text = String(self.list[4].distance)
                            self.label22.text = String(self.list[3].distance)
                            self.label32.text = String(self.list[2].distance)
                            self.label42.text = String(self.list[1].distance)
                            self.label52.text = String(self.list[0].distance)
                            
                            self.label13.text = String(self.list[4].emission)
                            self.label23.text = String(self.list[3].emission)
                            self.label33.text = String(self.list[2].emission)
                            self.label43.text = String(self.list[1].emission)
                            self.label53.text = String(self.list[0].emission)

                        }
                        return

                    }
                }
            }
        }
    }
    

}

