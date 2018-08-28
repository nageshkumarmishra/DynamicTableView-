//
//  DataTableViewCell.swift
//  DynamicCellHeight
//
//  Created by Nagesh on 17/06/18.
//  Copyright © 2018 Nagesh Kumar Mishra. All rights reserved.
//

import UIKit
import SDWebImage

let kPhotoWidthConstraint: CGFloat = 70
let kPhotoWidthConstraintZero: CGFloat = 0

let kPlaceholder = "placeholder-image"

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var photoWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // If images are failed to download reset the Constraint to zero and dont display them in the tableview.
    func handleImages(rows: Rows)  {
        
        if rows.imageHref != nil {
            self.photoView.sd_setImage(with: URL(string: rows.imageHref!)) { (image, error, cache, urls) in
                if (error == nil) {
                    self.photoView.image = image
                    self.photoWidthConstraint.constant = kPhotoWidthConstraint
                    
                } else {
                    
                    // Handel images which are uable to download from the server
                    print(error.debugDescription)
                    self.photoView.image = nil
                    self.photoWidthConstraint.constant = kPhotoWidthConstraintZero
                }
            }
        } else {
            // If image url itself is empty
            self.photoView.image = nil
            self.photoWidthConstraint.constant = kPhotoWidthConstraintZero
        }
        
    }
    
    
    // Set Tablecells data
    func setData(rows: Rows)  {
        
        self.titleLabel.text = rows.title ?? "N/A"
        self.descriptionLabel.text = rows.description ?? "N/A"
        self.handleImages(rows: rows)
        
    }
}
