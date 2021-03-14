//
//  FilterViewModel.swift
//  Photo Editor
//
//  Created by Shivam Rishi on 13/03/21.
//

import Foundation
import UIKit

enum FilterType:String {
    case Sepia = "CISepiaTone"
    case Chrome = "CIPhotoEffectChrome"
    case Fade = "CIPhotoEffectFade"
    case Mono = "CIPhotoEffectMono"
    case Tonal = "CIPhotoEffectTonal"
    case Transfer = "CIPhotoEffectTransfer"
    case Noir = "CIPhotoEffectNoir"
    
    var title:String {
        switch self {
        
        case .Sepia:
            return "Sepia"
        case .Chrome:
            return "Chrome"
        case .Fade:
            return "Fade"
        case .Mono:
            return "Mono"
        case .Tonal:
            return "Tonal"
        case .Transfer:
            return "Transfer"
        case .Noir:
            return "Noir"
            
        }
    }
}


struct FilterViewModel {
    let image:UIImage
    let filterType:FilterType
}
