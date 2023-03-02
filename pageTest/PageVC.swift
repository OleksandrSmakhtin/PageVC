//
//  PageVC.swift
//  pageTest
//
//  Created by Oleksandr Smakhtin on 28.02.2023.
//

import UIKit
import CoreImage


enum Filters: String {
    case white = "CIColorInvert"
    case black = "CIPixellate"
}


protocol PageControlDelegate: AnyObject {
    func changePage(to index: Int)
}

protocol TestDelegate: AnyObject {
    func testFunc()
}


class PageVC: UIPageViewController {
    
    weak var pageControlDelegate: PageControlDelegate?
    weak var testDelegate: TestDelegate?
        
    private var imagesVCs = [UIViewController]()
    
    var currentInx = 0
    
    var filterName = Filters.black
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        self.delegate = self
        self.dataSource = self
        
                
        
        imagesVCs = [
            ImageVC.getInstance(index: 0, object: self),
            ImageVC.getInstance(index: 1, object: self),
            ImageVC.getInstance(index: 2, object: self)
        ]
        
//        for imageVC in imagesVCs {
//            guard let vc = imageVC as? ImageVC else { return }
//            self.testDelegate = vc
//        }
        
        setViewControllers([imagesVCs[0]], direction: .forward, animated: true)
    }
    
    func changeToNext() {
        if currentInx == imagesVCs.count - 1 {
            return
        } else {
            currentInx += 1
            setViewControllers([imagesVCs[currentInx]], direction: .forward, animated: true)
        }
    }
    
    func changeToPrev() {
        if currentInx == 0 {
            return
        } else {
            currentInx -= 1
            setViewControllers([imagesVCs[currentInx]], direction: .reverse, animated: true)
        }
    }
    
    
    func changeFilter() {
        
        testDelegate?.testFunc()
        
        
        guard let vc = imagesVCs[currentInx] as? ImageVC else { return }
        vc.applyFilter()
        

    }
    
    
    func disableFilter() {
        guard let vc = imagesVCs[currentInx] as? ImageVC else { return }
        vc.disableFilter()
    }
    

}

extension PageVC: ImageIndexDelegate {
    func getImageIndex(index: Int) {
        
        pageControlDelegate?.changePage(to: index)
        print(index)
        currentInx = index
        
        
    }
    
    
}




extension PageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = imagesVCs.firstIndex(of: viewController)!
        
        if currentIndex == 0 {
            return nil
        } else {
            return imagesVCs[currentIndex - 1]
        }
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                
        let currentIndex = imagesVCs.firstIndex(of: viewController)!
        
        if currentIndex == imagesVCs.count - 1 {
            return nil
        } else {
            return imagesVCs[currentIndex + 1]
        }
        
        
    }
    
    
}


extension PageVC: UIPageViewControllerDelegate {
    
//    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return imagesVCs.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
}
