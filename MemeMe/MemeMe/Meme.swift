//
//  Meme.swift
//  imagepicker
//  The class that will hold the Meme with it's attributes: Top Text,BottomText,Image,and generated image
//  Created by Spiros Raptis on 11/03/2015.
//  Copyright (c) 2015 Spiros Raptis. All rights reserved.
//

import Foundation
import UIKit

// 1. Import CoreData
import CoreData

// 2. Make Person available to Objective-C code
@objc(Meme)

class Meme: NSManagedObject{
    @NSManaged var topText:String!
    @NSManaged var bottomText:String!
    @NSManaged var image: UIImage! //Original Image
    @NSManaged var memedImage: UIImage! //The generated image with Top and bottom text.

    // 5. Include this standard Core Data init method.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    
    init(let topText:String,let bottomText:String, let image:UIImage, let memedImage:UIImage,context: NSManagedObjectContext){
        // Get the entity associated with the "Person" type.  This is an object that contains
        // the information from the Model.xcdatamodeld file. We will talk about this file in
        // Lesson 4.
        let entity =  NSEntityDescription.entityForName("Meme", inManagedObjectContext: context)!
        
        // Now we can call an init method that we have inherited from NSManagedObject. Remember that
        // the Person class is a subclass of NSManagedObject. This inherited init method does the
        // work of "inserting" our object into the context that was passed in as a parameter
        super.init(entity: entity,insertIntoManagedObjectContext: context)

        
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
    
}