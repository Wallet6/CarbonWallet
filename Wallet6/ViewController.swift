//
//  ViewController.swift
//  Wallet6
//
//  Created by Danny Peng on 1/20/18.
//  Copyright © 2018 Danny Peng. All rights reserved.
//

import UIKit
import UICircularProgressRing


class ViewController: Archive{
    @IBOutlet weak var ProgressRing: UICircularProgressRingView!
    
    @IBOutlet weak var ArchiveButton: UIButton!
    
    @IBOutlet weak var Welcome: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ProgressRing.value = 9
        Welcome.text = "Welcome " + firstName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

