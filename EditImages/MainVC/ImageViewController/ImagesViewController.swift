//
//  ImagesViewController.swift
//  EditImages
//
//  Created by developer on 8/19/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

     var arrImageNameList = [String]()
    @IBOutlet weak var collviewImages: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decoration()
    }
    
    func decoration(){
          self.collviewImages.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesCollectionViewCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.collviewImages.reloadData()
        self.getAllImages()
    }
    
    func getAllImages(){
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            // if you want to filter the directory contents you can do like this:
            let mp3Files = directoryContents.filter{ $0.pathExtension == "png" }
            // let mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
            let mp3FileNames = mp3Files.map{ $0.lastPathComponent }
            self.arrImageNameList.removeAll()
            for i in 0..<mp3FileNames.count{
                self.arrImageNameList.append(mp3FileNames[i])
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    //Mark:  Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collviewImages.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        cell.layer.cornerRadius = 10.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.masksToBounds = true
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(self.arrImageNameList[indexPath.row])
        //let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(self.arrImageNameList[indexPath.row])
        if fileManager.fileExists(atPath: imagePAth){
            cell.imgRef.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
        }
        return cell
    }
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:(collectionView.frame.size.width/3) - 20, height:150)
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    

}
