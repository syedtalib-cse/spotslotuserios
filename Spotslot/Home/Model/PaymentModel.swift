

import Foundation
import ObjectMapper

struct PaymentModel : Mappable {
	var user_id : String?
	var customer_name : String?
	var email : String?
	var currency : String?
	var amount : Int?
	var transaction_id : String?
	var charge_id : String?
	var stripe_status : String?
	var payment_status : String?
	var payment_card_id : String?
	var receipt_url : String?
	var payment_id : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		user_id <- map["user_id"]
		customer_name <- map["customer_name"]
		email <- map["email"]
		currency <- map["currency"]
		amount <- map["amount"]
		transaction_id <- map["transaction_id"]
		charge_id <- map["charge_id"]
		stripe_status <- map["stripe_status"]
		payment_status <- map["payment_status"]
		payment_card_id <- map["payment_card_id"]
		receipt_url <- map["receipt_url"]
		payment_id <- map["payment_id"]
	}

}
