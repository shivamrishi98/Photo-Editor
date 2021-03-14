//
//  AddOnFiltersView.swift
//  Photo Editor
//
//  Created by Shivam Rishi on 14/03/21.
//

import UIKit

protocol AddOnFiltersViewDelegate:AnyObject {
    func addOnFiltersViewBlurEffect(_ addOnView:AddOnFiltersView,radius value:Float)
    func addOnFiltersViewSharpness(_ addOnView:AddOnFiltersView,sharpness value:Float)
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
    
    private let sharpnenTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Sharpen"
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16,
                                 weight: .semibold)
        return label
    }()
    
    let sharpenSlider:UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(blurTitleLabel)
        addSubview(blurSlider)
        addSubview(sharpnenTitleLabel)
        addSubview(sharpenSlider)
        
        blurSlider.addTarget(self,
                             action: #selector(didSlideBlurSlider),
                             for: .valueChanged)
        sharpenSlider.addTarget(self,
                             action: #selector(didSlideSharpenSlider),
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
        
        sharpnenTitleLabel.frame = CGRect(x: blurWidth+5,
                                          y: 5,
                                          width: blurWidth,
                                          height: 20)
        
        sharpenSlider.frame = CGRect(x: blurWidth+5,
                                  y: (sharpnenTitleLabel.frame.size.height + sharpnenTitleLabel.frame.origin.y) + 15,
                                  width: blurWidth-5,
                                  height: 20)
        
    }
    
    @objc private func didSlideBlurSlider(_ slider:UISlider) {
        let value = slider.value * 100
        delegate?.addOnFiltersViewBlurEffect(self,
                                   radius: value)
    }
    
    @objc private func didSlideSharpenSlider(_ slider:UISlider) {
        let value = slider.value
        delegate?.addOnFiltersViewSharpness(self,
                                   sharpness: value)
    }
    
    

}
