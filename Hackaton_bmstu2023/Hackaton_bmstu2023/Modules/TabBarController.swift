//
//  TabBarController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .Button.customBlue
        tabBar.backgroundColor = .Background.customBackground
        
        generateTabBar()
    }
    
    private func generateTabBar() {
        let viewControllers = [
            configureTabBar(with: UINavigationController(rootViewController: MainViewController()),
                            image: FirstVC.Images.tabBarImage,
                            title: FirstVC.Title.tabBarTitle),
            
            configureTabBar(with: UINavigationController(rootViewController: MainViewController()),
                            image: SeconsVC.Images.tabBarImage,
                            title: SeconsVC.Title.tabBarTitle),
            
            configureTabBar(with: UINavigationController(rootViewController: MainViewController()),
                            image: ThirdVC.Images.tabBarImage,
                            title: ThirdVC.Title.tabBarTitle)]
        
        setViewControllers(viewControllers, animated: true)
    }

    private func configureTabBar(with vc: UINavigationController, image: UIImage, title: String) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
}

private extension TabBarController {
    struct FirstVC {
        struct Images {
            static let tabBarImage: UIImage = UIImage(systemName: "person") ?? DafaultImage.image
        }
        struct Title {
            static let tabBarTitle = "Profile"
        }
    }
    
    struct SeconsVC {
        struct Images {
            static let tabBarImage: UIImage = UIImage(systemName: "cart") ?? DafaultImage.image
        }
        struct Title {
            static let tabBarTitle = "Basket"
        }
    }
    
    struct ThirdVC {
        struct Images {
            static let tabBarImage: UIImage = UIImage(systemName: "gearshape.2") ?? DafaultImage.image //gearshape
        }
        struct Title {
            static let tabBarTitle = "Settings"
        }
    }
    
    struct DafaultImage {
        static let image = UIImage(systemName: "network")!
    }
}


