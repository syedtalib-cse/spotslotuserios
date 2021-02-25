//
//  IntroVC.swift
//  Spotslot
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//


import UIKit

class IntroVC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()

    @IBOutlet weak var pageIndicator: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self

        addChild(pageController)
        view.addSubview(pageController.view)

        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))

        let storyBoardObj = UIStoryboard(name: "Intro", bundle: nil)
        let vc1 = storyBoardObj.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
         controllers.append(vc1)
        let vc2 = storyBoardObj.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
            controllers.append(vc2)
        let vc3 = storyBoardObj.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
            controllers.append(vc3)
        let vc4 = storyBoardObj.instantiateViewController(withIdentifier: "ForthVC") as! ForthVC
            controllers.append(vc4)
        let vc5 = storyBoardObj.instantiateViewController(withIdentifier: "FifthVC") as! FifthVC
            controllers.append(vc5)
//        for _ in 1 ... 5 {
//            let vc = UIViewController()
//            vc.view.backgroundColor = randomColor()
//            controllers.append(vc)
//        }

        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
      //  pageIndicator.currentPage = 0
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                //pageIndicator.currentPage = index-1
                return controllers[index - 1]
            } else {
                return nil
            }
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return nil
            }
        }

        return nil
    }

    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

    func randomColor() -> UIColor {
        return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
    }
}
