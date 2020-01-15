//
//  DetailsEventViewController.swift
//  Lego
//
//  Created by Abhinav Pottabathula on 1/14/20.
//  Copyright © 2020 lego. All rights reserved.
//

import UIKit
import Moya
import AlamofireImage
import MapKit
import CoreLocation

class DetailsEventViewController: UIViewController {
    @IBOutlet weak var detailsEventView: DetailsEventView?
    
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()
    
    var viewModel: DetailsViewModel? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detailsEventView?.collectionView?.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        detailsEventView?.collectionView?.dataSource = self
        detailsEventView?.collectionView?.delegate = self
    }

    func updateView() {
        if let viewModel = viewModel {
            detailsEventView?.priceLabel?.text = viewModel.price
            detailsEventView?.hoursLabel?.text = viewModel.isOpen
            detailsEventView?.locationLabel?.text = viewModel.phoneNumber
            detailsEventView?.ratingsLabel?.text = viewModel.rating
            detailsEventView?.collectionView?.reloadData()
            centerMap(for: viewModel.coordinate)
            title = viewModel.name
        }
    }

    func centerMap(for coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        detailsEventView?.mapView?.addAnnotation(annotation)
        detailsEventView?.mapView?.setRegion(region, animated: true)
    }
}

extension DetailsEventViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageUrls.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! DetailsCollectionViewCell
        if let url = viewModel?.imageUrls[indexPath.item] {
            cell.imageView.af_setImage(withURL: url)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        detailsEventView?.pageControl?.currentPage = indexPath.item
    }
}

