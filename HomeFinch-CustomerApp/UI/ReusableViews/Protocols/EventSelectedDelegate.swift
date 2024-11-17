//
//  EventSelectedDelegate.swift
//  Omahat
//
//  Created by Imran Mohammed on 10/22/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation

protocol EventSelectedDelegate: class {
    
    func didSelectEvent(at indexPath: IndexPath, event: String)
    
}
