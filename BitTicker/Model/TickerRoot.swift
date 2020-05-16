//
//  TickerRoot.swift
//  BitTicker
//
//  Created by Sujith RK on 15/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import Foundation

enum TickerRoot: Codable {
    case integer(Int)
    case unionArray([Ticker])
    case null

    // decode depend on the type
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode([Ticker].self) {
            self = .unionArray(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(TickerRoot.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TickerRoot"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .unionArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Ticker: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Ticker.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Ticker"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

typealias BaseTicker = [TickerRoot]

extension Array where Element == BaseTicker.Element {
    init(data: Data) throws {
        self = try Helper.newJSONDecoder().decode(BaseTicker.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try Helper.newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
