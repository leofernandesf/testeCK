//
//  DetalheProfessorViewController.swift
//  AulaCloudKit
//
//  Created by leonardo fernandes farias on 06/06/16.
//  Copyright © 2016 leonardo fernandes farias. All rights reserved.
//

import UIKit

class DetalheProfessorViewController: UIViewController {

    @IBOutlet weak var ivImagem: UIImageView!
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfIdade: UITextField!
    @IBOutlet weak var tfProfissao: UITextField!
    @IBOutlet weak var myTable: UITableView!
    var nome = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNome.text = nome
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acao(sender: AnyObject) {
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


extension DetalheProfessorViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell3")
        cell?.textLabel?.text = "Antonio"
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Alunos"
    }

}


extension DetalheProfessorViewController : UITableViewDelegate {
    
    
    
}