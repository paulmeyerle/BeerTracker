//
//  MockViewController.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/19/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import UIKit.UIViewController

final class MockViewController: UIViewController {
    private(set) var presentCallCount: Int = 0
    private(set) var presentParamViewController = [UIViewController]()
    private(set) var presentParamAnimated = [Bool]()
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCallCount += 1
        presentParamViewController.append(viewControllerToPresent)
        presentParamAnimated.append(flag)
        completion?()
    }
}
