////
////  TestViewController.swift
////  Photo Editor
////
////  Created by Shivam Rishi on 14/03/21.
////
//
//import UIKit
//
//class TestFilterViewController: UIViewController {
//    
//    let sepiaSharpenBlurImageView: UIImageView = {
//        let v = UIImageView()
//        v.contentMode = .scaleAspectFit
//        return v
//    }()
//    
//    let sepiaBlurSharpenImageView: UIImageView = {
//        let v = UIImageView()
//        v.contentMode = .scaleAspectFit
//        return v
//    }()
//
//    let sepiaSharpenBlurLabel = UILabel()
//    let sepiaBlurSharpenLabel = UILabel()
//    
//    var origImage: UIImage!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = . systemBackground
//        guard let img = UIImage(named: "demo") else {
//            fatalError("Could not load image!!!")
//        }
//        origImage = img
//        
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.distribution = .fill
//        stack.spacing = 8
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        stack.addArrangedSubview(sepiaSharpenBlurLabel)
//        stack.addArrangedSubview(sepiaSharpenBlurImageView)
//        stack.addArrangedSubview(sepiaBlurSharpenLabel)
//        stack.addArrangedSubview(sepiaBlurSharpenImageView)
//
//        let promptLabel = UILabel()
//        promptLabel.textAlignment = .center
//        promptLabel.text = "Tap Anywhere"
//        stack.addArrangedSubview(promptLabel)
//        
//        view.addSubview(stack)
//        
//        let g = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            stack.centerXAnchor.constraint(equalTo: g.centerXAnchor),
//            stack.centerYAnchor.constraint(equalTo: g.centerYAnchor),
//
//            stack.heightAnchor.constraint(equalTo: g.heightAnchor, multiplier: 0.9),
//            sepiaSharpenBlurImageView.widthAnchor.constraint(equalTo: sepiaSharpenBlurImageView.heightAnchor),
//            sepiaBlurSharpenImageView.widthAnchor.constraint(equalTo: sepiaBlurSharpenImageView.heightAnchor),
//        ])
//
//        [sepiaSharpenBlurLabel, sepiaBlurSharpenLabel, promptLabel].forEach {
//            $0.setContentCompressionResistancePriority(.required, for: .vertical)
//        }
//        
//        sepiaSharpenBlurImageView.image = origImage
//        sepiaBlurSharpenImageView.image = origImage
//        
//        updateLabels()
//    }
//    
//    var step: Int = 0
//    
//    func updateLabels() -> Void {
//        switch step {
//        case 0:
//            sepiaSharpenBlurLabel.text = "Orig"
//            sepiaBlurSharpenLabel.text = "Orig"
//        case 1:
//            if let t = sepiaSharpenBlurLabel.text {
//                sepiaSharpenBlurLabel.text = t + "; Sepia"
//            }
//            if let t = sepiaBlurSharpenLabel.text {
//                sepiaBlurSharpenLabel.text = t + "; Sepia"
//            }
//        case 2:
//            if let t = sepiaSharpenBlurLabel.text {
//                sepiaSharpenBlurLabel.text = t + "; Sharpen"
//            }
//            if let t = sepiaBlurSharpenLabel.text {
//                sepiaBlurSharpenLabel.text = t + "; Blur"
//            }
//        case 3:
//            if let t = sepiaSharpenBlurLabel.text {
//                sepiaSharpenBlurLabel.text = t + "; Blur"
//            }
//            if let t = sepiaBlurSharpenLabel.text {
//                sepiaBlurSharpenLabel.text = t + "; Sharpen"
//            }
//        default:
//            ()
//        }
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let imgA = sepiaBlurSharpenImageView.image,
//              let imgB = sepiaSharpenBlurImageView.image
//        else {
//            fatalError("Image View has no image!!!!")
//        }
//        switch step {
//        case 0:
//            let newImageA = imgA.addSepiaFilter()
//            sepiaBlurSharpenImageView.image = newImageA
//            let newImageB = imgB.addSepiaFilter()
//            sepiaSharpenBlurImageView.image = newImageB
//        case 1:
//            let newImageA = imgA.addBlur(radius: 20.0)
//            sepiaBlurSharpenImageView.image = newImageA
//            let newImageB = imgB.adjustSharpness(sharpness: 20.0)
//            sepiaSharpenBlurImageView.image = newImageB
//        case 2:
//            let newImageA = imgA.adjustSharpness(sharpness: 20.0)
//            sepiaBlurSharpenImageView.image = newImageA
//            let newImageB = imgB.addBlur(radius: 20.0)
//            sepiaSharpenBlurImageView.image = newImageB
//        default:
//            sepiaSharpenBlurImageView.image = origImage
//            sepiaBlurSharpenImageView.image = origImage
//            step = -1
//        }
//        step += 1
//        updateLabels()
//    }
//}
//
//extension UIImage {
//    
//    static let ciContext = CIContext()
//
//    // what is FilterType ??
////    func addFilter(filter: FilterType) -> UIImage {
////        let filter = CIFilter(name: filter.rawValue)
////
////        let ciInput = CIImage(image: self)
////        filter?.setValue(ciInput,
////                         forKey: "inputImage")
////
////        if let ciOutput = filter?.outputImage {
////            if let cgImage = UIImage.ciContext.createCGImage(ciOutput,
////                                                             from: (ciOutput.extent)){
////                return UIImage(cgImage: cgImage)
////            }
////        }
////
////        return self
////    }
//    func addSepiaFilter() -> UIImage {
//        let filter = CIFilter(name: "CISepiaTone")
//        
//        let ciInput = CIImage(image: self)
//        filter?.setValue(ciInput,
//                         forKey: "inputImage")
//        
//        if let ciOutput = filter?.outputImage {
//            if let cgImage = UIImage.ciContext.createCGImage(ciOutput,
//                                                             from: (ciOutput.extent)){
//                return UIImage(cgImage: cgImage)
//            }
//        }
//        
//        return self
//    }
//    
//    func addBlur(radius value:Float) -> UIImage {
//        let filter = CIFilter(name: "CIBoxBlur")
//        
//        let ciInput = CIImage(image: self)
//        
//        filter?.setValue(ciInput,
//                         forKey: "inputImage")
//        filter?.setValue(value,
//                         forKey: "inputRadius")
//        
//        if let ciOutput = filter?.outputImage, let ciInput = ciInput  {
//            
//            if let cgImage = UIImage.ciContext.createCGImage(ciOutput,
//                                                             from: (ciInput.extent)){
//                return UIImage(cgImage: cgImage)
//            }
//        }
//        
//        return self
//    }
//    
//    func adjustSharpness(sharpness value:Float) -> UIImage {
//        let filter = CIFilter(name: "CISharpenLuminance")
//        
//        let ciInput = CIImage(image: self)
//        
//        filter?.setValue(ciInput,
//                         forKey: "inputImage")
//        filter?.setValue(value,
//                         forKey: "inputSharpness")
//        
//        if let ciOutput = filter?.outputImage, let ciInput = ciInput  {
//            
//            if let cgImage = UIImage.ciContext.createCGImage(ciOutput,
//                                                             from: (ciInput.extent)){
//                return UIImage(cgImage: cgImage)
//            }
//        }
//        
//        return self
//    }
//    
//}
