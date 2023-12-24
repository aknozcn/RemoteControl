//
//  ContentView.swift
//  RemoteControl
//
//  Created by Akın Özcan on 30.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            VolumeView()
                .tabItem {	
                    Label("Volume", systemImage: "speaker.2.fill")
                }

            URLView()
                .tabItem {
                    Label("URL", systemImage: "link")
                }
        }.onAppear{
            SocketManager.shared.connectServer(host: "localhost", port: 5001)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}




