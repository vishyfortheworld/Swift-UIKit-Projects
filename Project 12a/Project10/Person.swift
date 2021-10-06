//
//  Person.swift
//  Project10
//
//  Copyright © 2020 Vishrut Vatsa. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
	var name: String
	var image: String

	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
    
    required init?(coder aDecoder: NSCoder) {
        //reading things out of diisk
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeBool(forKey: "image") as? String ?? ""
    }
    func encode(with aCoder: NSCoder) {
        //writing things inside of disk
        aCoder.encode(name, forKey: "mame")
        aCoder.encode(name, forKey: "image")
    }
    
}

