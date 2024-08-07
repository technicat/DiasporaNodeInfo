//
//  NodeInfoV2.swift
//  
//
//  Created by Philip Chu on 6/8/24.
//

public typealias NodeInt = Int64

/// common interface for v0-v2
public protocol NodeInfoV2 {
  var version: String { get }

  var softwareName: String { get }
  var softwareVersion: String { get }
  var softwareHomepage: String? { get }
  var softwareRepository: String? { get }

  var protocolTypes: [String] { get }

  var servicesInbound: [String] { get }
  var servicesOutbound: [String] { get }

  /// Whether this server allows open self-registration.
  var openRegistrations: Bool { get }

  var totalUsers: NodeInt? { get }

  /// The amount of users that signed in at least once in the last 180 days.
  var activeHalfyear: NodeInt? { get }

  /// The amount of users that signed in at least once in the last 30 days.
  var activeMonth: NodeInt? { get }

  var localPosts: NodeInt? { get }

  var localComments: NodeInt? { get }

  /// Free form key value pairs for software specific values. Clients should not rely on any specific key present.
  ///
  /// - Note: the spec defines this as mandatory field but Lemmy ignores it as of `0.19`
  var metadata: [String: JSON]? { get }
}

extension DiasporaNodeInfo.v2_0.NodeInfo: NodeInfoV2 {

  public var softwareName: String {
    software.name
  }

  public var softwareVersion: String {
    software.version
  }

  public var softwareHomepage: String? {
    return nil
  }

  public var softwareRepository: String? {
    return nil
  }

  public var protocolTypes: [String] {
    protocols.map { $0.rawValue }
  }

  public var servicesInbound: [String] {
    services?.inbound.map { $0.rawValue } ?? []
  }

  public var servicesOutbound: [String] {
    services?.outbound.map { $0.rawValue } ?? []
  }

  public var totalUsers: NodeInt? {
      usage.users.total?.value
  }

  public var activeHalfyear: NodeInt? {
      usage.users.activeHalfyear?.value
  }

  public var activeMonth: NodeInt? {
      usage.users.activeMonth?.value
  }

  public var localPosts: NodeInt? {
      usage.localPosts?.value
  }

  public var localComments: NodeInt? {
      usage.localComments?.value
  }
}

extension DiasporaNodeInfo.v2_1.NodeInfo: NodeInfoV2 {

  public var softwareName: String {
    software.name
  }

  public var softwareVersion: String {
    software.version
  }

  public var softwareHomepage: String? {
    software.homepage
  }

  public var softwareRepository: String? {
    software.repository
  }

  public var protocolTypes: [String] {
    protocols.map { $0.rawValue }
  }

  public var servicesInbound: [String] {
    services?.inbound.map { $0.rawValue } ?? []
  }

  public var servicesOutbound: [String] {
    services?.outbound.map { $0.rawValue } ?? []
  }

  public var totalUsers: NodeInt? {
      usage.users.total?.value
  }

  public var activeHalfyear: NodeInt? {
      usage.users.activeHalfyear?.value
  }

  public var activeMonth: NodeInt? {
      usage.users.activeMonth?.value
  }

  public var localPosts: NodeInt? {
      usage.localPosts?.value
  }

  public var localComments: NodeInt? {
      usage.localComments?.value
  }
}

extension DiasporaNodeInfo.v2_2.NodeInfo: NodeInfoV2 {

  public var softwareName: String {
    software.name
  }

  public var softwareVersion: String {
    software.version
  }

  public var softwareHomepage: String? {
    software.homepage
  }

  public var softwareRepository: String? {
    software.repository
  }

  public var protocolTypes: [String] {
    protocols.map { $0.rawValue }
  }

  public var servicesInbound: [String] {
    services?.inbound.map { $0.rawValue } ?? []
  }

  public var servicesOutbound: [String] {
    services?.outbound.map { $0.rawValue } ?? []
  }

  public var totalUsers: NodeInt? {
      usage.users.total?.value
  }

  public var activeHalfyear: NodeInt? {
      usage.users.activeHalfyear?.value
  }

  public var activeMonth: NodeInt? {
      usage.users.activeMonth?.value
  }

  public var localPosts: NodeInt? {
      usage.localPosts?.value
  }

  public var localComments: NodeInt? {
      usage.localComments?.value
  }
}

extension NodeInfoManager {

  public func getInfo(for domain: String) async throws -> NodeInfoV2 {
    let info = try await fetch(for: domain)
    switch info {
    case .v2_0(let info): return info
    case .v2_1(let info): return info
    case .v2_2(let info): return info
    }
  }

}
