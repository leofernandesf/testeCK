//
//  ProfessorViewController.swift
//  AulaCloudKit
//
//  Created by leonardo fernandes farias on 06/06/16.
//  Copyright © 2016 leonardo fernandes farias. All rights reserved.
//

import UIKit
import CloudKit


class ProfessorViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    var recordEscolhido:CKRecord!
    var refresh: UIRefreshControl!
    var recordArray = [CKRecord]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.tableFooterView = UIView(frame: CGRectZero)
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "pull to reload")
        refresh.addTarget(self, action: #selector(ProfessorViewController.query), forControlEvents: .ValueChanged)
        self.myTable.addSubview(refresh)
        query()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func query() {
        let query = CKQuery(recordType: "Professor", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        publicDatabase.performQuery(query, inZoneWithID: nil) { (record, error) in
            if error == nil {
                print(record?.count)
                self.recordArray = record!
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.myTable.reloadData()
                    self.refresh.endRefreshing()
                    //self.loadData()
                })
                
            }
        }
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
            viewController.record = recordEscolhido
        }
    }

}


extension ProfessorViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let record = recordArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1")
        cell?.textLabel?.text = record.objectForKey("nome") as? String
        cell?.detailTextLabel?.text = record.objectForKey("profissao") as? String
        
        cell?.imageView?.image = UIImage(named: "icon-profile")
        
        return cell!
        
    }
    
}


extension ProfessorViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        recordEscolhido = recordArray[indexPath.row]
        performSegueWithIdentifier("detalheProfessor", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            publicDatabase.deleteRecordWithID(recordArray[indexPath.row].recordID, completionHandler: { (record, error) in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.recordArray.removeAtIndex(indexPath.row)
                    self.myTable.reloadData()
                    
                })
            })
            
        }
    }
    
}
