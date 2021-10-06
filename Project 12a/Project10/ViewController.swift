//
//  ViewController.swift
//  Project10
//
//  Created by TwoStraws on 17/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var people = [Person]()

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return people.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell

		let person = people[indexPath.item]

		cell.name.text = person.name

		let path = getDocumentsDirectory().appendingPathComponent(person.image)
		cell.imageView.image = UIImage(contentsOfFile: path.path)

		cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
		cell.imageView.layer.borderWidth = 2
		cell.imageView.layer.cornerRadius = 3
		cell.layer.cornerRadius = 7

		return cell
	}

	@objc func addNewPerson() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.originalImage] as? UIImage else { return }

		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
			try? jpegData.write(to: imagePath)
		}

		let person = Person(name: "Unknown", image: imageName)
		people.append(person)
		collectionView?.reloadData()

		dismiss(animated: true)
        
	}

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let person = people[indexPath.item]

		let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
		ac.addTextField()

		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

		ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
			let newName = ac.textFields![0]
			person.name = newName.text!
            self.save()
			self.collectionView?.reloadData()
		})

		present(ac, animated: true)
	}
    let acd = UIAlertController(title: "Do you want to delete this item or rename it?",message: nil, preferredStyle: .alert)
    func acd;.addAction(UIAlertAction(title: "DELETE",style: .destructive) {[weak self] _ in
    self?.people.remove(at:indexPath.row)
    self?.collectionView.reloadData()
    })
    acd.addAction(UIAlertAction(title: "Rename", style: .default, handler: renameAlert))
    acd.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present (acd, animated: true)

    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        }
    }
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
}
