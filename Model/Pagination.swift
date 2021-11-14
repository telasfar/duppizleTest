//
//  ViewController.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import Foundation
struct Pagination : Codable {
	let key : String?

	enum CodingKeys: String, CodingKey {

		case key = "key"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		key = try values.decodeIfPresent(String.self, forKey: .key)
	}

}
