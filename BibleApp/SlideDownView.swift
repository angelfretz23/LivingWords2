//
//  SlideDownView.swift
//  BibleApp
//
//  Created by Ostap Romaniv on 4/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

class SlideDownView: NSObject, UITabBarDelegate {
    
    let blackView = UIView()
    let navBar = UINavigationBar()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.lightGray
        return cv
    }()
    
    func designSlideDownView() {
        
        if let window = UIApplication.shared.keyWindow {
        
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.1)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            //collectionView.frame = window.frame
            
            let height: CGFloat = 300
            
            collectionView.frame = CGRect(origin: CGPoint(x: 0,y: -height + 64), size: CGSize(width: window.frame.width, height: height))
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(origin: CGPoint(x: 0,y: 64), size: CGSize(width: window.frame.width, height: height))
            }, completion: nil)
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 1) {
            self.blackView.alpha = 0
            
            if let collectionView = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(origin: CGPoint(x: 0,y: -collectionView.frame.height + 64), size: CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height))
                self.collectionView.alpha = 0
            }
        }
        self.collectionView.alpha = 1
    }
    
    override init() {
        super.init()
    }
}
