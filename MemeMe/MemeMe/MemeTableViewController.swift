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
        
        super.viewDidLoad()
        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = plusButton
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        memes = applicationDelegate.memes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func anotherMeme(){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")! as ViewController
//        self.navigationController?.popToViewController(controller, animated: true)
//        println(self.navigationController?.viewControllers)

        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
}