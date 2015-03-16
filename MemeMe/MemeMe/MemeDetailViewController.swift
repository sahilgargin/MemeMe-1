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

    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailImage.image = meme.memedImage

    }

}
