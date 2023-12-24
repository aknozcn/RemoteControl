//
//  SocketManager.swift
//  RemoteControl
//
//  Created by Akın Özcan on 4.12.2023.
//

import Foundation

class SocketManager {

    static let shared = SocketManager()
    private init() { }
    var client = Client(host: "", port: 5001)
    @Published var currentVolume: Float = 0.0

    func connectServer(host: String, port: UInt16) {
        client = Client(host: host, port: port)
        client.start()
    }

    func sendData(actionType: ActionType, data: String) {
        client.connection.send(data: "\(actionType.rawValue),\(data)".data(using: .utf8) ?? Data())
    }
}
