//
//  PageVC.swift
//  pageTest
//
//  Created by Oleksandr Smakhtin on 28.02.2023.
//

import UIKit
import CoreImage

//MARK: - PageControllDelegate
protocol PageControlDelegate: AnyObject {
    // use this method in MainVC to track of the index of vc that is shown and change page control
    func changePage(to index: Int)
}


class PageVC: UIPageViewController {
    
    // delegate
    weak var pageControlDelegate: PageControlDelegate?
        
    // array for images VCs
    private var imagesVCs = [ImageVC]()
    
    // holds the current index of vc that is shown
    var currentInx = 0
        

    override func viewDidLoad() {
        super.viewDidLoad()
        // change bg
        view.backgroundColor = .systemBackground
        
        // set UIPageViewControllerDataSource
        self.dataSource = self
              
        // get instances
        imagesVCs = [
            ImageVC.getInstance(index: 0, object: self),
            ImageVC.getInstance(index: 1, object: self),
            ImageVC.getInstance(index: 2, object: self)
        ]
        
        // set first vc
        setViewControllers([imagesVCs[0]], direction: .forward, animated: true)
    }
    
    //MARK: - Change to next
    func changeToNext() {
        // use this method to change vc by tapping a btn
        if currentInx == imagesVCs.count - 1 {
            return
        } else {
            currentInx += 1
            setViewControllers([imagesVCs[currentInx]], direction: .forward, animated: true)
        }
    }
    
    
    //MARK: - Change to previous
    func changeToPrev() {
        // use this method to change vc by tapping a btn
        if currentInx == 0 {
            return
        } else {
            currentInx -= 1
            setViewControllers([imagesVCs[currentInx]], direction: .reverse, animated: true)
        }
    }
    
    //MARK: -
    func changeFilter() {
        imagesVCs[currentInx].applyFilter()
    }
    
    //MARK: - Disable filter
    func disableFilter() {
        imagesVCs[currentInx].disableFilter()
    }
    

}


//MARK: - ImageIndexDelegate
extension PageVC: ImageIndexDelegate {
    // calls when each imageVC is shown
    func getImageIndex(index: Int) {
        // use pageControlDelegate method to send current index to MainVC
        pageControlDelegate?.changePage(to: index)
        // change currentInx value
        currentInx = index
    }
}


//MARK: - UIPageViewConstrollerDataSource
extension PageVC: UIPageViewControllerDataSource {
    
    
    // defines which of VCs is before the actual VC
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentIndex = imagesVCs.firstIndex(of: viewController as! ImageVC)!
        if currentIndex == 0 {
            return nil
        } else {
            return imagesVCs[currentIndex - 1]
        }
    }
    
    // defines which of VCs is after the actual VC
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                
        let currentIndex = imagesVCs.firstIndex(of: viewController as! ImageVC)!
        if currentIndex == imagesVCs.count - 1 {
            return nil
        } else {
            return imagesVCs[currentIndex + 1]
        }
    }
}

