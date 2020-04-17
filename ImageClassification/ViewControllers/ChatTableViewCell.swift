//
//  ChatTableViewCell.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/10/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit

//FIXME: I think we can delete this file

class ChatTableViewCell: UITableViewCell {

    let sentMessageBox = UIView()
    let receivedMessageBox = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sentMessageBoxSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //backgroundColor = .yellow
        sentMessageBoxSetup()
        // Configure the view for the selected state
    }

    func sentMessageBoxSetup() {
        //backgroundColor = .blue
        addSubview(sentMessageBox)
        sentMessageBox.translatesAutoresizingMaskIntoConstraints = false
        sentMessageBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        sentMessageBox.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
        sentMessageBox.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        sentMessageBox.widthAnchor.constraint(equalToConstant: 200).isActive = true
        sentMessageBox.backgroundColor = .blue
        //sentMessageBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

}
