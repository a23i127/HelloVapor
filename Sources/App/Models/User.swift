//
//  File.swift
//  HelloVapor
//
//  Created by 高橋沙久哉 on 2024/12/09.
//

import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID var id: UUID?
    @Field(key: "name") var name: String//カラム
    @Field(key: "username") var username: String
    
    init() {}
    init(id: UUID? = nil, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
