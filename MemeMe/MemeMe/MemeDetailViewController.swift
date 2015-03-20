//
//  MemeDetailViewController.swift
//  MemeMe
//  The detail view. It displays the memed image when the users selects the saved memes from
//  table view or collection view.
//  Created by spiros on 3/15/15.
//  Copyright (c) 2015 Spiros Raptis. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController,UINavigationControllerDelegate {
    var meme: Meme!
    var editButton:UIBarButtonItem!
    var deleteButton:UIBarButtonItem!
    var flexiblespace:UIBarButtonItem! // For viewing purposes only
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //The button of the navigation controller
        flexiblespace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "editMeme")
        deleteButton = UIBarButtonItem(title: "Delete", style: .Done, target: self, action: "deleteMeme")

        self.navigationItem.rightBarButtonItems = [editButton,deleteButton]

        self.detailImage.image = meme.memedImage

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit"{
            if let a = segue.destinationViewController as? EditorViewController{
                let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
                applicationDelegate.editorMeme = self.meme // the editor meme is updated so when we go back to Editor View we display the selected meme to edit
                }
            }
    }
    
    //Edit Meme: It goes back to the Edit view screen to edit the meme.
    func editMeme(){
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("edit", sender: self)
    }
    //Deletes the meme
    func deleteMeme(){
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        applicationDelegate.memes.removeLast()

        self.navigationController?.popViewControllerAnimated(true)
        
    }

}
