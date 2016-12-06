//
//  PhotosTableViewCell.swift
//  jsonplaceholder
//
//  Created by Dmitriy Egorov on 06/12/16.
//  Copyright © 2016 antonson10. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    //MARK: Properties

    
    @IBOutlet weak var thumbnailPhoto: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
