//
//  PageViewController.swift
//  SurfBuds
//
//  Created by Raymond Lang on 1/28/23.
//

import SwiftUI
import UIKit

// PageViewController is a generic struct that conforms to UIViewControllerRepresentable
// It takes a generic Page that conforms to the View protocol and an @Binding var currentPage
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]  // An array of pages (or views) to be displayed in the PageViewController
    @Binding var currentPage: Int // A binding variable that keeps track of the current page being displayed
    
    // makeCoordinator creates a Coordinator object
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // makeUIViewController creates an instance of UIPageViewController
    // and sets its dataSource and delegate properties to the coordinator object
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }

    // updateUIViewController updates the view controllers displayed in the page view controller
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }

    // Coordinator is a nested class that conforms to UIPageViewControllerDataSource, UIPageViewControllerDelegate
    // It's responsible for providing the data for the page view controller, and responding to user interactions
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        // Initializes a Coordinator object with a parent PageViewController
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        // Returns the view controller before the given view controller
        // If the given view controller is the first, it returns the last view controller
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        // Returns the view controller after the given view controller
        // If the given view controller is the last, it returns the first view controller
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }

//Called user finishes swiping between pages in the UIPageViewController. It checks if the transition was completed, then finds the current visible page by looking at the UIPageViewController's viewControllers property, and finally sets the current page index in the parent view.
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
