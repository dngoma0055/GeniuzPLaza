//
//  JsonResponse.swift
//  GeniusPLaza
//
//  Created by davy ngoma mbaku on 8/10/19.
//  Copyright © 2019 davy ngoma mbaku. All rights reserved.
//

import Foundation

class JsonResponse: ErrorResponse {
    var code: Int?
    var message: String?
    
    public private(set) var feed: Feed
}

class Feed: Codable {
    public private(set) var title: String?
    public private(set) var id: String?
    public private(set) var author: Author?
    public private(set) var copyright: String?
    public private(set) var country: String?
    public private(set) var icon: String?
    public private(set) var updated: String?
    public private(set) var results: [Results]
}

class Author: Codable {
    public private(set) var name: String?
    public private(set) var uri: String?
}

class Results : Codable{
    public private(set) var artistName: String?
    public private(set) var id: String?
    public private(set) var releaseDate: String?
    public private(set) var name: String?
    public private(set) var kind: String?
    public private(set) var copyright: String?
    public private(set) var artistId: String?
    public private(set) var contentAdvisoryRating: String?
    public private(set) var artistUrl: String?
    public private(set) var artworkUrl100: String?
    public private(set) var genre: [Genre]?
    public private(set) var url: String?
}

class Genre: Codable {
    public private(set) var name: String?
}
