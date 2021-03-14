//
//  Extensions.swift
//  Photo Editor
//
//  Created by Shivam Rishi on 13/03/21.
//

import Foundation
import UIKit

extension UIImage {
    
    static let ciContext = CIContext()
    
    func addFilter(filter: FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)
        
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput,
                         forKey: "inputImage")
        
        if let ciOutput = filter?.outputImage {
            if let cgImage = UIImage.ciContext.createCGImage(ciOutput,
                                                             from: (ciOutput.extent)){
                return UIImage(cgImage: cgImage)
            }
        }
        
        return self
    }
    
    func addBlur(radius value:Float) -> UIImage {
        let filter = CIFilter(name: "CIBoxBlur")
        
        let ciInput = CIImage(image: self)
        
        filter?.setValue(ciInput,
                         forKey: "inputImage")
        filter?.setValue(value,
                         forKey: "inputRadius")
        
        if let ciOutput = filter?.outputImage, let ciInput = ciInput  {
            
            if let cgImage = UIImage.ciContext.createCGImage(ciOutput,
                                                             from: (ciInput.extent)){
                return UIImage(cgImage: cgImage)
            }
        }
        
        return self
    }
    
}
