//
//  ViewController.swift
//  Project12
//
//  Created by Vishrut Vatsa on 11/01/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "Use FaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Vishrut", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Vishrut", "Country": "India"]
        defaults.set(dict, forKey: "SavedDict")
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UseFaceId")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        
        let savedDictionary = defaults.object(forKey: "SavedDict") as? [String:String] ?? [String:String]()
        
        
    }


}


