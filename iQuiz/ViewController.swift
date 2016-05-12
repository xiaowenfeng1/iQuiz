//
//  ViewController.swift
//  iQuiz
//
//  Created by Xiaowen Feng on 5/1/16.
//  Copyright © 2016 Xiaowen Feng. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var quizzes : [Quiz] = []
   // var rawData : [Dictionary <String, AnyObject>] = []
    var newQuiz : [AnyObject] = []
   // var json : NSArray?
    var urlText = "https://tednewardsandbox.site44.com/questions.json" //self.urlInput.text!
    var reload : Bool = false

    
    
    @IBOutlet weak var tableView: UITableView!
    
   // @IBOutlet weak var urlField: UILabel!
    
   // @IBAction func getQuizzes(sender: AnyObject) {
        
   // }
    
   
    @IBAction func Setting(sender: UIBarButtonItem) {
    }
    
    var images = ["mathImage", "heroImage", "scienceImage"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       getData()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJSON(newQuiz: [AnyObject]) -> [Quiz] {
        var curQuizzes = [Quiz]()

        
            for quiz in newQuiz {
                    let title = quiz["title"] as! String
                    let desc = quiz["desc"] as!  String
                    let questions = quiz["questions"] as! [AnyObject]
                
                    let curQuiz = Quiz(title: "\(title)", desc: "\(desc)", questions: [])
                    
                    for q in questions as! [NSDictionary]{
                        let text = q["text"] as! String
                        let answer = q["answer"] as! String
                        let answers = q["answers"] as! [String]
                    
                        let newQuestion = Question(question: text, answer: answer, answers:  answers)
                        curQuiz.questions.append(newQuestion)
                    }
                    
                    curQuizzes.append(curQuiz)
             
            }
        return curQuizzes
    }
 
  
      func getData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let savedQuiz = defaults.arrayForKey("savedQuiz")
        
        if (savedQuiz!.count == 0 || reload) {

        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        
        let url = NSURL(string: urlText)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            let statusCode = (response as! NSHTTPURLResponse).statusCode
            
            if (statusCode != 200) {
            print("URL Session Task Failed: HTTP \(statusCode)")
           
            } else {
                print("URL Session Task Successed")
                do {
                    self.newQuiz = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [AnyObject]
                    
                    defaults.setObject(self.newQuiz, forKey: "savedQuiz")
                
                
                    dispatch_async(dispatch_get_main_queue(), {
                        self.quizzes = self.parseJSON(self.newQuiz)
                
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                    })
                })
                
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)" )
                
                }
            }
        }
        
       task.resume()
            
        } else { //local storage is available
            print("using local data")
           dispatch_async(dispatch_get_main_queue(), {
                let data = defaults.arrayForKey("savedQuiz")
                self.quizzes = self.parseJSON(data!)
                
               dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
            })

        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.quizzes.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
     
        cell.textLabel?.text = self.quizzes[indexPath.row].title
        cell.detailTextLabel?.text = self.quizzes[indexPath.row].desc
        let label = (cell.textLabel?.text)!
        
        switch label {
        case "Mathematics":
            cell.imageView?.image = UIImage(named: "mathImage")
            
        case "Marvel Super Heroes":
            cell.imageView?.image = UIImage(named: "heroImage")
            
        case "Science!":
            cell.imageView?.image = UIImage(named: "scienceImage")
            
        default:
            break
        }
        
        return cell
    }
    
    
    // Settings button, user can input a url link to fetch a quiz
    @IBAction func alert(sender: UIBarButtonItem) {
        let alertController = UIAlertController.init(title: "Settings", message: "Update JSON File", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title:"Cancel", style:.Default) {(action) in };
        alertController.addAction(cancelAction)
        
        let updateAction = UIAlertAction(title:"Update", style:.Default, handler: {
            alert -> Void in
            self.urlText = alertController.textFields![0].text!
            self.reload = true
            self.getData()
            self.setNeedsFocusUpdate()
        })
        
        alertController.addAction(updateAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.text = "https://tednewardsandbox.site44.com/questions.json"
        }
        
        alertController.view.setNeedsLayout()
        self.presentViewController(alertController, animated: true) {
        }
        
    }

    // send data to the question viewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuestion" {
            let displayQuestion: QuestionViewController = segue.destinationViewController as! QuestionViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let quiz = quizzes[indexPath.row]
                displayQuestion.quiz = quiz
            }
        }
        
    }
 
}


