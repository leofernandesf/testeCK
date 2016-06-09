//
//  AlunoViewController.swift
//  AulaCloudKit
//
//  Created by leonardo fernandes farias on 06/06/16.
//  Copyright © 2016 leonardo fernandes farias. All rights reserved.
//

import UIKit

class AlunoViewController: UIViewController {

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
        if segue.identifier == "detalheAluno" {
            let viewController:DetalheAlunoViewController = segue.destinationViewController as! DetalheAlunoViewController
            viewController.nome = "ANTONIO"
        }
    }

}


extension AlunoViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell2")
        
        return cell!
        
    }
    
}


extension AlunoViewController : UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detalheAluno", sender: self)
    }
}