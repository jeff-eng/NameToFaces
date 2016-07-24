//
//  Person.swift
//  Project10
//
//  Created by Jeffrey Eng on 7/24/16.
//  Copyright © 2016 Jeffrey Eng. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    // We need the initializer here since the properties 'name' and 'image' were declared and cannot be empty
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
