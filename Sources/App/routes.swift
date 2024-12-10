import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    app.get("hello", ":name") { req -> String in
        let name = try req.parameters.require("name")
        return "Hello, \(name)"
    }
    struct Bottles: Content {
        var count: Int
    }
    struct User: Content {
        var name: String
        var age: Int
    }
    app.get("bottles",":count") { req -> Bottles in
        let count = try req.parameters.require("count", as: Int.self)
        return Bottles(count: count)//JSON形式で返却
    }
    app.post("bottles") { req -> String in
        let bottles = try req.content.decode(Bottles.self)
        return "There were\(bottles.count) bottles"
    }
    app.post("user") { req -> String in
        let user = try req.content.decode(User.self)
        return "Hello \(user.name), you are \(user.age) years old"
    }
    try app.register(collection: TodoController())
    try app.register(collection: UserController())
}
