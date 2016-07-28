//
//  Person.swift
//  Project10
//
//  Created by Jeffrey Eng on 7/24/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    // We need the initializer here since the properties 'name' and 'image' were declared and cannot be empty
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    // Using the required keyword so that if this Person class is subclassed, this method needs to be implemented. This initializer is used when loading objects of this class. This method is needed to conform to the NSCoding protocol
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        image = aDecoder.decodeObjectForKey("image") as! String
    }
    
    // Used when saving objects of this class. This method is required in order to conform to the NSCoding protocol
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(image, forKey: "image")
    }
}
