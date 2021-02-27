//
//  Constant.swift
//  SplotslotVendor
//
//  Created by mac on 05/10/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import Foundation

let dateOfBirthFormate = "yyyy-MM-dd"
let appName = "Spotslot"
//let travelFee = 10




struct SignUpPara {
    static let first_name = "first_name"
    static let last_name = "last_name"
    static let email = "email"
    static let dob = "dob"
    static let password = "password"
    static let device_id = "device_id"
    static let device_type = "device_type"
    static let user_name = "user_name"
    static let referal_code = "referal_code"
}

struct Messge {
    static let deleteMessage = "Are you sure you want to delete this Service"
    static let deletePackageMessage = "Are you sure you want to delete this Package"
    static let deleteSubscriptionMessage = "Are you sure you want to delete this Subscription"
    static let deleteGroupMessage = "Are you sure you want to delete this Group"
    static let deletePortaFolioMessage = "Are you sure you want to delete this Portfolio"
    static let messageToUpdatePortFolio = "Please Selct picture from Camera/Gallery"
    static let messageToDeleteAdd = "Delete"
    static let messageToMainAdd = "Set as Main Address"
    static let messageToEditAdd = "Edit Address"
    
    
    
}


enum GenralText:String {
    case Available_Now = "Available Now"
    case Regular_Booking = "Regular Booking"
    case currency = "£"
    case packageEdit =  "Edit Package"
    case PackageAdd =  "Add Package"
    case isLoggedIn = "LoggedIn"
    case request = "request"
    case confirm = "confirm"
    case available = "available"
    case Incoming = "Incoming"
    case Outgoing = "Outgoing"
}


//service/group/packeg/subscription
enum ServiceType:String {
    case service
    case group
    case package
    case subscription
}


enum CategoryType:String {
    case Packages = "Packages"
    case Subscription = "Subscription"
    case GroupOffers = "Group Offers"
    case service = "service"
   
}

enum Gender:String {
    case male = "male"
    case female = "female"
    case other = "other"
}

//["Credit/Debit Card","Apple Pay","Google Pay"]
enum CardMthod :String{
    case Google_Pay = "Google Pay"
    case Credit_Debit_Card = "Credit/Debit Card"
    case Apple_pay = "Apple Pay"
}


//male
enum ParametersKey : String {
    
    case customer_id
    case new_password
    case code
    case confirm_password
    case latitude
    case longitude
    case filter_key
    
    case language_name
    case vendor_id
    case user_name
    case category_id
    case category_name
    case service_type
    case available_status
    
    case specialization_id
    case gender
    case rating
    
    //to add/Edit/Delete service
    case service_name
    case description
    case price
    case service_charge
    case duration
    case regular_service_id
    
    //to add package
    case package_name
    case service_id
    case usual_price
    case package_id
    
    //for subcription
    case subcription_name
    case period_subcription//2 month(s)
    case number_appointment_subcription//5 appointment(s)
    case hour_each_appointment//3 hour(s) each
    case subscription_id
    
    //for Group
    case group_name
    case minimum_people
    case method_type
    case price_discount
    case group_id
    
    
    //Portfolio
    case portfolio_id
    
    //to update location
    case address
    //case vendor_id
    //case service_id
    //case service_type
    case appointment_date
    case primary_time_slot_id
    case secondary_time_slot_id
    //case address
    //case duration
    case travel_fee
    case service_fee
    case total_service_fee
    case payment_method
    //case latitude
    //case longitude
    
    case address_name
    case location
    case user_address_id
    case current_password
    
    //for profile updation
    case language
    case full_name
    case dob
    case allergies_important
    case cut_hair_session
    case image
    
    //card details
    case type
    // case payment_method
    case card_number
    case card_holder_name
    case card_valid_true
    case card_cvv
    case email
    case payment_method_id
    
    //to rate the user
    // case rating
    case quality_service_id
    case quality_service_name
    case review
    
    // case vendor_id
    case tip
    case search_keyword
    case no_of_person
    case status
    case booking_id
    case to_id
    case message
    case stripeToken
    case payment_card_id
    case amount
    case transaction_id
    case payment_status
    case payment_id
    
}
