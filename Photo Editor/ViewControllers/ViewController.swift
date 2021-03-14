//
//  ViewController.swift
//  Photo Editor
//
//  Created by Shivam Rishi on 13/03/21.
//

import UIKit

class ViewController: UIViewController {

    private var viewModels = [FilterViewModel]()
    private var currentOriginalImage:UIImage?
    private var currentFilteredImage:UIImage?
    private var selectedFilterIndex:Int = -1

    private let addOnFiltersView:AddOnFiltersView = {
        let view = AddOnFiltersView()
        view.isHidden = true
        return view
    }()
    
    private let imageView:UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
         return imageView
    }()
    
    private let collectionView:UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                    widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalHeight(1)))
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                             leading: 2,
                                                             bottom: 2,
                                                             trailing: 2)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150),
                                                       heightDimension: .absolute(150)),
                    subitem: item,
                    count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }))
        collectionView.isScrollEnabled = false
        collectionView.isHidden = true
        collectionView.register(DemoFilterCollectionViewCell.self,
                                forCellWithReuseIdentifier: DemoFilterCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let noImageLabel:UILabel = {
        let label = UILabel()
        label.text = "Please choose Photo from top right button"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18,
                                 weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Editor"
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(noImageLabel)
        view.addSubview(collectionView)
        view.addSubview(addOnFiltersView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addOnFiltersView.delegate = self
        
        setupViewModels()
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "photo"),
                            style: .plain,
                            target: self,
                            action: #selector(didTapActionButton)),
            UIBarButtonItem(image: UIImage(systemName: "arrow.down.circle.fill"),
                            style: .plain,
                            target: self,
                            action: #selector(didTapSaveToPhotoLibraryButton))
        ]
        
    }
    
    @objc private func didTapSaveToPhotoLibraryButton() {
        
        guard let image = imageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image,
                                       self,
                                       #selector(image(_:didFinishSavingWithError:contextInfo:)),
                                       nil)
    }

    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        guard error == nil else {
            let alert = UIAlertController(title: "Error",
                                          message: error?.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: nil))
            present(alert,
                    animated: true)
            return
        }
        
        let alert = UIAlertController(title: "Success",
                                      message: "Your image has been saved to photos",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: { [weak self] _ in
                                        DispatchQueue.main.async {
                                            self?.imageView.image = nil
                                            self?.currentOriginalImage = nil
                                            self?.currentFilteredImage = nil
                                            self?.collectionView.isHidden = true
                                            self?.noImageLabel.isHidden = false
                                            self?.addOnFiltersView.isHidden = true
                                        }
                                      }))
        present(alert,
                animated: true)
    }
    
    @objc private func didTapActionButton() {
        let actionSheet = UIAlertController(title: "Choose Photo",
                                            message: "How do you want to add a photo ?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.choosePhotoFromCamera()
                                            }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                self?.choosePhotoFromPhotoLibrary()
                                            }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        present(actionSheet, animated: true)
    }
 
    private func choosePhotoFromCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,
                animated: true)
    }
    
    private func choosePhotoFromPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker,
                animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: view.frame.size.width,
                                 height: (view.frame.size.height-view.safeAreaInsets.top-300))
        
        collectionView.frame = CGRect(x: 0,
                                      y: (imageView.frame.size.height + imageView.frame.origin.y - view.safeAreaInsets.bottom),
                                      width: view.frame.size.width,
                                      height: 150)
        
        addOnFiltersView.frame = CGRect(x: 0,
                                        y: (collectionView.frame.size.height + collectionView.frame.origin.y),
                                        width: view.frame.size.width,
                                        height: (view.frame.size.height-view.safeAreaInsets.top-imageView.frame.size.height-150))
        
        noImageLabel.frame = CGRect(x: 0,
                                    y: 0,
                                    width: view.frame.size.width,
                                    height: 50)
        noImageLabel.center = view.center
        
    }
    
    private func setupViewModels() {
        
        guard let demoImage = UIImage(named: "demo") else {
            return
        }

        viewModels.append(FilterViewModel(image: demoImage.addFilter(filter: .Chrome),
                                          filterType: .Chrome))
        viewModels.append(FilterViewModel(image: demoImage.addFilter(filter: .Fade),
                                          filterType: .Fade))
        viewModels.append(FilterViewModel(image: demoImage.addFilter(filter: .Mono),
                                          filterType: .Mono))
        viewModels.append(FilterViewModel(image: demoImage.addFilter(filter: .Tonal),
                                          filterType: .Tonal))
        viewModels.append(FilterViewModel(image: demoImage.addFilter(filter: .Transfer),
                                          filterType: .Transfer))
        viewModels.append(FilterViewModel(image: demoImage.addFilter(filter: .Noir),
                                          filterType: .Noir))
        
    }
    
    
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,
                       completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,
                       completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        currentOriginalImage = image
        currentFilteredImage = image
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.isHidden = false
            self?.imageView.isHidden = false
            self?.noImageLabel.isHidden = true
            self?.imageView.image = image
            self?.addOnFiltersView.isHidden = false
            self?.addOnFiltersView.blurSlider.value = 0
        }
        
    }
    
 
    
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DemoFilterCollectionViewCell.identifier,
                for: indexPath) as? DemoFilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = viewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let image = currentOriginalImage else {
            return
        }
        
        if selectedFilterIndex != indexPath.row {
            let viewModel = viewModels[indexPath.row]
            selectedFilterIndex = indexPath.row
            DispatchQueue.main.async { [weak self] in
                let filteredImage = image.addFilter(filter: viewModel.filterType)
                self?.currentFilteredImage = filteredImage
                self?.imageView.image = filteredImage
                self?.addOnFiltersView.blurSlider.value = 0
            }
        }
        
        
    }
    
}

extension ViewController:AddOnFiltersViewDelegate{
    
    func addOnFiltersView(_ addOnView: AddOnFiltersView, radius value: Float) {
        
        guard let image = currentFilteredImage else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image.addBlur(radius: value)
        }
    }
}
