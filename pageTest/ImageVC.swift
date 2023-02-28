//
//  ImageVC.swift
//  pageTest
//
//  Created by Oleksandr Smakhtin on 28.02.2023.
//

import UIKit


protocol ImageIndexDelegate: AnyObject {
    func getImageIndex(index: Int)
}

class ImageVC: UIViewController {

    weak var imageDelegate: ImageIndexDelegate?
    
    var index: Int = 0    
    private let catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.catImageView.image = {
            switch index {
            case 0:
                return UIImage(named: "cat1")
            case 1:
                return UIImage(named: "cat2")
            case 2:
                return UIImage(named: "cat3")
            default:
                return UIImage()
            }
        }()
        
        
        addSubviews()
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
