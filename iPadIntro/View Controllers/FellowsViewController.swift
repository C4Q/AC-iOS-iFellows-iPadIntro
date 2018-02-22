//
//  FellowsViewController.swift
//  iPadIntro
//
//  Created by Alex Paul on 2/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class FellowsViewController: UITableViewController {
    private var fellows = [Fellow]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // variable to keep track of collapsing detail view controller on launch
    private var isCollapsedSecondaryController = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let svc = splitViewController {
            if let fellowsSVC = svc as? FellowsSplitViewController {
                fellows = fellowsSVC.fellows
            }
        } else {
            print("split view controller doesn't exist")
        }
        splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController,
            let detailVC = navController.viewControllers.first as? DetailViewController,
            let cell = sender as? FellowCell,
            let indexPath = tableView.indexPath(for: cell) else {
                fatalError("can't segue to detail view controller")
        }
        let fellow = fellows[indexPath.row]
        detailVC.fellow = fellow
    }
}

// MARK:- Table View Datasource
extension FellowsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fellows.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FellowCell", for: indexPath) as! FellowCell
        let fellow = fellows[indexPath.row]
        cell.configureCell(fellow: fellow)
        return cell
    }
}

// MARK:- Table View Delegate
extension FellowsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

// MARK:- Split View Delegate
extension FellowsViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return isCollapsedSecondaryController
    }
}

