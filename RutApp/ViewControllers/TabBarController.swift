//
//  TabBarController.swift
//  RutApp
//
//  Created by Michael Kivo on 15/01/2024.
//

import UIKit
import FirebaseAuth

final class TabBarController: UITabBarController {
    
    // MARK: - Properties

    let adminUIDs = ["diOt4ObiLrNZPrsJgNNlxEl3zdh2"]
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setUp()
    }
    
    private func setUp() {
        tabBar.backgroundColor = AppColors.miitColor
        tabBar.tintColor = .white
        tabBar.barStyle = .default
        tabBar.barTintColor = AppColors.miitColor
    }
    
    private func generateTabBar() {
        let uid = Auth.auth().currentUser?.uid
        let flag = adminUIDs.contains(uid!)
        
        viewControllers = [
            generateVC(vc: InfoViewController(), title: "Информация", image: UIImage(systemName: "info.circle")),
            generateVC(vc: flag ? AdminCalendarViewController() : BookingViewController(), title: flag ? "Бронирования" : "Бронирование", image: UIImage(systemName: "calendar.circle")),
            generateVC(vc: AccountViewController(), title: "Аккаунт", image: UIImage(systemName: "person.crop.circle"))
        ]
    }
    
    private func generateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
    
}
