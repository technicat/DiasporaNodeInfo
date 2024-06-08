//
//  JSONValue.swift
//  
//
//  Created by Philip Chu on 6/8/24.
//

// extract values from JSON
// especially handy for printing the nodeinfo metadata
extension JSON {

  public var value: Any? {
    switch self {
    case .number(let val): return val
    case .bool(let val): return val
    case .string(let val): return val
    case .array(let val):
      return val.map { $0.value }
    case .object(let val):
      return val.mapValues { $0.value }
    case .null: return nil
    }
  }
}
