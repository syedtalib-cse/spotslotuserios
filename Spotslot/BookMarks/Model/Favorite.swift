

/*
 
 "id": "8",
 "image": "https://anandisha.com/spot_slot/uploads/vendor_portfolio/1602852439_25.png",
 "profile_image": "https://anandisha.com/spot_slot/uploads/user/entertaiment-03.jpg",
 "name": "Sunil Kumar",
 "user_name": "sunil123",
 "user_id": "10",
 "vendor_id": "20",
 "portfolio_id": "13",
 "created_at": "2020-11-02 07:06:22",
 "updated_at": null,
 "deleted_at": null,
 "mark_type": "style"
 */


import Foundation
import ObjectMapper

struct Favorite : Mappable {
	var id : String?
	var image : String?
	var profile_image : String?
	var user_id : String?
	var vendor_id : String?
	var portfolio_id : String?
	var created_at : String?
	var updated_at : String?
	var deleted_at : String?
	var mark_type : String?
    var user_name:String?
    var name:String?
    
	init?(map: Map) {
	}

	mutating func mapping(map: Map) {
		id <- map["id"]
		image <- map["image"]
		profile_image <- map["profile_image"]
		user_id <- map["user_id"]
		vendor_id <- map["vendor_id"]
		portfolio_id <- map["portfolio_id"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		deleted_at <- map["deleted_at"]
        user_name <- map["user_name"]
        name  <- map["name"]
		mark_type <- map["mark_type"]
	}

}
