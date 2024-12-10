//
//  File.swift
//  HelloVapor
//
//  Created by 高橋沙久哉 on 2024/12/09.
//

import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post("api", "users", use: createHandler)
        routes.get("api", "users", use: getAllHandler)
        routes.put("api","users",":userID",use: updateHandler)
        routes.delete("api","users",":userID",use: deletHandler)
    }
    func createHandler(req: Request) async throws -> User {
        let user = try req.content.decode(User.self)
        try await user.save(on: req.db)
        return user
    }
    func getAllHandler(req: Request) async throws -> [User] {
        try await User.query(on: req.db).all()
    }
    func updateHandler(req: Request) async throws -> User {
        let updateUser = try req.content.decode(User.self)
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        user.name = updateUser.name
        user.name = updateUser.username
        try await user.save(on:req.db)
        return user
    }
    func deletHandler(req: Request) async throws -> HTTPStatus {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return .ok
    }
}
