

import Foundation
import ObjectMapper

struct About : Mappable {
	var id : String?
	var user_type : String?
	var criminal_record_status : String?
	var plan_id : String?
	var language_id : String?
	var name : String?
	var user_name : String?
	var gender : String?
	var email : String?
	var forgot_password_code : String?
	var password : String?
	var actual_password : String?
	var dob : String?
	var address : String?
	var bio : String?
	var profile_image : String?
	var background_img : String?
	var referal_code : String?
	var mobile_number : String?
	var allergies : String?
	var haircut_freuency : String?
	var status : String?
	var is_available : String?
	var is_profile_verify : String?
	var tier_level : String?
	var device_type : String?
	var device_id : String?
	var token : String?
	var latitude : String?
	var longitude : String?
	var created_at : String?
	var updated_at : String?
	var avag_rating : Int?
	var total_rate_user : Int?
	var rating_list : [Rating_list]?
	var languages : String?
    var isBookmark:Int?
    var time_slot : Time_slot?
    init() {
    }
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		user_type <- map["user_type"]
		criminal_record_status <- map["criminal_record_status"]
		plan_id <- map["plan_id"]
		language_id <- map["language_id"]
		name <- map["name"]
		user_name <- map["user_name"]
		gender <- map["gender"]
		email <- map["email"]
		forgot_password_code <- map["forgot_password_code"]
		password <- map["password"]
		actual_password <- map["actual_password"]
		dob <- map["dob"]
		address <- map["address"]
		bio <- map["bio"]
		profile_image <- map["profile_image"]
		background_img <- map["background_img"]
		referal_code <- map["referal_code"]
		mobile_number <- map["mobile_number"]
		allergies <- map["allergies"]
		haircut_freuency <- map["haircut_freuency"]
		status <- map["status"]
		is_available <- map["is_available"]
		is_profile_verify <- map["is_profile_verify"]
		tier_level <- map["tier_level"]
		device_type <- map["device_type"]
		device_id <- map["device_id"]
		token <- map["token"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		avag_rating <- map["avag_rating"]
		total_rate_user <- map["total_rate_user"]
		rating_list <- map["rating_list"]
		languages <- map["languages"]
        isBookmark <- map["isBookmark"]
        time_slot <- map["time_slot"]
	}

}
