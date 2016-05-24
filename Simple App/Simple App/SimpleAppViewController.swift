//
//  SimpleAppViewController.swift
//  Simple App
//
//  Created by Admin on 5/24/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class SimpleAppTableViewController: UITableViewController {
    
    var simpleDatas = [Simple]()
    var imageCache: NSCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "SimpleAppTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        // Get Simple data
        self.getSimpleDatas()
        
        // Custom table view
        self.tableView.estimatedRowHeight = 150.0
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Get simple data and append to table view
    func getSimpleDatas() {
        RestApiManager.sharedInstance.getRandomData { (json) in
            if let results = json.array {
                for entry in results {
                    //print(entry["image_url"])
                    self.simpleDatas.append(Simple(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpleDatas.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SimpleAppTableViewCell
        
        // Configure the cell...
        let simpleData = self.simpleDatas[indexPath.row]
        
        // For image caption
        cell.captionLabel.textColor = UIColor.blackColor()
        cell.captionLabel.shadowColor = UIColor.whiteColor()
        cell.captionLabel.text = simpleData.caption
        
        // For default thumbnail image
        cell.thumbnailImageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.thumbnailImageView.image = UIImage(named: "photoalbum")
        
        // Check if the image is stored in cache
        if let imageURL = imageCache.objectForKey(simpleData.id) as? NSURL {
            
            // Get image from cache
            print("Get image from cache")
            cell.thumbnailImageView.contentMode = UIViewContentMode.ScaleAspectFill
            cell.thumbnailImageView.image = UIImage(data: NSData(contentsOfURL: imageURL)!)
            
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                if let url = NSURL(string: simpleData.imageURL) {
                    if let data = NSData(contentsOfURL: url) {
                        
                        cell.captionLabel.textColor = UIColor.whiteColor()
                        cell.captionLabel.shadowColor = UIColor.clearColor()
                        
                        cell.thumbnailImageView.contentMode = UIViewContentMode.ScaleAspectFill
                        cell.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            })
            
        }
        
        // Hide right arrow
        cell.accessoryType = .None
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
