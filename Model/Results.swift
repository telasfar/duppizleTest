//
//  ViewController.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import Foundation
struct Results : Codable {
	let created_at : String?
	let price : String?
	let name : String?
	let uid : String?
	let image_ids : [String]?
	let image_urls : [String]?
	let image_urls_thumbnails : [String]?

	enum CodingKeys: String, CodingKey {

		case created_at = "created_at"
		case price = "price"
		case name = "name"
		case uid = "uid"
		case image_ids = "image_ids"
		case image_urls = "image_urls"
		case image_urls_thumbnails = "image_urls_thumbnails"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		uid = try values.decodeIfPresent(String.self, forKey: .uid)
		image_ids = try values.decodeIfPresent([String].self, forKey: .image_ids)
		image_urls = try values.decodeIfPresent([String].self, forKey: .image_urls)
		image_urls_thumbnails = try values.decodeIfPresent([String].self, forKey: .image_urls_thumbnails)
	}

}
