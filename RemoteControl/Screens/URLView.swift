//
//  URLView.swift
//  RemoteControl
//
//  Created by Akın Özcan on 2.12.2023.
//

import SwiftUI

struct URLView: View {
    @State private var urlText: String = "https://www.youtube.com"

    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center) {
                HStack {
                    NeumorphicStyleTextField(textField: TextField("Enter a URL...", text: $urlText), imageName: "network")
                }
                .padding(.horizontal, 16)

                Button {
                    if !urlText.isEmpty {
                        SocketManager.shared.sendData(actionType: .openUrl, data: urlText)
                    }
                } label: {
                    Text("Go to URL")
                }
                .buttonStyle(NeumorphicStyleButton())
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

struct UrlView_Previews: PreviewProvider {
    static var previews: some View {
        URLView()
    }
}
