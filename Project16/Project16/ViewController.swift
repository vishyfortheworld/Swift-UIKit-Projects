//
//  ViewController.swift
//  Project16
//
//  Created by Vishrut Vatsa on 10/04/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "Londom", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago")
        
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 12.5), info: "Has a whole country inside it.")
        
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895, longitude: -77.036667), info: "Named after George himself")
        
        let delhi = Capital(title: "Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.71025), info: "The national capital of India")
        
        let agra = Capital(title: "Agra", coordinate: CLLocationCoordinate2D(latitude: 27.1751, longitude: 78.0421), info: "The home to one of the 7 wonders, The Taj Mahal")
        
        
        mapView.addAnnotation(london)
        mapView.addAnnotation(oslo)
        mapView.addAnnotation(paris)
        mapView.addAnnotation(washington)
        mapView.addAnnotation(delhi)
        mapView.addAnnotation(agra)
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView? {
        
        //1
        guard annotation is Capital else { return nil }
        
        //2
        let identifier = "Capital"

        //3
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            //5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            //6
            annotationView?.annotation = annotation
        }
            
        return annotationView
            
        }
    
    func mapView(_ mapView:MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
        
        
    }
    


}

