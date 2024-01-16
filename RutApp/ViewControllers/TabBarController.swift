//
//  TabBarController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        generateTabBar()
        tabBar.tintColor = AppColors.blueColor
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(vc: InfoViewController(), title: "Info", image: UIImage(systemName: "info.circle")),
            generateVC(vc: BookingViewController(), title: "Booking", image: UIImage(systemName: "calendar.circle")),
            generateVC(vc: AccountViewController(), title: "Account", image: UIImage(systemName: "person.crop.circle"))
        ]
    }
    
    private func generateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }

}
