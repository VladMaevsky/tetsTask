//
//  ImageCollectionViewCell.swift
//  Project3
//
//  Created by Vlad Maevsky on 16.09.21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    let cornerRadius: CGFloat = 7
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
        override func layoutSubviews() {
            super.layoutSubviews()
            imageView.layer.cornerRadius = cornerRadius
        }
}
