//
//  FacebookLabel.swift
//  BibleApp
//
//  Created by Angel Contreras on 9/21/17.
//  Copyright © 2017 Igor Makara. All rights reserved.
//

import UIKit

protocol FacebookButtonDelegate: class {
    func facebookButtonPressed()
}

final class FacebookButton: UIView {
    //MARK: - Subviews
    fileprivate lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "facebookSmall")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(red: 66/255, green: 88/255, blue: 79/255, alpha: 1.0)
        return iv
    }()
    
    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 66/255, green: 88/255, blue: 79/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        return label
    }()
    
    /// Facebook Button Delegate
    weak var delegate: FacebookButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonPressed)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Did not implement coder")
    }
    
    public func setLabel(with string: String?) {
        label.text = string
    }
    
    @objc private func buttonPressed() {
        delegate?.facebookButtonPressed()
    }
}

fileprivate extension FacebookButton {
    func setupSubviews() {
        [imageView, label].forEach { (view) in
            self.addSubview(view)
        }
        
        //imageView
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 16))
        
        //label
        let dictionaryOfViews: [String: UIView] = ["iv": imageView, "l": label]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[iv]-[l]|", options: [], metrics: nil, views: dictionaryOfViews))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[l]|", options: [], metrics: nil, views: dictionaryOfViews))
    }
}
