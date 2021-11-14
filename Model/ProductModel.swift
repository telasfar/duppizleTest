//
//  ViewController.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import Foundation
struct ProductModel : Codable {
	let results : [Results]?
	let pagination : Pagination?

	enum CodingKeys: String, CodingKey {

		case results = "results"
		case pagination = "pagination"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		results = try values.decodeIfPresent([Results].self, forKey: .results)
		pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
	}

    init(results:[Results]){
        self.results = results
        pagination = nil
    }
}
