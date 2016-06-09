//
//  ProfessorViewController.swift
//  AulaCloudKit
//
//  Created by leonardo fernandes farias on 06/06/16.
//  Copyright © 2016 leonardo fernandes farias. All rights reserved.
//

import UIKit

class ProfessorViewController: UIViewController {
    var index:Int!
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: CGRectZero)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func add(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detalheProfessor" {
            let viewController:DetalheProfessorViewController = segue.destinationViewController as! DetalheProfessorViewController
            viewController.nome = "ANTONIO"
        }
    }

}


extension ProfessorViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1")
        cell?.textLabel?.text = "Antonio"
        cell?.detailTextLabel?.text = "Developer"
        
        cell?.imageView?.image = UIImage(named: "icon-profile")
        
        return cell!
        
    }
    
}


extension ProfessorViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("detalheProfessor", sender: self)
    }
    
}