//
//  AddressPickerViewController.swift
//  SplotslotVendor
//
//  Created by jaipee on 30/01/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SplotSlotMarker: GMSMarker {
    
    init(image: UIImage? = #imageLiteral(resourceName: "pin")) {
        super.init()
        let _iconView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView()
        imageView.frame = _iconView.frame
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        _iconView.addSubview(imageView)
        
        //_iconView.layer.cornerRadius = _iconView.frame.size.height / 2
        //_iconView.layer.borderWidth = 1.5
        //_iconView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.iconView = _iconView
    }
}

class AddressPickerViewController: UIViewController {
    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let LocationManager = CLLocationManager()
    private var longitude = ""
    private var latitude = ""
    private var address = ""
    private var marker: SplotSlotMarker!
    
    private var tableDataSource: GMSAutocompleteTableDataSource!
    var getLocationAndAddressCompletion: ((String, String, String)-> ())!
    override func viewDidLoad() {
        super.viewDidLoad()
        forMaps()
        setup()
        // Do any additional setup after loading the view.
    }

    private func setup() {
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        tableView.isHidden = true
        
        searchTextField.placeHolderColor = .init(white: 1, alpha: 0.7)
        searchTextField.addTarget(self, action: #selector(searchAddress(_:)), for: .editingChanged)
    }
    
    @objc func searchAddress(_ addressTextField: UITextField) {
        // Update the GMSAutocompleteTableDataSource with the search text.
        if let address = addressTextField.text, !address.isEmpty {
            tableDataSource.sourceTextHasChanged(address)
        }else {
            tableView.isHidden = true
        }
    }
    
    func forMaps(){
        
        //for location
        self.viewMap.padding = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        self.LocationManager.requestAlwaysAuthorization()
        self.LocationManager.requestWhenInUseAuthorization()
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.distanceFilter = 50
        LocationManager.delegate = self
        viewMap.delegate = self
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "DarkStyle", withExtension: "json") {
                viewMap.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func setLocationAction(_ sender: Any) {
        if !address.isEmpty {
            getLocationAndAddressCompletion(latitude, longitude, address)
        }else {
            GlobalObj.showAlertVC(title: appName, message: "Can't get address from selected location", controller: self)
        }
    }

}


extension AddressPickerViewController: GMSAutocompleteTableDataSourceDelegate {
  func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator off.
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    // Reload table data.
    self.tableView.isHidden = tableDataSource.tableView(self.tableView, numberOfRowsInSection: 0) > 0 ?  false :  true
    tableView.reloadData()
  }

  func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator on.
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    // Reload table data.
    tableView.reloadData()
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
    // Do something with the selected place.
    self.tableView.isHidden = true
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
    self.searchTextField.text = nil
    self.address = (place.name ?? "") + " " + (place.formattedAddress ?? "")
    placeMarkerOnCenter(centerMapCoordinate: place.coordinate)
    self.searchTextField.text = self.address
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
    // Handle the error.
    print("Error: \(error.localizedDescription)")
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
    return true
  }
}

// MARK: - CLLocationManagerDelegate
extension AddressPickerViewController {
    //Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            LocationManager.startUpdatingLocation()
            viewMap.isMyLocationEnabled = true
            viewMap.settings.myLocationButton = true
        @unknown default:
            fatalError()
        }
    }
    func setMarkeronLocation(_ coordinate:CLLocationCoordinate2D,title:String,snippet:String){
        // // Creates a marker in the center of the map.
        viewMap.clear()
        let position = CLLocationCoordinate2D(latitude:coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: #colorLiteral(red: 0.9832366109, green: 0.7234969139, blue: 0.2646969259, alpha: 1))
        marker.tracksViewChanges = true
        marker.isDraggable = true
        marker.title = title
        marker.snippet = snippet
        marker.map = viewMap
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.longitude = "\(coordinate.longitude)"
            self.latitude = "\(coordinate.latitude )"
            let subLocal = address.subLocality ?? ""
            let local = address.locality ?? ""
            self.address = subLocal + " " + local
            //self.setMarkeronLocation(coordinate, title: subLocal + " " + local,snippet: lines.joined(separator: "\n"))
            self.searchTextField.text = self.address
        }
    }
}


//Get device Location
extension AddressPickerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         print("locations = \(locations)")
        LocationManager.stopUpdatingLocation()
        if let coordinate = LocationManager.location?.coordinate {
            placeMarkerOnCenter(centerMapCoordinate: coordinate)
            reverseGeocodeCoordinate(coordinate)
        }
        LocationManager.stopUpdatingLocation()
    }
}
//MARK: - GMSMapViewDelegate
extension AddressPickerViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("coordinate are \(coordinate)")
        placeMarkerOnCenter(centerMapCoordinate: coordinate)
        reverseGeocodeCoordinate(coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        /*let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        let centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //self.placeMarkerOnCenter(centerMapCoordinate: centerMapCoordinate)*/
    }
    
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        if marker == nil {
            marker = SplotSlotMarker()
        }
        marker.position = centerMapCoordinate
        marker.map = self.viewMap
        self.longitude = "\(centerMapCoordinate.longitude)"
        self.latitude = "\(centerMapCoordinate.latitude )"
        viewMap.camera = GMSCameraPosition(target: centerMapCoordinate, zoom: 16, bearing: 15, viewingAngle: 0)
    }
}
