

import Foundation
import ObjectMapper

struct PaymentMethodList : Mappable {
	var id : String?
    var user_id : String?
    var payment_type : String?
    var payment_method : String?
    var card_number : String?
    var card_holder_name : String?
    var card_valid_true : String?
    var card_cvv : String?
    var email : String?
    var isActive : String?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var isActives :Bool?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        payment_type <- map["payment_type"]
        payment_method <- map["payment_method"]
        card_number <- map["card_number"]
        card_holder_name <- map["card_holder_name"]
        card_valid_true <- map["card_valid_true"]
        card_cvv <- map["card_cvv"]
        email <- map["email"]
        isActive <- map["isActive"]
        if isActive == "1"{
            isActives = true
        }else{
            isActives = false
        }
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
    }

}
