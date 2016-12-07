//
//  ViewController.swift
//  jsonplaceholder
//
//  Created by Dmitriy Egorov on 06/12/16.
//  Copyright © 2016 antonson10. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var currentPhoto:AnyObject?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bigImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let photo = currentPhoto
        {
            let curPhoto = photo as! [String: AnyObject]
            let currentTitle = curPhoto["title"] as! String
            titleLabel.text = currentTitle
            
            let currentId = curPhoto["id"] as! Int
            navigationItem.title = "Photo \(currentId)"
            let bigPhotoStr = curPhoto["url"] as! String
            let separatedString = bigPhotoStr.componentsSeparatedByString("/")
            let backGround = separatedString[4]
            let size = separatedString[3]
            let newString = "https://placeholdit.imgix.net/~text?txtsize=56&bg=" + backGround + "&txt=" + size + "&w=" + size + "&h=" + size
            let bigPhotoUrl = NSURL.init(string: newString)!
            /*https://placeholdit.imgix.net/~text?txtsize=56&bg=24f355&txt=600×600&w=600&h=600*/
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                let fetchedData = NSData(contentsOfURL: bigPhotoUrl)
                dispatch_async(dispatch_get_main_queue(), {
                    if let imageData = fetchedData
                    {
                        self.bigImage.image = UIImage(data: imageData)
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    }
                })
            })
            /*if let imageData = NSData(contentsOfURL: bigPhotoUrl)
            {
                bigImage.image = UIImage(data: imageData)!
            }*/
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func backToPhotosList(sender: UIBarButtonItem) {
        let presentedModally = presentingViewController is UINavigationController
        if presentedModally
        {
            dismissViewControllerAnimated(true, completion: {})
        }

    }
}

