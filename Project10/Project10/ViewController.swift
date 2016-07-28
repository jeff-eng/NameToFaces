//
//  ViewController.swift
//  Project10
//
//  Created by Jeffrey Eng on 7/22/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewPerson))
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Load people array back from disk when app runs
        if let savedPeople = defaults.objectForKey("people") as? NSData {
            people = NSKeyedUnarchiver.unarchiveObjectWithData(savedPeople) as! [Person]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Person", forIndexPath: indexPath) as! PersonCell
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().stringByAppendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path)
        
        cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let person = people[indexPath.item]
        
        // Create instance of UIAlertController with a text field
        let ac = UIAlertController(title: "Rename this person", message: nil, preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        
        // Cancel action
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        // Confirm changes action and assign the text from text field to the Person object's name property
        ac.addAction(UIAlertAction(title: "OK", style: .Default) { [unowned self, ac] _ in
            let newName = ac.textFields![0]
            person.name = newName.text!
            
            // Reload the collection view with the updated information from user
            self.collectionView.reloadData()
            
            // Saves data to NSUserDefaults using the save method
            self.save()
        })
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func addNewPerson() {
        // Create new instance of UIImagePickerController which lets users select image from camera
        let picker = UIImagePickerController()
        // Set allowsEditing property to true to allow user to crop selected image
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        // Retrieve value with key UIImagePickerControllerEditedImage from dictionary passed in and optionally type cast as UIImage
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            newImage = possibleImage
        } else {
            return
        }
        
        let imageName = NSUUID().UUIDString
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
        
        // UIImageJPEGRepresentation turns the UIImage(the newImage variable) into an NSData object with specified quality and safely unwrap it using 'if let'
        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            // Write to the unique file name created earlier
            jpegData.writeToFile(imagePath, atomically: true)
        }
        
        // Creates new instance of Person object and adds it to the people array, then reload collection view
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func save() {
        // Converts the people array into an NSData object
        let savedData = NSKeyedArchiver.archivedDataWithRootObject(people)
        //Saves that data object to NSUserDefaults
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(savedData, forKey: "people")
    }
}

