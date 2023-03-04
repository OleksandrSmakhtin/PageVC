//
//  MainVC.swift
//  pageTest
//
//  Created by Oleksandr Smakhtin on 28.02.2023.
//

import UIKit


class MainVC: UIViewController {

    
    
    // track index of imageVC
    private var pageIndex = 0
    
    
    //MARK: - UI Objects
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let filterBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .label
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 7
        btn.setTitle("BLACK & WHITE", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let prevBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .label
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 7
        btn.setTitle("PREV", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let nextBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .label
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 7
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "CATS GALLERY"
        label.textColor = .label
        label.font = UIFont(name: "Avenir Next Bold", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pageVC: PageVC = {
        let vc = PageVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bg color
        view.backgroundColor = .systemBackground
        // add subviews
        addSubviews()
        // apply constraints
        applyConstraints()
        // add targets for btns
        addTargets()
        // set delegate for pageVC
        pageVC.pageControlDelegate = self
    }
    
    //MARK: - Add targets
    private func addTargets() {
        // next action
        nextBtn.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        // prev action
        prevBtn.addTarget(self, action: #selector(prevAction), for: .touchUpInside)
        // apply filter action
        filterBtn.addTarget(self, action: #selector(changeFilterAction), for: .touchUpInside)
        // create tap gesture recognizer to detect double taps
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(disableFilterAction))
        // set required taps
        doubleTap.numberOfTapsRequired = 2
        // add gesture to filter btn
        filterBtn.addGestureRecognizer(doubleTap)
    }
    
    // next action
    @objc private func nextAction() {
        pageVC.changeToNext()
    }
    // prev action
    @objc private func prevAction() {
        pageVC.changeToPrev()
    }
    // filter action
    @objc private func changeFilterAction() {
        pageVC.changeFilter()
    }
    // double tap action
    @objc private func disableFilterAction() {
        pageVC.disableFilter()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        // page VC as a child
        addChild(pageVC)
        // add it's view as a subview
        view.addSubview(pageVC.view)
        view.addSubview(titleLbl)
        view.addSubview(prevBtn)
        view.addSubview(nextBtn)
        view.addSubview(filterBtn)
        view.addSubview(pageControl)
    }
    
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        
        let titleLblConstraints = [
            titleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let pageVCConstraints = [
            pageVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageVC.view.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 50),
            pageVC.view.heightAnchor.constraint(equalToConstant: 350),
            pageVC.view.widthAnchor.constraint(equalToConstant: 350)
        ]
        
        
        let prevBtnConstraints = [
            prevBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            prevBtn.topAnchor.constraint(equalTo: pageVC.view.bottomAnchor, constant: 50),
            prevBtn.heightAnchor.constraint(equalToConstant: 60),
            prevBtn.widthAnchor.constraint(equalToConstant: 130)
        ]
        
        let nextBtnConstraints = [
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            nextBtn.topAnchor.constraint(equalTo: pageVC.view.bottomAnchor, constant: 50),
            nextBtn.heightAnchor.constraint(equalToConstant: 60),
            nextBtn.widthAnchor.constraint(equalToConstant: 130)
        ]
        
        let colorBtnConstraints = [
            filterBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            filterBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            filterBtn.heightAnchor.constraint(equalToConstant: 60),
            filterBtn.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 40)
        ]
        
        let pageControlConstraints = [
            pageControl.topAnchor.constraint(equalTo: pageVC.view.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(pageVCConstraints)
        NSLayoutConstraint.activate(prevBtnConstraints)
        NSLayoutConstraint.activate(nextBtnConstraints)
        NSLayoutConstraint.activate(colorBtnConstraints)
        NSLayoutConstraint.activate(pageControlConstraints)
    }

}

//MARK: - PageControlDelegate
extension MainVC: PageControlDelegate {
    func changePage(to index: Int) {
        pageControl.currentPage = index
        pageIndex = index
    }
    
}
