//
//  MockNavigationController.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/19/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import UIKit.UINavigationController

final class MockNavigationController: UINavigationController {
    private(set) var presentCallCount: Int = 0
    private(set) var presentParamViewController = [UIViewController]()
    private(set) var presentParamAnimated = [Bool]()
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
        presentParamViewController.append(viewControllerToPresent)
        presentParamAnimated.append(flag)
        completion?()
    }
    
    private(set) var pushViewControllerCallCount: Int = 0
    private(set) var pushViewControllerParamViewController = [UIViewController]()
    private(set) var pushViewControllerParamAnimated = [Bool]()
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCallCount += 1
        pushViewControllerParamViewController.append(viewController)
        pushViewControllerParamAnimated.append(animated)
    }
}
