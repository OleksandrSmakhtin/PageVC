//
//  ImageVC.swift
//  pageTest
//
//  Created by Oleksandr Smakhtin on 28.02.2023.
//

import UIKit
import CoreImage


protocol ImageIndexDelegate: AnyObject {
    func getImageIndex(index: Int)
}

protocol FilterDelegate: AnyObject {
    func changeFilter()
}


class ImageVC: UIViewController {

    weak var imageDelegate: ImageIndexDelegate?
    weak var filterDelegate: FilterDelegate?

    
    var index: Int = 0
    
    
     var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat0")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catImageView.image = UIImage(named: "cat\(index)")
            
        
        addSubviews()
    }
    
    
    
    func applyFilter() {
        
            let startImage = CIImage(image: UIImage(named: "cat\(index)")!)
            let filter = CIFilter(name: "CIColorInvert")
            filter?.setValue(startImage, forKey: kCIInputImageKey)
            let newImage = UIImage(ciImage: (filter?.outputImage)!)
            self.catImageView.image = newImage

    }
    
    func disableFilter() {
        catImageView.image = UIImage(named: "cat\(index)")
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageDelegate?.getImageIndex(index: index)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        catImageView.frame = view.bounds
    }
    
    
    static func getInstance(index: Int, object: ImageIndexDelegate) -> ImageVC {
        
        let vc = ImageVC()
        vc.index = index
        vc.imageDelegate = object
        
        return vc
        
    }
    
    
    private func addSubviews() {
        view.addSubview(catImageView)
    }
    

}






extension ImageVC: TestDelegate {
    func testFunc() {
        print("DEBIL SUKA")
    }
    
    
}
