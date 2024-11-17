//
//  Enums.swift
//  Omahat
//
//  Created by Imran Mohammed on 2/18/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation

//enum SettingsItem: String {
//
//}

/// PATHS FOR REQUESTING THE SERVER
public enum ApiPath: String {
    case general
    case customer
    case property
    case jobrequest = "job-request"
    case employees
    case inventory


}

/// ROUTES FOR API
public enum ApiRoute: String {
    case property
    case integration
}

public enum FilterSortBy: String {
    case name
    case price
    case created_at
}

public enum FilterSortDirection: String {
    case ASC
    case DESC
}

public enum LocalFileName: String {
    case service
    case service_sel
}
