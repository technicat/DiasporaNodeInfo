//
// Copyright (c) 2023, Denis Dzyubenko <denis@ddenis.info>
//
// SPDX-License-Identifier: BSD-2-Clause
//

import Foundation

public enum NodeInfo {
    /// NodeInfo schema version 2.0
    case v2_0(DiasporaNodeInfo.v2_0.NodeInfo)
    /// NodeInfo schema version 2.1
    case v2_1(DiasporaNodeInfo.v2_1.NodeInfo)
    /// NodeInfo schema version 2.1
    case v2_2(DiasporaNodeInfo.v2_2.NodeInfo)

    /// Returns the version of the NodeInfo schema that is supported by the queried domain.
    public var version: WellKnownNodeInfoSchema {
        switch self {
        case .v2_0: return .v2_0
        case .v2_1: return .v2_1
        case .v2_2: return .v2_2
        }
    }

    /// Returns the value the nodeinfo data assuming it was v2.0 schema; or nil if server supports a different version.
    public var v2_0: DiasporaNodeInfo.v2_0.NodeInfo? {
        if case let .v2_0(value) = self {
            return value
        }
        return nil
    }

    /// Returns the value the nodeinfo data assuming it was v2.1 schema; or nil if server supports a different version.
    public var v2_1: DiasporaNodeInfo.v2_1.NodeInfo? {
        if case let .v2_1(value) = self {
            return value
        }
        return nil
    }
    
    /// Returns the value the nodeinfo data assuming it was v2.2 schema; or nil if server supports a different version.
    public var v2_2: DiasporaNodeInfo.v2_2.NodeInfo? {
        if case let .v2_2(value) = self {
            return value
        }
        return nil
    }
}

extension NodeInfo: Decodable {
    private enum HeaderCodingKeys: CodingKey {
        case version
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HeaderCodingKeys.self)
        let versionString = try container.decode(String.self, forKey: .version)

        switch versionString {
        case "2.0":
            let nodeInfo = try DiasporaNodeInfo.v2_0.NodeInfo(from: decoder)
            self = .v2_0(nodeInfo)

        case "2.1":
            let nodeInfo = try DiasporaNodeInfo.v2_1.NodeInfo(from: decoder)
            self = .v2_1(nodeInfo)
            
        case "2.2":
            let nodeInfo = try DiasporaNodeInfo.v2_2.NodeInfo(from: decoder)
            self = .v2_2(nodeInfo)
            
        default:
            // kludge, iceshrimp.net has instance version
            // now fixed, but keep this here just in case
            // should log a warning, though
            let nodeInfo = try DiasporaNodeInfo.v2_0.NodeInfo(from: decoder)
            self = .v2_0(nodeInfo)
//            throw DecodingError.typeMismatch(NodeInfo.self, .init(
//                codingPath: decoder.codingPath,
//                debugDescription: "Received unsupported NodeInfo version '\(versionString)'"))
        }
    }
}
