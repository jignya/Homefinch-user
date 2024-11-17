//
//  ChatConstants.swift
//  ChatQuickstart
//
//  Created by Jeffrey Linwood on 3/28/20.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

import Foundation

// Important - update this URL with your Twilio Function URL
// Important - this function must be protected in production
// and actually check if user could be granted access to your chat service.

// For the below compile error
// You will need to uncomment the string constant assignment
// And replace YOUR_TWILIO_FUNCTION_DOMAIN_HERE with your subdomain


// TWIlio Credential
//let TW_Account_Id = "ACdfec167f0c9d74c55fc834f7eef5e660" // Trial account
//let TW_Auth_Token = "384132b0801350edb2514d94034d200e"
//let TW_Verify_Sercice_Id = "VAd0a3ee8c45de1118eee94f8355fc03da"

let TW_Account_Id1 = "AC53b75fa4937e3722f7fb868301f9012a" // Live
let TW_Auth_Token1 = "40f889947bde6b5cbe2e84cff2cc5d0f"
let Verify_Sercice_Id = "VA11a53bfae5642032945882774cc6be9d"



// Chat Token URL from backend
let TOKEN_URL = "https://homefinch.viitor.cloud/api/token"


// Google API key
let Google_place_API_key = "AIzaSyBz5KCKW9GiM0i5eL2XjONrbOYvRbY2_Jc"
let Google_map_API_key = "AIzaSyBRdbJkBzHtot5_XTkZfBu4dXrohQU2obA"


//MARK: Radar Credential

var radar_PublishKey = "prj_live_pk_b6436901e9865f918df3eccafd3a3cf58e97ab36"
var radar_SecretKey = "prj_live_sk_d39745d409a7899b9347d25f6edef3ae125131bd" 


//TEST CHAT CRED------------------------------------------------------------------
//
//TWILIO_AUTH_SID=384132b0801350edb2514d94034d200e
//TWILIO_API_SID=ACdfec167f0c9d74c55fc834f7eef5e660
//TWILIO_API_SECRET=SKe12df5fb3be6b190e697b5cb2353002a
//TWILIO_SERVICE_SID=ISaced7d96b69249c5851dff2de393c9e8
//let TWILIO_PUSH_SID = CRa03a697083f3a1dd6c52c55d9ae63ce0 //- iOS
//
//LIVE CHAT CRED------------------------------------------------------------------
//
//TWILIO_AUTH_SID= 40f889947bde6b5cbe2e84cff2cc5d0f
//TWILIO_API_SID= AC53b75fa4937e3722f7fb868301f9012a
//TWILIO_API_SECRET= SKd9f331b517e870c986ef03bc77c5978f
//TWILIO_SERVICE_SID= ISc134dbc1a5d94041a4559e74757a5101
//TWILIO_PUSH_SID= CRcc1f76e36d5b40bab6565500148bda6a. (iOS)


// PayTabs

var pt_profileID = "66287"
var pt_serverKey = "S6JNRGNDDJ-JBL2JKDJTZ-GTWHLBK2TB" // SDK key
var pt_clientKey = "CRKM6P-2MKN62-BM6KD6-BPDQN6"


var pt_serverapiKey = "S6JNRGNDHJ-JBL2JKDJWZ-9J2DTH6HD2"  // api key
var pt_clientapiKey = "CQKM6P-2MHQ62-BM6KD6-KK7QMD"
