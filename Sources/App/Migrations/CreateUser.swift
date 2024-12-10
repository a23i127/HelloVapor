//
//  File.swift
//  HelloVapor
//
//  Created by 高橋沙久哉 on 2024/12/09.
//

import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("username", .string, .required)
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
