//
//  DetalheAlunoViewController.swift
//  AulaCloudKit
//
//  Created by leonardo fernandes farias on 06/06/16.
//  Copyright © 2016 leonardo fernandes farias. All rights reserved.
//

import UIKit
import CloudKit
class DetalheAlunoViewController: UIViewController {
    @IBOutlet weak var ivImagem: UIImageView!
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfIdade: UITextField!
    @IBOutlet weak var tfProfissa: UITextField!
    @IBOutlet weak var myTable: UITableView!
    var nome = ""
    var record:CKRecord?
    var records = [CKRecord]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if record != nil {
            tfNome.text = record?.objectForKey("nome") as? String
            tfIdade.text = record?.objectForKey("idade") as? String
            tfProfissa.text = record?.objectForKey("cargo") as? String
            
            if let asset = record!["foto"] as? CKAsset {
                let url = asset.fileURL
                let imagemData = NSData(contentsOfFile: url.path!)!
                let image = UIImage(data: imagemData)
                ivImagem.image = image
            }
            fetch()
        }
        
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
    @IBAction func acao(sender: AnyObject) {
        var professor:CKRecord!
        if record == nil {
            professor = CKRecord(recordType: "Aluno")
        } else {
            professor = record
        }
        
        professor["nome"] = tfNome.text
        professor["idade"] = tfIdade.text
        professor["cargo"] = tfProfissa.text
        professor["title"] = tfNome.text
        
        let imageURL = NSURL(fileURLWithPath: NSTemporaryDirectory().stringByAppendingString("Temp.png"))
        UIImagePNGRepresentation(ivImagem.image!)?.writeToURL(imageURL, atomically: true)
        let asset = CKAsset(fileURL: imageURL)
        professor["foto"] = asset
        publicDatabase.saveRecord(professor) { (record, error) in
            if error == nil {
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.navigationController?.popViewControllerAnimated(true)
                })
                print("salvou")
            } else {
                print(error?.description)
            }
        }
    }
    
    func fetch() {
        var referencias = [CKReference]()
        referencias = record!["professor"] as! [CKReference]
        
        var idsArray = Array<CKRecordID>()
        for ids in referencias {
            idsArray.append(ids.recordID)
        }
        print(idsArray)
        
        let fetchRecordOperation = CKFetchRecordsOperation(recordIDs: idsArray)
        fetchRecordOperation.perRecordProgressBlock = {
            print($1)
        }
        
        fetchRecordOperation.perRecordCompletionBlock = {record, recordID, error in
            if error != nil {
                
            } else {
                print("voltou")
                self.records.append(record!)
                self.myTable.reloadData()
            }
        }
        fetchRecordOperation.database = CKContainer.defaultContainer().publicCloudDatabase
        fetchRecordOperation.start()
        
    }


}


extension DetalheAlunoViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell4")
        cell?.textLabel?.text = records[indexPath.row]["nome"] as? String
        
        return cell!
        
    }
    
}


extension DetalheAlunoViewController : UITableViewDelegate {
    
    
    
}