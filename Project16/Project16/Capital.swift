//
//  Capital.swift
//  Project16
//
//  Created by Vishrut Vatsa on 10/04/21.
//
import MapKit
import UIKit

class Capital: NSObject,MKAnnotation {

    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
