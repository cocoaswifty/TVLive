//
//  RightViewController.swift
//  TVLive
//
//  Created by jianhao on 2016/11/13.
//  Copyright © 2016年 cocoaswifty. All rights reserved.
//

import UIKit

enum RightMenu: Int {
    case main = 0
    case swift
}

protocol RightMenuProtocol : class {
    func changeViewController(_ menu: RightMenu)
}

class RightViewController : UIViewController, RightMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Main", "Swift"]
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.mainViewController = UINavigationController(rootViewController: mainViewController)
        
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "SwiftViewController") as! SwiftViewController
        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func changeViewController(_ menu: RightMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .swift:
            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        }
    }
}

extension RightViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = RightMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .swift:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = RightMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension RightViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = RightMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .swift:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
