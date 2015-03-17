//
//  MemeTabBarController.swift
//  MemeMe
//
//  Created by spiros on 14/3/15.
//  Copyright (c) 2015 Spiros Raptis. All rights reserved.
//

import UIKit

class MemeTabBarController: UITabBarController {
    var plusButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()

//            self.navigationController?.setNavigationBarHidden(false, animated: true)
        plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "anotherMeme")
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = plusButton
        
        self.toolbarItems = [plusButton]
    }
    override func viewWillAppear(animated: Bool) {

    }
    func anotherMeme(){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController")! as ViewController
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
         
    }

}