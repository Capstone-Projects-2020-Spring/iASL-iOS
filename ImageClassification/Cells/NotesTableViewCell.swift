//
//  NotesTableViewCell.swift
//  ImageClassification
//
//  Created by Liam Miller on 4/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class NotesTableViewCell: UITableViewCell {
    
    var note: Note? {
        didSet {
            titleLabel.text = note?.title
            
            //need to manage the length of the noteLabel
            //let noteTextIndex = note?.text?.endIndex
            if (note?.text!.count)! > 25 {
                let noteTextNewEndIndex = note?.text?.index((note?.text!.startIndex)!, offsetBy: 25)
                let shortenedNoteText = note?.text?[..<noteTextNewEndIndex!]
                noteLabel.text = "\"" + String(shortenedNoteText!) + "...\""
            } else {
                noteLabel.text = "\"" + (note?.text)! + "...\""
            }
            
            //set the timestamp appropriately
            if let milliseconds = note?.timestamp?.doubleValue {
                let seconds = milliseconds / 1000
                let timestampDate = Date(timeIntervalSince1970: seconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                //dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
                let strDate = dateFormatter.string(from: timestampDate)
                timestampLabel.text = strDate
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .blue
        //label.textColor = .white
        return label
    }()

    let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .blue
        //label.textColor = .white
        return label
    }()

    let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .blue
        //label.textColor = .white
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //self.addSubview(titleLabel)
        //self.addSubview(noteLabel)
        //self.addSubview(timestampLabel)
        
        

//        textLabel?.frame = CGRect(x: 64, y: (textLabel?.frame.origin.y)! - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
//        detailTextLabel?.frame = CGRect(x: 64, y: (detailTextLabel?.frame.origin.y)! + 2, width: (detailTextLabel?.frame.width)!, height: (detailTextLabel?.frame.height)!)

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
            //self.backgroundColor = .red

        setupTitleLabel()
        setupNoteLabel()
        setupTimestampLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        //titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //FIXME: might need a width constraint
    }

    func setupNoteLabel() {
        self.addSubview(noteLabel)
        noteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        //noteLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        //noteLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setupTimestampLabel() {
        self.addSubview(timestampLabel)
        timestampLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        //timestampLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5).isActive = true
        timestampLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        //timestampLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true
    }
}
