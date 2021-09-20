//
//  Models.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import Foundation

// MARK: - Weather

struct Weather: Codable {
    let now: Int
    let fact: Fact
    let info: Info
}

struct Fact: Codable {
    let temp: Int
    let feels_like: Int
    let condition: String
    let season: String
    let icon: String
}

struct Info: Codable {
    let tzinfo: Tzinfo
}

struct Tzinfo: Codable {
    let name: String
}

// MARK: - Looking for lat/lon

struct CoordinatesElement: Codable {
    let lat: String
    let lon: String
}

typealias Coordinates = [CoordinatesElement]


