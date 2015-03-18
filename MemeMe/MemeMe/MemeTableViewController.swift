//
//  MemeTableViewController.swift
//  imagepicker
//
//  Created by Spiros Raptis on 11/03/2015.
//  Copyright (c) 2015 Spiros Raptis. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController,UITableViewDataSource{
    var memes: [Meme]!
    var plusButton = UIBarButtonItem()
    var editButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "edit")

        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = plusButton
        self.navigationItem.leftBarButtonItem = editButton
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        memes = applicationDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        memes = applicationDelegate.memes
        self.editing = false
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("table")
        return memes.count
    }

    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true}

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("tableViewCell") as UITableViewCell
        let meme = self.memes[indexPath.row]
        // Set the name and image
        cell.textLabel?.text = meme.topText! + "-" + meme.bottomText!
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")! as MemeDetailViewController
        
        detailController.meme   = self.memes[indexPath.row]

        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = memes[fromIndexPath.row]
        memes.removeAtIndex(fromIndexPath.row)
        memes.insert(itemToMove, atIndex: toIndexPath.row)
    }
    
    //Button Action. Goes to the Edit View to create another meme.
    func anotherMeme(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)//Dismiss the First-root controller. Clean slate next time.
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")! as ViewController
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        memes.removeAtIndex(indexPath.row)

        applicationDelegate.memes = memes
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func edit(){
        self.editing = !self.editing
    }
    
}