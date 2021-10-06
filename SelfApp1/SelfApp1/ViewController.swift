//
//  ViewController.swift
//  SelfApp1
//
//  Created by Vishrut Vatsa on 11/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
      
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        
        for item in items {
            
            if item.hasPrefix("flags") {
                pictures.append(item)
            }
        }
        
        print(pictures)
    }


}

