//
//  FellowsSplitViewController.swift
//  iPadIntro
//
//  Created by Alex Paul on 2/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class FellowsSplitViewController: UISplitViewController {

    public var fellows = [Fellow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fellows = JSONParser.parseJSONFile(filename: "fellows", type: "json")
        if let navController = viewControllers.last as? UINavigationController {
            if let detaiVC = navController.viewControllers.first as? DetailViewController {
                detaiVC.fellow = fellows[0]
            }
        }
    }
    
    public static func storyboardInstance() -> FellowsSplitViewController {
        let storyboard = UIStoryboard(name: "iPad", bundle: nil)
        let fellowsSplitViewController = storyboard.instantiateViewController(withIdentifier: "FellowsSplitViewController") as! FellowsSplitViewController
        return fellowsSplitViewController
    }

}
