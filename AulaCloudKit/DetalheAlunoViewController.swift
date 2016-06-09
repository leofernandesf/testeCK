//
//  DetalheAlunoViewController.swift
//  AulaCloudKit
//
//  Created by leonardo fernandes farias on 06/06/16.
//  Copyright © 2016 leonardo fernandes farias. All rights reserved.
//

import UIKit

class DetalheAlunoViewController: UIViewController {
    @IBOutlet weak var ivImagem: UIImageView!
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfIdade: UITextField!
    @IBOutlet weak var tfProfissa: UITextField!
    @IBOutlet weak var myTable: UITableView!
    var nome = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNome.text = nome
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

}


extension DetalheAlunoViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell4")
        
        
        return cell!
        
    }
    
}


extension DetalheAlunoViewController : UITableViewDelegate {
    
    
    
}