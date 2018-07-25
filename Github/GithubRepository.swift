//
//  Repository.swift
//  GithubClient
//
//  Created by Sajad on 7/1/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation

public struct GithubRepository: Codable {
    
    public let id: Int
    public let name: String
    public let fullName: String
    public let owner: GithubOwner
    public let isPrivate: Bool
    public let description: String?
    public let createdAt: String?
    public let size: Int?
    public let language: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case isPrivate = "private"
        case createdAt = "created_at"
        case id, name, description,size, language, owner
    }
        
    static func decodeDataWithArrayType(data: Data) -> [GithubRepository]? {
        return try? JSONDecoder().decode([GithubRepository].self, from: data)
    }
}

extension GithubRepository: SearchResultItem {
    public var title: String {
        return name
    }
    public var subtitle: String {
        return fullName
    }
}

extension GithubRepository {
    public var createdDate: Date? {
        if let dateString = createdAt {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter.date(from: dateString)
        }
        return nil
    }
}
