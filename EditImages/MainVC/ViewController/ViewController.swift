//
//  ViewController.swift
//  EditImages
//
//  Created by developer on 8/19/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblFile: UITableView!
    
    
    var arrFile = NSArray()
    var arrFileDic = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decoration()
        self.readJsonFile()
    }

    func decoration(){
          self.tblFile.register(UINib(nibName: "FilesTableViewCell", bundle: nil), forCellReuseIdentifier: "FilesTableViewCell")
    }
    
    func readJsonFile(){
        do {
            if let file =  Bundle.main.url(forResource: "FiileJson", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    print("json data =",object)
                    arrFile = (json as! NSDictionary).value(forKey: "jsonRead") as! NSArray
                } else if let object = json as? [Any] {
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
         self.arrFileDic = self.arrFile[0] as! NSDictionary //[String:Any]
    }
    
    
    
   


}


extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrFileDic = self.arrFile[0] as!  NSDictionary//[String:Any]
        let attachment = arrFileDic["attatchmentFiles"] as! NSArray
        return attachment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblFile.dequeueReusableCell(withIdentifier: "FilesTableViewCell") as! FilesTableViewCell
        let attendanceList = self.arrFileDic["attatchmentFiles"]  as! NSArray
        let singleAttendanceList =  attendanceList[indexPath.row] as! NSDictionary//[String:Any]
        let filename: NSString = singleAttendanceList["atta"] as! NSString
        let pathExtention = filename.pathExtension
        if(pathExtention == "pdf"){
            cell.imgRef.image = #imageLiteral(resourceName: "pdffile")
        }
        else if(pathExtention == "ppt"){
            
            cell.imgRef.image = #imageLiteral(resourceName: "pptfile")
            
        }
        cell.lblFileName.text = NSURL(fileURLWithPath: (singleAttendanceList["atta"] as? String)!).lastPathComponent!
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            let attachmentList = self.arrFileDic["attatchmentFiles"]  as! NSArray
            let singleFileAttachment =  attachmentList[indexPath.row] as! [String:Any]
            let showFileVC = self.storyboard?.instantiateViewController(withIdentifier: "OpenFileViewController") as! OpenFileViewController
            showFileVC.fiilePath = singleFileAttachment["atta"] as! String
            self.navigationController?.pushViewController(showFileVC, animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}

