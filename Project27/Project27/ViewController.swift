//
//  ViewController.swift
//  Project27
//
//  Created by Vishrut Vatsa on 16/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
 
    
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        drawRectangle()
        
    }
    
    func drawRectangle() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let img = renderer.image{ctx in
        // drawing code
            
            let rectangle = CGRect(x:5, y:5, width: 502, height: 502)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            
            
    }
        
        imageView.image = img
        
    }

    @IBAction func redrawTapped(_ sender: Any) {
        
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
            
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        
        default:
            break
        }
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

           let img = renderer.image { ctx in
               let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)

               ctx.cgContext.setFillColor(UIColor.red.cgColor)
               ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
               ctx.cgContext.setLineWidth(10)

               ctx.cgContext.addEllipse(in: rectangle)
               ctx.cgContext.drawPath(using: .fillStroke)
           }

           imageView.image = img
    }
    
    
    
}

