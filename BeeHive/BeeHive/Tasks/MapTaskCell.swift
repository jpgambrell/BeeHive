//
//  TasksTableViewCell.swift
//  BeeHive
//
//  Created by John Gambrell on 6/27/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit
import MapKit

class MapTaskCell: UITableViewCell, MKMapViewDelegate {
    //@IBOutlet weak var mapImgView: UIImageView!
    
    @IBOutlet weak var progressHeaderView: ProgressLineView!
    @IBOutlet weak var taskLabel: UILabel!
    var mapView = MKMapView()
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.delegate = self
        // Initialization code
        
//        mapImgView.layer.cornerRadius = mapImgView.frame.size.width / 2
//        mapImgView.clipsToBounds = true
        setupMapView()
    }
    
    func setupMapView() {
        
//        let geo = CLGeocoder()
//        geo.geocodeAddressString("5001 Tenneyson Plano, TX") { (placemarks, error) in
//            print(placemarks ?? "no results")
//            let destLocation = placemarks?.first?.location
//            let regionRadius: CLLocationDistance = 500
//            let coordinateRegion = MKCoordinateRegionMakeWithDistance((destLocation?.coordinate)!,
//                                                                      regionRadius, regionRadius * 2.0)
//            self.locationMapView.setRegion(coordinateRegion, animated: true)
//            //self.locationMapView
//        }
       // let sourceLocation = CLLocation(latitude: 33.066227, longitude:  -96.824135) //classic bmw
      //  let sourceLocation = CLLocation(latitude: 33.006367, longitude:  -96.97226) //Vista Ridge mall
       // let sourceLocation = CLLocation(latitude: 33.070732, longitude: -96.79762) //JCP
        let sourceLocation = CLLocation(latitude: +32.882675, longitude: -96.87463) //Pensive
        let destinationLocation = CLLocation(latitude: +33.06470690, longitude: -96.79690030)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation.coordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation.coordinate, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        // 5.
        let sourceAnnotation = MKPointAnnotation()
       // sourceAnnotation.title = "Times Square"
        
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
       // destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            
            
            
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
       //     let rect = route.polyline.boundingMapRect
            var regionRect = route.polyline.boundingMapRect
            
            
            let wPadding = regionRect.size.width * 0.45
            let hPadding = regionRect.size.height * 0.6
            
            //Add padding to the region
            regionRect.size.width += wPadding
            regionRect.size.height += hPadding
            
            //Center the region on the line
            regionRect.origin.x -= wPadding / 2
           regionRect.origin.y += 100//hPadding / 4
            self.mapView.setRegion(MKCoordinateRegionForMapRect(regionRect), animated: false)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.cyan
        renderer.lineWidth = 4.0
        
        return renderer
    }
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
       
        
        
    }
    
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
