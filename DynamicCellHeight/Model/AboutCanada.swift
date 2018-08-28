//
//  AboutCanada.swift
//  DynamicCellHeight
//
//  Created by Nagesh on 17/06/18.
//  Copyright © 2018 Nagesh Kumar Mishra. All rights reserved.
//

import Foundation

struct AboutCanada : Codable {
    let title : String?
    let rows : [Rows]?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case rows = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
    }
    
}
