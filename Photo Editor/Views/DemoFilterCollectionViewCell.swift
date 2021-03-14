//
//  CustomCollectionViewCell.swift
//  Photo Editor
//
//  Created by Shivam Rishi on 13/03/21.
//

import Foundation
import UIKit

final class DemoFilterCollectionViewCell:UICollectionViewCell {
    static let identifier = "DemoFilterCollectionViewCell"
    
    private let titleLabel:UILabel = {
         let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = . systemFont(ofSize: 12,
                                  weight: .thin)
         return label
    }()
    
    private let imageView:UIImageView = {
         let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
         return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
        titleLabel.frame = CGRect(x: 2,
                                  y: (frame.size.height + frame.origin.y) - 15,
                                  width: frame.size.width-4,
                                  height: 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
   
     func configure(with viewModel:FilterViewModel) {
        titleLabel.text = viewModel.filterType.title
        imageView.image = viewModel.image
    }
    
}
