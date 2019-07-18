//
//  User.swift
//  ContactList-App
//

import Foundation

struct UserBase: Codable {
    let results: [User]
}

struct UserName: Codable {
    let title: String
    let first: String
    let last: String
}

struct User : Codable {
    let name: UserName
    let email: String
    let location : Location
    let phone: String
    let cell: String
    let picture: Picture
}

struct Location : Codable {
    let street: String
    let city: String
}

struct Picture : Codable {
    let thumbnail: String
    let large: String
}
