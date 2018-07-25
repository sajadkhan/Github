//
//  Owner.swift
//  GithubClient
//
//  Created by Sajad on 7/1/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
public struct GithubOwner: Codable {
    public let id: Int
    public let name: String
    public let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
        case id
    }
    
    static func decodeDataWithArrayType(data: Data) -> [GithubOwner]? {
        return try? JSONDecoder().decode([GithubOwner].self, from: data)
    }
}

extension GithubOwner: SearchResultItem {
    public var title: String {
        return name
    }
}
