//
//  ViewController.swift
//  Project15
//
//  Created by Vishrut Vatsa on 29/03/21.
//

import UIKit

class ViewController: UIViewController {

    
    var imageView: UIImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        imageView = UIImageView(image: UIImage(named:"penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
        
    }
    
    
//    When the method begins, we hide the sender button so that our animations don't collide; it gets unhidden in the completion closure of the animation.
//    We call animate(withDuration:) with a duration of 1 second, no delay, and no interesting options.
//    For the animations closure we don’t need to use [weak self] because there’s no risk of strong reference cycles here – the closures passed to animate(withDuration:) method will be used once then thrown away.
//    We switch using the value of self.currentAnimation. We need to use self to make the closure capture clear, remember. This switch/case does nothing yet, because both possible cases just call break.
//    We use trailing closure syntax to provide our completion closure. This will be called when the animation completes, and its finished value will be true if the animations completed fully.
//    As I said, the completion closure unhides the sender button so it can be tapped again.
//    After the animate(withDuration:) call, we have the old code to modify and wrap currentAnimation
    
    
    @IBAction func tapped(_ sender: UIButton) {
        
      
        
        sender.isHidden = true
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
            case 1:
                self.imageView.transform = .identity
                //identity resets all the visual changes
            
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                
            case 3:
                self.imageView.transform = .identity
                
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                
            case 5:
                self.imageView.transform = .identity
                
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = UIColor.green
                
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = UIColor.clear
            
            default:
                break
            }
        }) { finished in
            sender.isHidden = false
        }
        
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}

