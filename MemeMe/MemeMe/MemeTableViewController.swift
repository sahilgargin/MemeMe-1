//
//  MemeTableViewController.swift
//  imagepicker
//
//  Created by Spiros Raptis on 11/03/2015.
//  Copyright (c) 2015 Spiros Raptis. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController,UITableViewDataSource{
    var memes: [Meme]!
    var plusButton = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = plusButton
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        memes = applicationDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.setEditing(true, animated: true)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        memes = applicationDelegate.memes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("table")
        return memes.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell") as UITableViewCell
        let meme = self.memes[indexPath.row]
        // Set the name and image
        cell.textLabel?.text = meme.topText! + "-" + meme.bottomText!
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as MemeDetailViewController
        detailController.meme   = self.memes[indexPath.row]

        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    //Button Action. Goes to the Edit View to create another meme.
    func anotherMeme(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)//Dismiss the First-root controller. Clean slate next time.
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")! as ViewController
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}