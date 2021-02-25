/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Vendors : Mappable {
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
	var allergies_important : String?
	var cut_hair_session : String?
	var notification_status : String?
	var created_at : String?
	var updated_at : String?

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
		allergies_important <- map["allergies_important"]
		cut_hair_session <- map["cut_hair_session"]
		notification_status <- map["notification_status"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
	}

}