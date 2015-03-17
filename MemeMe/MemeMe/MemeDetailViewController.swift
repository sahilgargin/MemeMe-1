//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by spiros on 3/15/15.
//  Copyright (c) 2015 Spiros Raptis. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController,UINavigationControllerDelegate {
    var meme: Meme!
    var editButton:UIBarButtonItem!
    var deleteButton:UIBarButtonItem!
    var flexiblespace:UIBarButtonItem!
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flexiblespace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "editMeme")
        deleteButton = UIBarButtonItem(title: "Delete", style: .Done, target: self, action: "deleteMeme")
        

        self.navigationItem.rightBarButtonItems = [editButton,deleteButton]

        self.detailImage.image = meme.memedImage

    }
    
    func editMeme(){
        
    }
    
    func deleteMeme(){
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        applicationDelegate.memes.removeLast()

        
        //            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)//Dismiss the First-root controller. Clean slate next time.
        self.navigationController?.popViewControllerAnimated(true)
        
        //        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")! as ViewController
//
//        self.navigationController!.presentViewController(detailController, animated: true, completion: nil)
    }

}
