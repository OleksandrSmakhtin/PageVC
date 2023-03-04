//
//  ImageVC.swift
//  pageTest
//
//  Created by Oleksandr Smakhtin on 28.02.2023.
//

import UIKit
import CoreImage

//MARK: - ImageIndexDelegate protocol
protocol ImageIndexDelegate: AnyObject {
    // we use this method to track imageVCs' indexs in PageVC
    func getImageIndex(index: Int)
}

class ImageVC: UIViewController {

    //MARK: - Delegates
    weak var imageDelegate: ImageIndexDelegate?

    //MARK: - Index
    // uses when creating instances to provide necessary images
    var index: Int = 0
    
    //MARK: - filter selector
    // uses for change filters
    var filterSelector = 0
    
    //MARK: - Context for filter
    let context = CIContext()
        
    
    
    
    //MARK: - UI Objects
     var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure image depending from setted index
        catImageView.image = UIImage(named: "cat\(index)")
        // add subviews
        addSubviews()
    }
    
    
    
    //MARK: - Apply filter
    func applyFilter() {

        let inputImage = CIImage(image: UIImage(named: "cat\(index)")!)
        
        
        if filterSelector == 0 {
            let edgesFilter = CIFilter(name:"CIEdges")
            edgesFilter?.setValue(inputImage, forKey: kCIInputImageKey)
            edgesFilter?.setValue(0.9, forKey: kCIInputIntensityKey)
            let edgesCIImage = edgesFilter?.outputImage
            let cgOutputImage = context.createCGImage(edgesCIImage!, from: inputImage!.extent)
            
            catImageView.image = UIImage(cgImage: cgOutputImage!)
            filterSelector += 1
            
        } else {
            
            let filter = CIFilter(name: "CIColorInvert")
            filter!.setValue(inputImage, forKey: kCIInputImageKey)
            let grayscaleCIImage = filter?.outputImage
            let cgOutputImage = context.createCGImage(grayscaleCIImage!, from: inputImage!.extent)
            
            catImageView.image = UIImage(cgImage: cgOutputImage!)
            filterSelector -= 1
        }
    }
    
    
    
    //MARK: - Disable filter
    func disableFilter() {
        catImageView.image = UIImage(named: "cat\(index)")
    }
    
    
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // compile when view is configured and going to be shown
        // calls delegate method in PageVC because we conform it when creates instances
        imageDelegate?.getImageIndex(index: index)
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        catImageView.frame = view.bounds
    }
    
    //MARK: - Get Instance
    static func getInstance(index: Int, object: ImageIndexDelegate) -> ImageVC {
        // creating an instance of ImageVC
        let vc = ImageVC()
        // set index
        vc.index = index
        // conform object to protocol
        vc.imageDelegate = object
        return vc
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        view.addSubview(catImageView)
    }
    

}


