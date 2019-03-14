//
//  OpenFileViewController.swift
//  EditImages
//
//  Created by developer on 8/19/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit
import iOSPhotoEditor

class OpenFileViewController: UIViewController,UIWebViewDelegate,PhotoEditorDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    
    @IBOutlet weak var contentWebView: UIWebView!
    var fiilePath = String()
    @IBOutlet weak var btnCrop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnCrop.layer.cornerRadius = btnCrop.frame.size.width/2
        btnCrop.clipsToBounds = true
        btnCrop.layer.borderWidth=2.0
        btnCrop.layer.borderColor=UIColor.white.cgColor
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        var websiteURL:URL?
        websiteURL = URL(string: fiilePath)
        if(websiteURL != nil){
            contentWebView.loadRequest(URLRequest(url: websiteURL!))
        }
    }
    
    
//    func webViewDidStartLoad(_ webView: UIWebView)
//    {
//        ZKProgressHUD.show()
//    }
//    func webViewDidFinishLoad(_ webView: UIWebView)
//    {
//        ZKProgressHUD.dismiss()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        contentWebView.loadHTMLString("<html><body></body></html>", baseURL: nil)
        
    }
//
//    //MARK:-- Button Action
//    @IBAction func click_BackVC(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func click_CapScreenShot(_ sender: Any) {
        self.btnCrop.isHidden = true
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
        photoEditor.photoEditorDelegate = self
        photoEditor.image = image
        
        //Colors for drawing and Text, If not set default values will be used
        //photoEditor.colors = [.red, .blue, .green]
        //Stickers that the user will choose from to add on the image
        //        for i in 0...10 {
        //            photoEditor.stickers.append(UIImage(named: i.description)!) //
        //        }
        //To hide controls - array of enum control
        //photoEditor.hiddenControls = [.crop, .draw, .share]
        
        self.present(photoEditor, animated: true, completion: nil)
        
        //        UIGraphicsEndImageContext()
        //        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        //        let alert = UIAlertController(title: "", message: "Successfully !", preferredStyle: UIAlertControllerStyle.alert)
        //        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //        self.present(alert, animated: true, completion: nil)
        self.btnCrop.isHidden = false
    }
    
    
    
    
    func doneEditing(image: UIImage) {
//        let getDetail:NSDictionary = UserDefaults.standard.value(forKey: "userDetails") as! NSDictionary
//        let userId = getDetail.value(forKey: "userId")!
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd_MM_yyyy_HH:MM:SS"
        let result = formatter.string(from: date)
        // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "EditImages_\(result).png"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = UIImageJPEGRepresentation(image, 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
        
    }
    
    
    func canceledEditing() {
        print("cancel editing")
    }

   

}
