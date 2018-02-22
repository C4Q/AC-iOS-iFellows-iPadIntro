//
//  DetailViewController.swift
//  iPadIntro
//
//  Created by Alex Paul on 2/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!

    public var fellow: Fellow!
    private var isComingFromBarItem = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        configureDetailView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2.0
        profileImage.layer.masksToBounds = true
    }
    
    private func configureDetailView() {
        profileImage.kf.indicatorType = .activity
        profileImage.kf.setImage(with: fellow.imageURL, placeholder: UIImage.init(named: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: nil)
        bioTextView.text = fellow.bio
    }
    
    @objc private func share() {
        guard let fellowImage = profileImage.image else { print(":-( no image");return}
        let activityController = UIActivityViewController(activityItems: [fellowImage, "Here is the link to \(fellow.name)'s Github: \(fellow.githubURL)"], applicationActivities: nil)
        let popOver = activityController.popoverPresentationController
        activityController.modalPresentationStyle = .popover
        popOver?.sourceView = view
        if isComingFromBarItem {
            popOver?.barButtonItem = navigationItem.rightBarButtonItem
        } else {
            popOver?.sourceRect = shareButton.frame
        }
        present(activityController, animated: true, completion: nil)
        isComingFromBarItem = false
    }
    
    @IBAction private func shareButtonPressed() {
        share()
        isComingFromBarItem = true
    }
}
