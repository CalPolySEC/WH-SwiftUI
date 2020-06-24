//
//  MapView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/23/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var interaction: Bool

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let annotation = MKPointAnnotation()
        let region = MKCoordinateRegion(center: coordinate, span: span)
        annotation.coordinate = coordinate
        uiView.setRegion(region, animated: true)
        uiView.addAnnotation(annotation)
        uiView.isZoomEnabled = interaction
        uiView.isScrollEnabled = interaction
        uiView.isUserInteractionEnabled = interaction
    }
}
