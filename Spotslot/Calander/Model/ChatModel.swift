
import Foundation
import ObjectMapper

struct ChatModel : Mappable {
	var id : String?
	var sender_id : String?
	var reciever_id : String?
	var message : String?
	var read_status : String?
	var msg_type : String?
	var created_at : String?
	var updated_at : String?
	var deleted_at : String?
	var type : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		sender_id <- map["sender_id"]
		reciever_id <- map["reciever_id"]
		message <- map["message"]
		read_status <- map["read_status"]
		msg_type <- map["msg_type"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		deleted_at <- map["deleted_at"]
		type <- map["type"]
	}

}
