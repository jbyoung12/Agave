//
//  FindPodcastsViewController.swift
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import Foundation
import UIKit
//
//func priceString(from price: Int) -> String {
//    let priceText: String
//    switch price {
//    case 1:
//        priceText = "$"
//    case 2:
//        priceText = "$$"
//    case 3:
//        priceText = "$$$"
//    case _:
//        fatalError("price must be between one and three")
//    }
//
//    return priceText
//}
//
//private func imageURL(from string: String) -> URL {
//    let number = (abs(string.hashValue) % 22) + 1
//    let URLString =
//    "https://storage.googleapis.com/firestorequickstarts.appspot.com/food_\(number).png"
//    return URL(string: URLString)!
//}
//
//class RestaurantsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    let backgroundView = UIImageView()
//
//    private var documents: [DocumentSnapshot] = []
//
//    fileprivate var query: Query? {
//        didSet {
//            if let listener = listener {
//                listener.remove()
//                observeQuery()
//            }
//        }
//    }
//
//    private var listener: ListenerRegistration?
//
//    fileprivate func observeQuery() {
//        guard let query = query else { return }
//        stopObserving()
//
//        // Display data from Firestore, part one
//
//
//    }
//
//    fileprivate func stopObserving() {
//        listener?.remove()
//    }
//
//    fileprivate func baseQuery() -> Query {
//        // Firestore needs to use Timestamp type instead of Date type.
//        // https://firebase.google.com/docs/reference/swift/firebasefirestore/api/reference/Classes/FirestoreSettings
//        let firestore: Firestore = Firestore.firestore()
//        let settings = firestore.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        firestore.settings = settings
//        return firestore.collection("restaurants").limit(to: 50)
//    }
//
//    lazy private var filters: (navigationController: UINavigationController,
//        filtersController: FiltersViewController) = {
//            return FiltersViewController.fromStoryboard(delegate: self)
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        backgroundView.image = UIImage(named: "pizza-monster")!
//        backgroundView.contentMode = .scaleAspectFit
//        backgroundView.alpha = 0.5
//        tableView.backgroundView = backgroundView
//        tableView.tableFooterView = UIView()
//
//        // Blue bar with white color
//        navigationController?.navigationBar.barTintColor =
//            UIColor(red: 0x3d/0xff, green: 0x5a/0xff, blue: 0xfe/0xff, alpha: 1.0)
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.titleTextAttributes =
//            [ NSForegroundColorAttributeName: UIColor.white ]
//
//        tableView.dataSource = self
//        tableView.delegate = self
//        query = baseQuery()
//        stackViewHeightConstraint.constant = 0
//        activeFiltersStackView.isHidden = true
//
//        self.navigationController?.navigationBar.barStyle = .black
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.setNeedsStatusBarAppearanceUpdate()
//        observeQuery()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let auth = FUIAuth.defaultAuthUI()!
//        if auth.auth?.currentUser == nil {
//            auth.providers = []
//            present(auth.authViewController(), animated: true, completion: nil)
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        stopObserving()
//    }
//
//    @IBAction func didTapPopulateButton(_ sender: Any) {
//        let words = ["Bar", "Fire", "Grill", "Drive Thru", "Place", "Best", "Spot", "Prime", "Eatin'"]
//
//        let cities = Restaurant.cities
//        let categories = Restaurant.categories
//
//        for _ in 0 ..< 20 {
//            let randomIndexes = (Int(arc4random_uniform(UInt32(words.count))),
//                                 Int(arc4random_uniform(UInt32(words.count))))
//            let name = words[randomIndexes.0] + " " + words[randomIndexes.1]
//            let category = categories[Int(arc4random_uniform(UInt32(categories.count)))]
//            let city = cities[Int(arc4random_uniform(UInt32(cities.count)))]
//            let price = Int(arc4random_uniform(3)) + 1
//
//            // Basic writes
//
//            let collection = Firestore.firestore().collection("restaurants")
//
//
//        }
//    }
//
//    @IBAction func didTapClearButton(_ sender: Any) {
//        filters.filtersController.clearFilters()
//        controller(filters.filtersController, didSelectCategory: nil, city: nil, price: nil, sortBy: nil)
//    }
//
//    @IBAction func didTapFilterButton(_ sender: Any) {
//        present(filters.navigationController, animated: true, completion: nil)
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        set {}
//        get {
//            return .lightContent
//        }
//    }
//
//    deinit {
//        listener?.remove()
//    }
//
//    // MARK: - UITableViewDataSource
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell",
//                                                 for: indexPath) as! RestaurantTableViewCell
//        let restaurant = restaurants[indexPath.row]
//        cell.populate(restaurant: restaurant)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return restaurants.count
//    }
//
//    // MARK: - UITableViewDelegate
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let controller = RestaurantDetailViewController.fromStoryboard()
//        controller.titleImageURL = imageURL(from: restaurants[indexPath.row].name)
//        controller.restaurant = restaurants[indexPath.row]
//        controller.restaurantReference = documents[indexPath.row].reference
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
//
//}
//
//extension RestaurantsTableViewController: FiltersViewControllerDelegate {
//
//    func query(withCategory category: String?, city: String?, price: Int?, sortBy: String?) -> Query {
//        var filtered = baseQuery()
//
//        if category == nil && city == nil && price == nil && sortBy == nil {
//            stackViewHeightConstraint.constant = 0
//            activeFiltersStackView.isHidden = true
//        } else {
//            stackViewHeightConstraint.constant = 44
//            activeFiltersStackView.isHidden = false
//        }
//
//        // Advanced queries
//
//        return filtered
//    }
//
//    func controller(_ controller: FiltersViewController,
//                    didSelectCategory category: String?,
//                    city: String?,
//                    price: Int?,
//                    sortBy: String?) {
//        let filtered = query(withCategory: category, city: city, price: price, sortBy: sortBy)
//
//        if let category = category, !category.isEmpty {
//            categoryFilterLabel.text = category
//            categoryFilterLabel.isHidden = false
//        } else {
//            categoryFilterLabel.isHidden = true
//        }
//
//        if let city = city, !city.isEmpty {
//            cityFilterLabel.text = city
//            cityFilterLabel.isHidden = false
//        } else {
//            cityFilterLabel.isHidden = true
//        }
//
//        if let price = price {
//            priceFilterLabel.text = priceString(from: price)
//            priceFilterLabel.isHidden = false
//        } else {
//            priceFilterLabel.isHidden = true
//        }
//
//        self.query = filtered
//        observeQuery()
//    }
//
//}
//
//class RestaurantTableViewCell: UITableViewCell {
//
//    @IBOutlet weak private var thumbnailView: UIImageView!
//
//    @IBOutlet weak private var nameLabel: UILabel!
//
//    @IBOutlet weak var starsView: ImmutableStarsView!
//
//    @IBOutlet weak private var cityLabel: UILabel!
//
//    @IBOutlet weak private var categoryLabel: UILabel!
//
//    @IBOutlet weak private var priceLabel: UILabel!
//
//    func populate(restaurant: Restaurant) {
//
//        // Displaying data, part two
//
//        let image = imageURL(from: restaurant.name)
//        thumbnailView.sd_setImage(with: image)
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        thumbnailView.sd_cancelCurrentImageLoad()
//    }

//}
