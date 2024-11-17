//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class PropertyDataModel : NSObject, NSCoding{
    
    var latitude : String!
    var longitude : String!
    var sourceFrom : String!
    var sourceInfo : String!
    var sourceIp : String!
    var propertyType : String!
    var villaNumber : String!
    var villaStreet : String!
    var villaPropertyName : String!
    var villaOwnerMobile : String!
    var villaOwnerName : String!
	var appartmentBuilding : String!
	var appartmentFlatNo : String!
	var appartmentStreet : String!
    var appartmentPropertyName : String!
    var appartmentOwnerMobile : String!
    var appartmentOwnerName : String!
    var customerId : String!
    var id : Int!
	var villaTenant : String!
    var appartmentTenant : String!
    var isDefault : Int!
    var g_location:String!
    var accuracy:String!
    var premiseId : String!


    override init() {
 
    }

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if appartmentBuilding != nil{
			dictionary["appartment_building"] = appartmentBuilding
		}
		if appartmentFlatNo != nil{
			dictionary["appartment_flat_no"] = appartmentFlatNo
		}
		if appartmentStreet != nil{
			dictionary["appartment_street"] = appartmentStreet
		}
		if customerId != nil{
			dictionary["customer_id"] = customerId
		}
		if id != nil{
			dictionary["id"] = id
		}
		if latitude != nil{
			dictionary["latitude"] = latitude
		}
		if longitude != nil{
			dictionary["longitude"] = longitude
		}
		if propertyType != nil{
			dictionary["property_type"] = propertyType
		}
		if sourceFrom != nil{
			dictionary["source_from"] = sourceFrom
		}
		if sourceInfo != nil{
			dictionary["source_info"] = sourceInfo
		}
		if sourceIp != nil{
			dictionary["source_ip"] = sourceIp
		}
		if villaNumber != nil{
			dictionary["villa_number"] = villaNumber
		}
		if villaStreet != nil{
			dictionary["villa_street"] = villaStreet
		}
        
        if villaPropertyName != nil{
            dictionary["villa_property_name"] = villaPropertyName
        }
        if villaOwnerMobile != nil{
            dictionary["villa_owner_mobile"] = villaOwnerMobile
        }
        if villaOwnerName != nil{
            dictionary["villa_owner_name"] = villaOwnerName
        }
        if appartmentPropertyName != nil{
            dictionary["appartment_property_name"] = appartmentPropertyName
        }
        if appartmentOwnerMobile != nil{
            dictionary["appartment_owner_mobile"] = appartmentOwnerMobile
        }
        if appartmentOwnerName != nil{
            dictionary["appartment_owner_name"] = appartmentOwnerName
        }
        
        if villaTenant != nil{
            dictionary["villa_tenant"] = villaTenant
        }
        if appartmentTenant != nil{
            dictionary["appartment_tenant"] = appartmentTenant
        }
        if isDefault != nil{
            dictionary["is_default"] = isDefault
        }
        if g_location != nil{
            dictionary["g_location"] = g_location
        }
        if accuracy != nil{
            dictionary["accuracy"] = accuracy
        }
        if premiseId != nil{
            dictionary["unique_property_id"] = premiseId
        }

		return dictionary
	}

    func encode(with coder: NSCoder) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
    
}
