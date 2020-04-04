//
//  CardView.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/27/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

class CardView: UIViewController {

    let outputTextView = UITextView()
    let textViewHolder = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.backgroundColor = .blue
        textViewHolderSetup()
        outputTextViewSetup()

        let panYGesture = UIPanGestureRecognizer(target: self, action: (#selector(self.handleYGesture(_:))))
        self.textViewHolder.addGestureRecognizer(panYGesture)

    }

    @objc func handleYGesture(_ gesture: UIPanGestureRecognizer) {
      // 1
      let translation = gesture.translation(in: view)

      // 2
      guard let gestureView = gesture.view else {
        return
      }

      gestureView.center = CGPoint(
        x: gestureView.center.x,
        y: gestureView.center.y + translation.y
      )

      // 3
      gesture.setTranslation(.zero, in: view)
    }

    func textViewHolderSetup() {
        view.addSubview(textViewHolder)
        textViewHolder.translatesAutoresizingMaskIntoConstraints = false
        textViewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textViewHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textViewHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textViewHolder.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        textViewHolder.backgroundColor = #colorLiteral(red: 0.9596421632, green: 0.9596421632, blue: 0.9596421632, alpha: 1)
        textViewHolder.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textViewHolder.layer.cornerRadius = 20
        textViewHolder.isUserInteractionEnabled = true

    }

    func outputTextViewSetup() {
        textViewHolder.addSubview(outputTextView)
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        outputTextView.bottomAnchor.constraint(equalTo: textViewHolder.bottomAnchor).isActive = true
        outputTextView.leadingAnchor.constraint(equalTo: textViewHolder.leadingAnchor).isActive = true
        outputTextView.trailingAnchor.constraint(equalTo: textViewHolder.trailingAnchor).isActive = true
        outputTextView.topAnchor.constraint(equalTo: textViewHolder.topAnchor, constant: 20).isActive = true
        outputTextView.isEditable = false
        outputTextView.text = ""
        outputTextView.textColor = .gray
        outputTextView.font = UIFont.boldSystemFont(ofSize: 30)
        outputTextView.isUserInteractionEnabled = true
    }

}
