//
//  NotesTableViewCell.swift
//  ImageClassification
//
//  Created by Liam Miller on 4/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

/**
 This class is a custom table view cell for the table view in our notes feature. It handles the constraints for each subview and also helps with some logic in setting the note information in its proper place.
 */
class NotesTableViewCell: UITableViewCell {

    ///This is of type Note from our custom swift class and it helps with the logic of setting the note information in each table view cell. It sets the title, the text, and the time.
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

    ///A closure for the note title label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    ///A closure for the label for the text of a note
    let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    ///A closure for the label for the time a note was created
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    ///Function for laying out the subviews
    override func layoutSubviews() {
        super.layoutSubviews()

    }

	/// Function called every time this table view cell is used. It is being used to call the setup function for the subviews of this table view cell.
	/// - Parameters:
	///   - style: A constant indicating a cell style. See UITableViewCell.CellStyle for descriptions of these constants.
	///   - reuseIdentifier: A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view. Pass nil if the cell object is not to be reused. You should use the same reuse identifier for all cells of the same form.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
        setupNoteLabel()
        setupTimestampLabel()
    }

	/// Required function for checking if there was a fatal error
	/// - Parameter coder: An abstract class that serves as the basis for objects that enable archiving and distribution of other objects.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///Adds the title label to the subview and defines the constraints of the title label
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
    }

    ///Adds the note label to the subview and defines the constraints of the note label
    func setupNoteLabel() {
        self.addSubview(noteLabel)
        noteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    }

    ///Adds the timestamp label to the subview and defines the constraints of the timestamp label
    func setupTimestampLabel() {
        self.addSubview(timestampLabel)
        timestampLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        timestampLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
}
