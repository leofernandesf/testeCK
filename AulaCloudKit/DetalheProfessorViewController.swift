//
//  DetalheProfessorViewController.swift
//  AulaCloudKit
//
//  Created by leonardo fernandes farias on 06/06/16.
//  Copyright © 2016 leonardo fernandes farias. All rights reserved.
//

import UIKit
import CloudKit
let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
class DetalheProfessorViewController: UIViewController {
    
    @IBOutlet weak var ivImagem: UIImageView!
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfIdade: UITextField!
    @IBOutlet weak var tfProfissao: UITextField!
    @IBOutlet weak var myTable: UITableView!
    var record:CKRecord?
    var nome = ""
    var verificador:Bool!
    let recognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if record != nil {
            tfNome.text = record?.objectForKey("nome") as? String
            tfIdade.text = record!["idade"] as? String
            tfProfissao.text = record!["profissao"] as? String
            if let asset = record!["foto"] as? CKAsset {
                let url = asset.fileURL
                let imagemData = NSData(contentsOfFile: url.path!)!
                let image = UIImage(data: imagemData)
                ivImagem.image = image
            }
            
        }
        ivImagem.userInteractionEnabled = true
        recognizer.addTarget(self, action: #selector(DetalheProfessorViewController.profileImageHasBeenTapped))
        
        ivImagem.addGestureRecognizer(recognizer)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func acao(sender: AnyObject) {
        var professor:CKRecord!
        if record == nil {
            professor = CKRecord(recordType: "Professor")
        } else {
            professor = record
        }
        
        professor["nome"] = tfNome.text
        professor["idade"] = tfIdade.text
        professor["profissao"] = tfProfissao.text
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
    
    
    func profileImageHasBeenTapped() {
        
        let alert:UIAlertController = UIAlertController(title: "Choose Image",
                                                        message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) { UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel) { UIAlertAction in
            
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func openCamera() {
        let picker = UIImagePickerController()
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
        }
        else {
            openGallery()
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

}

extension DetalheProfessorViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        print("testando a foto: \(image)")
        let imagem:UIImage = image
        ivImagem.image = image
        print("testando a image: \(imagem)")
        //let imageData = UIImagePNGRepresentation(image)
        
        
    }
    
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