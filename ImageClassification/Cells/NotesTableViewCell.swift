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
            if let noteText = note?.text {
                if noteText.count > 25 {
                    let noteTextNewEndIndex = noteText.index((noteText.startIndex), offsetBy: 25)
                    let shortenedNoteText = noteText[..<noteTextNewEndIndex]
                    noteLabel.text = "\"" + shortenedNoteText + "...\""
                } else {
                    noteLabel.text = "\"" + noteText + "...\""
                }
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
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

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
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
    }

    func setupNoteLabel() {
        self.addSubview(noteLabel)
        noteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    }

    func setupTimestampLabel() {
        self.addSubview(timestampLabel)
        timestampLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        timestampLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
}
