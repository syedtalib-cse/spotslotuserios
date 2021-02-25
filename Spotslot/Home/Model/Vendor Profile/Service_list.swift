

import Foundation
import ObjectMapper
/*
 "id": "1",
 "vendor_id": "2",
 
 "group_name": "Basic Group",
 "minimum_people": "5 person(s)",
 
 "service_id": "1",
 
 "group_method_type": "1",
 "price_discount": "30%",
 "usual_price": "50",
 "price": "35",
 "available_status": "1",
 "created_at": "2020-08-29 00:30:53",
 "updated_at": "2020-08-29 00:30:53"
 "id": "1",
 "vendor_id": "2",
 
 "package_name": "Basic Package",
 "description": "Fade cut,Beard cut,moustache and beard wash",
 
 "service_id": "6",
 "usual_price": "50",
 "price": "35",
 "available_status": "0",
 "created_at": "2020-08-29 11:30:53",
 "updated_at": "2020-08-29 11:30:53"
 */

struct Service_list : Mappable {
	var id : String?
	var vendor_id : String?
	var service_name : String?
    
    var subcription_name:String?
    var period_subcription:String?
    var number_appointment_subcription:String?
    var hour_each_appointment:String?
    var usual_price:String?
   
    var group_name:String?
    var minimum_people:String?
    var group_method_type:String?
    var price_discount:String?
    var service_type:String?
    var package_name:String?
  
  	var description : String?
	var category_id : String?
	var price : String?
	var service_charge : String?
	var durantion : String?
	var available_status : String?
	var created_at : String?
	var updated_at : String?
    var isSelected :Bool?
	init?(map: Map) {
	}

	mutating func mapping(map: Map) {
		id <- map["id"]
		vendor_id <- map["vendor_id"]
		service_name <- map["service_name"]
		description <- map["description"]
		category_id <- map["category_id"]
		price <- map["price"]
		service_charge <- map["service_charge"]
		durantion <- map["durantion"]
		available_status <- map["available_status"]
		created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        subcription_name <- map["subcription_name"]
        period_subcription <- map["period_subcription"]
        number_appointment_subcription <- map["number_appointment_subcription"]
        hour_each_appointment <- map["hour_each_appointment"]
        usual_price <- map["usual_price"]
        group_name <- map["group_name"]
        minimum_people <- map["minimum_people"]
        group_method_type <- map["group_method_type"]
        package_name <- map["package_name"]
        price_discount <- map["price_discount"]
        service_type <- map["service_type"]
        isSelected = false
	}

}

