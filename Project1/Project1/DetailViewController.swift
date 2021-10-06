//
//  DetailViewController.swift
//  Project1
//
//  Created by Vishrut Vatsa on 10/27/20.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedPictureNumber = 0
    var totalPictures = 0
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        title = "This image is \(String(describing: selectedImage))"
        navigationItem.largeTitleDisplayMode = .never
        
        
        
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
}
