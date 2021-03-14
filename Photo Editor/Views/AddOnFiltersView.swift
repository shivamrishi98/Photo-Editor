//
//  AddOnFiltersView.swift
//  Photo Editor
//
//  Created by Shivam Rishi on 14/03/21.
//

import UIKit

protocol AddOnFiltersViewDelegate:AnyObject {
    func addOnFiltersView(_ addOnView:AddOnFiltersView,radius value:Float)
}

class AddOnFiltersView: UIView {

    weak var delegate:AddOnFiltersViewDelegate?
    
    private let blurTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Blur"
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16,
                                 weight: .semibold)
        return label
    }()
    
    let blurSlider:UISlider = {
        let slider = UISlider()
        
        return slider
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(blurTitleLabel)
        addSubview(blurSlider)
        
        blurSlider.addTarget(self,
                             action: #selector(didSlideBlurSlider),
                             for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let blurWidth = frame.size.width/2
        blurTitleLabel.frame = CGRect(x: 5,
                                      y: 5,
                                      width: blurWidth,
                                      height: 20)
        
        blurSlider.frame = CGRect(x: 5,
                                  y: (blurTitleLabel.frame.size.height + blurTitleLabel.frame.origin.y) + 15,
                                  width: blurWidth,
                                  height: 20)
    }
    
    @objc private func didSlideBlurSlider(_ slider:UISlider) {
        let value = slider.value * 100
        delegate?.addOnFiltersView(self,
                                   radius: value)
    }
    
    

}
