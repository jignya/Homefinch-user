//
//  LayoutInfo.swift
//  TagCellLayout
//
//  Created by Ritesh Gupta on 06/01/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import UIKit

public extension TagCellLayout {
	
	struct LayoutInfo {
		
		var layoutAttribute: UICollectionViewLayoutAttributes
		var whiteSpace: CGFloat = 10.0
		
		init(layoutAttribute: UICollectionViewLayoutAttributes) {
			self.layoutAttribute = layoutAttribute
		}
	}
}
