//
//  PhotosTableViewController.swift
//  jsonplaceholder
//
//  Created by Dmitriy Egorov on 06/12/16.
//  Copyright © 2016 antonson10. All rights reserved.
//

import UIKit
import Foundation

class PhotosTableViewController: UITableViewController {
    //var myArray = [String]()
    var myArray = [AnyObject]()
    var smallPhotosImagesArray = [UIImage]()
    let cellIdentifier = "photosCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadData()
    }
    
    func loadData()
    {
        myArray.removeAll()
        smallPhotosImagesArray.removeAll()
        //myArray = ["azaza", "ololo"]
        
        let url = NSURL.init(string: "https://jsonplaceholder.typicode.com/photos")!
        if let data = NSData(contentsOfURL: url)
        {
            do {
                let anyObj = try NSJSONSerialization.JSONObjectWithData(data, options: [])// as! [String: AnyObject]
                //print(anyObj)
                print(anyObj[0])
                print(anyObj[2])
                var i = 0
                while i < 10
                {
                    myArray.append(anyObj[i])
                    let curObj = anyObj[i] as! [String: AnyObject]
                    let smallPhotoStr = curObj["thumbnailUrl"] as! String
                    let separatedString = smallPhotoStr.componentsSeparatedByString("/")
                    let backGround = separatedString[4]
                    let size = separatedString[3]
                    let newString = "https://placeholdit.imgix.net/~text?txtsize=14&bg=" + backGround + "&txt=" + size + "&w=" + size + "&h=" + size
                    let smallPhotoUrl = NSURL.init(string: newString)!
                    /*https://placeholdit.imgix.net/~text?txtsize=56&bg=24f355&txt=600×600&w=600&h=600*/
                    if let imageData = NSData(contentsOfURL: smallPhotoUrl)
                    {
                        smallPhotosImagesArray.append(UIImage(data: imageData)!)
                    }
                    i += 1
                }
            } catch {
                print("json error: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentObject = myArray[indexPath.row] as! [String: AnyObject]
        let currentTitle = currentObject["title"] as! String
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PhotosTableViewCell
        cell.label.text = currentTitle
        /*let smallPhotoStr = currentObject["thumbnailUrl"] as! String
        let smallPhotoUrl = NSURL.init(string: smallPhotoStr)!
        if let imageData = NSData(contentsOfURL: smallPhotoUrl)
        {
            cell.thumbnailPhoto.image = UIImage(data: imageData)!
        }*/
        cell.thumbnailPhoto.image = smallPhotosImagesArray[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"
        {
            if let selectedPhoto = sender as? PhotosTableViewCell
            {
                let indexPath = tableView.indexPathForCell(selectedPhoto)!
                let obj = myArray[indexPath.row]
                let nav = segue.destinationViewController as! UINavigationController
                let destVC = nav.topViewController as! DetailViewController
                destVC.currentPhoto = obj
                print("Opening...")
            }
        }
    }
    

}
