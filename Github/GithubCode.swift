//
//  Code.swift
//  GithubClient
//
//  Created by Sajad on 7/3/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
public struct GithubCode: Codable {
    let name: String
    let repository: GithubRepository
    let path: String
    
    static func decodeDataWithArrayType(data: Data) -> [GithubCode]? {
        return try? JSONDecoder().decode([GithubCode].self, from: data)
    }
}

extension GithubCode: SearchResultItem {
    public var title: String {
        return name
    }
    public var subtitle: String {
        return path
    }
}

