//
//  EditorViewController
//  imagepicker
//
//  Created by Spiros Raptis on 09/03/2015.
//  Copyright (c) 2015 Spiros Raptis. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!

    var cameraButton = UIBarButtonItem()
    var flexiblespace = UIBarButtonItem()
    var pickImageButton = UIBarButtonItem()
    var shareButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    
    var memedImage = UIImage()
    let tapRec = UITapGestureRecognizer()
    var meme:Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        var fixedWidth = self.view.frame.size.width;
        var fixedHeight = self.view.frame.size.height;
        
        self.navigationController?.view.backgroundColor = UIColor.whiteColor() //When zooming the background should be white.
        
        bottomTextField.sizeToFit()
        tapRec.addTarget(self, action: "tapped")
        tapRec.delegate = self
        view.addGestureRecognizer(tapRec)

        pickImageButton = UIBarButtonItem(title: "Album", style: .Done, target: self, action: "pickAnImage:")
        cameraButton = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "pickAnImageFromCamera:")
        shareButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "share")
        cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        flexiblespace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
      
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!, //Uses Custom Impact font.
            NSStrokeWidthAttributeName : -3
        ]
        
        topTextField.backgroundColor = UIColor.clearColor()
        bottomTextField.backgroundColor = UIColor.clearColor()
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        if(!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            cameraButton.enabled = false
        }
    }
    
    //For Image croping
    @IBAction func scaleImage(sender: UIPinchGestureRecognizer) {
        self.imagePickerView.transform = CGAffineTransformScale(self.imagePickerView.transform, sender.scale, sender.scale)
        sender.scale = 1

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //get the current meme for editing purposes
        let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        self.meme = applicationDelegate.editorMeme


        self.navigationItem.leftBarButtonItem = shareButton
        topTextField.text = meme.topText
        bottomTextField.text = meme.bottomText
        imagePickerView.image = meme.image
        
        //if an image was selected then enable the share button
        if(imagePickerView.image?.size == UIImage().size){
            shareButton.enabled = false
        }else{
            shareButton.enabled = true
        }

        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = cancelButton
        self.toolbarItems = [flexiblespace,cameraButton,flexiblespace,pickImageButton,flexiblespace]
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
            meme.image = image
            meme.topText = self.topTextField.text
            meme.bottomText = self.bottomTextField.text
        }

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Dismiss the Image Picker on Cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //After the enter is pressed at we dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.isEqual(bottomTextField){
            self.unsubscribeFromKeyboardNotifications()
        }
        return true
    }
    //At the begining of Editing if the default text is written We reset it
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
        if textField.isEqual(bottomTextField){
            self.subscribeToKeyboardNotifications()
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    //TODO:Optimize. make theee two one function
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func generateMemedImage() -> UIImage {
        
        //Hide toolbar and navbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        return memedImage
    }

    func save() {
        //Create the meme
        memedImage = generateMemedImage()
        var meme = Meme(topText:topTextField.text!, bottomText: bottomTextField.text!,  image: imagePickerView.image!,  memedImage: memedImage)
        self.meme = meme
        (UIApplication.sharedApplication().delegate as AppDelegate).memes.append(meme)
        
    }
    
    func share(){
        save()
        let objectsToShare = [UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypeSaveToCameraRoll]
        let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activity.completionWithItemsHandler = { (activity, success, items, error) in
                let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeTabBarController")! as MemeTabBarController
            
//            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)//Dismiss the First-root controller. Clean slate next time.
            self.navigationController!.presentViewController(detailController, animated: true, completion: nil)

            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.setToolbarHidden(true, animated: false)
            
            //Reset Editor View.
            let applicationDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
            applicationDelegate.editorMeme = Meme(topText: "TOP", bottomText: "BOTTOM", image: UIImage(), memedImage: UIImage())
            
        }

        self.presentViewController(activity, animated: true, completion:nil)

    }
    
    func tapped(){
        println("tapped")
    }
    
    func cancel(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)//Dismiss the First-root controller.
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeTabBarController")! as MemeTabBarController
        self.navigationController?.presentViewController(detailController, animated: true,completion:nil)
    }
    
}