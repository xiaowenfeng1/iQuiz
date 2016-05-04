//
//  ViewController.swift
//  iQuiz
//
//  Created by Xiaowen Feng on 5/1/16.
//  Copyright © 2016 Xiaowen Feng. All rights reserved.
//

import UIKit
//import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     @IBOutlet weak var tableView: UITableView!
    
    @IBAction func Setting(sender: UIBarButtonItem) {
        let setting = UIAlertController(title: "Settings goes here", message: "OK", preferredStyle: UIAlertControllerStyle.Alert)
        setting.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(setting, animated: true, completion: nil)
    }
    
    var subjects : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    var subjectsDescr : [String] = ["Quiz for your math skills", "Test your super heros knowledge", "All about science"]
    var images = ["mathImage", "heroImage", "scienceImage"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel?.text = subjectsDescr[indexPath.row]
        let image = images[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(image)")!
        return cell
        
    }

   

}

