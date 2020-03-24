//
//  RemoteConversationVC.swift
//  ImageClassification
//
//  Created by Likhon Gomes on 3/9/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import UIKit
import Firebase

class RemoteConversationVC: UIViewController {

    var people = ["Ian Applebaum", "Leo Gomes", "Liam Miller", "Viet Pham", "Tarek Elseify", "Aidan Loza", "Shakeel Alibhai"]

    let topBar = UIView()
    let topLabel = UILabel()
    let backButton = UIButton()
    let tableView = UITableView()
    let liveButton = UIButton()

    let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.layer.cornerRadius = 5
        //button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    //change the color of the status bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        topBarSetup()
        backButtonSetup()
        topLabelSetup()
        tableViewSetup()

        logoutButtonSetup()

        //composedMessageSetup()
    }

    //FIXME: Maybe add a pop up message asking the user if they are sure they want to log out?
    ///handles the logout button, so it logs the user out of firebae and presents the login controller
    @objc func handleLogout() {

        print("handle logout tapped")

        //log the user out of firebase
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        //present the login screen
        let loginController = LoginVC()
        loginController.modalTransitionStyle = .crossDissolve
        loginController.modalPresentationStyle = .fullScreen
        present(loginController, animated: true, completion: nil)
    }

    ///sets the anchors and adds the button to the top bar
    func logoutButtonSetup() {
        //x, y, height, width
        topBar.addSubview(logoutButton)

        logoutButton.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -10).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //logoutButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }

	func topBarSetup() {
		 view.addSubview(topBar)
		 topBar.translatesAutoresizingMaskIntoConstraints = false
		 topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		 topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		 topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		 topBar.heightAnchor.constraint(equalToConstant: 90).isActive = true
		 topBar.backgroundColor = .black
	 }

	 func backButtonSetup() {
		 topBar.addSubview(backButton)
		 backButton.translatesAutoresizingMaskIntoConstraints = false
		 backButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 20).isActive = true
		 backButton.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
		 backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
		 backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
		 let tintedImage = #imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate)
		 backButton.setImage(tintedImage, for: .normal)
		 backButton.tintColor = .white
		 backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
	 }

	 @objc func backButtonTapped() {
		 dismiss(animated: true, completion: nil)
		 //navigationController?.popViewController(animated: true)
	 }

	 func topLabelSetup() {
		 topBar.addSubview(topLabel)
		 topLabel.translatesAutoresizingMaskIntoConstraints = false
		 topLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20).isActive = true
		 topLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -10).isActive = true
		 topLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
		 topLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
		 topLabel.text = "Chat"
		 topLabel.font = UIFont.boldSystemFont(ofSize: 30)
		 topLabel.textColor = .white
	 }

}

extension RemoteConversationVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = people[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //let vc = ChatVC(collectionViewLayout: UICollectionViewFlowLayout())

        let vc = ChatVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.topLabel.text = people[indexPath.row]
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
    }

    func tableViewSetup() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}
