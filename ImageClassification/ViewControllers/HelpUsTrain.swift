//
//  HelpUsTrain.swift
//  ImageClassification
//
//  Created by Ian Applebaum on 4/8/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import SnapKit
class HelpUsTrain: UIViewController {
	let titleLabel = UILabel()
	let descriptionText = UITextView()
	let continueButton = UIButton()
	let dismissButton = UIButton()
	let backButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
		if #available(iOS 13.0, *) {
			view.backgroundColor = .systemBackground
		} else {
			// Fallback on earlier versions
			view.backgroundColor = .white
		}
		backButtonSetup()
		titleLabelSetup()
        // Do any additional setup after loading the view.
		
    }
	func backButtonSetup() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let tintedImage = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate)
        backButton.setImage(tintedImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		
    }
	
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }
	
    func titleLabelSetup() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
		titleLabel.text = "Help us train iASL"
    }

	func dismissButtonSetup() {
		view.addSubview(dismissButton)
		dismissButton.translatesAutoresizingMaskIntoConstraints = false
		dismissButton.setTitle(self.configuration.dismissButtonText, for: .normal)
			   self.dismissButton.addTarget(self, action: #selector(self.dismissButtonTapped), for: .touchUpInside)
			   self.dismissButton.fillColor = self.configuration.tintColor
			   self.dismissButton.clipsToBounds = true
			   self.dismissButton.layer.cornerRadius = 8
			   self.dismissButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
			   
			   self.dismissButton.snp.makeConstraints { (make) in
				   make.top.equalTo(self.scrollView.snp.bottom).offset(20)
				   make.left.equalTo(self.view.snp.leftMargin).offset(self.marginSize)
				   make.right.equalTo(self.view.snp.rightMargin).offset(-(self.marginSize))
				   make.bottom.equalTo(self.view.snp.bottomMargin).offset(-(self.marginSize + 24))
				   make.height.equalTo(self.getButtonSize())
			   }
	}

}
