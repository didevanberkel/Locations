//
//  BootCampAnnotation.swift
//  DevBootcamp
//
//  Created by Dide van Berkel on 25-03-16.
//  Copyright © 2016 Gary Grape Productions. All rights reserved.
//

import Foundation
import MapKit

class BootCampAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
