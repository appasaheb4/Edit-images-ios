//
//  FilesTableViewCell.swift
//  EditImages
//
//  Created by developer on 8/19/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

class FilesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgRef: UIImageView!
    @IBOutlet weak var lblFileName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
