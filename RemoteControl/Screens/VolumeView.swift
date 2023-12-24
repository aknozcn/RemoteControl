//
//  VolumeView.swift
//  RemoteControl
//
//  Created by Akın Özcan on 2.12.2023.
//

import SwiftUI

struct VolumeView: View {
    @State var progress: CGFloat = 1.0
    @State var startAnimation: CGFloat = 0
    @State private var position = CGPoint(x: 100, y: 0)
    @State private var dragOffset = CGSize.zero
    let maskSize = CGSize(width: 122, height: 400)
    @State private var sliderValue = 1.0
    @State private var receivedVolume: CGFloat = 0.0
    @State var maxHeight: CGFloat = 420
    @State var sliderHeight: CGFloat = 0
    @State var sliderProgress: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    @State private var backgroundColor = Color(UIColor(hex: "#3d85c6"))
    @State private var backgroundOffset: CGFloat = 0
    @State private var didSetInitialVolume = false
    @State private var isMuted = false
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let size = proxy.size
                ZStack {
                    ZStack {

                        ZStack(alignment: .top, content: {
                      
                            Text("\(Int((sliderProgress * (100))))")
                        
                                .fontWeight(.bold)
                                .foregroundColor(Color(UIColor(hex: "#3d85c6")).opacity(0.6))
                                .padding(.vertical, 10)
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 18)
                                .font(.system(size: 120))
                                .cornerRadius(12)
                        })
                        HStack(alignment: .center, content: {
                            Button {
                                isMuted.toggle()
                                if isMuted {
                                    SocketManager.shared.sendData(actionType: .mute, data: "0.0")
                                } else {
                                    SocketManager.shared.sendData(actionType: .unMute, data: "")
                                }
                              
                            } label: {
                                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.3.fill")

                            }.padding()
                            Spacer()
                        })

                    }
                        .frame(width: size.width, height: size.height, alignment: .top)
                        .offset(y: -10)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                            LinearGradient(gradient: Gradient(colors: [
                                Color(UIColor(hex: "#3d85c6"))
                                ]), startPoint: .top, endPoint: .bottom))
                            .frame(width: 50, height: 406)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 32)
                            .opacity(0.8)
                            .offset(x: -50, y: 0)
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                            LinearGradient(gradient: Gradient(colors: [
                                Color(UIColor(hex: "#ECECEC")),
                                Color(UIColor(hex: "#FFFFFF")),

                                ]), startPoint: .top, endPoint: .bottom)
                        )
                            .frame(width: 96, height: 456)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .opacity(0.8)

                        WaterWaveS(progress: sliderProgress, waveHeight: 0.04, offset: startAnimation + 190)
                            .fill(
                            LinearGradient(gradient: Gradient(colors: [
                                Color(UIColor(hex: "#3d85c6"))
                                ]), startPoint: .top, endPoint: .bottom)
                        )
                            .frame(width: 96, height: 456)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .overlay(
                            Capsule()
                                .stroke(Color(red: 236 / 255, green: 234 / 255, blue: 235 / 255),
                                lineWidth: 1)
                                .shadow(color: Color.black.opacity(0.7), radius: 10, x: 0, y: 0)
                                .clipShape(
                                Capsule()
                            )
                        )

                        WaterWaveS(progress: sliderProgress, waveHeight: 0.04, offset: startAnimation)
                            .fill(
                            LinearGradient(gradient: Gradient(colors: [
                                Color(UIColor(hex: "#3d85c6"))
                                ]), startPoint: .top, endPoint: .bottom)
                        )
                            .frame(width: 96, height: 456)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .opacity(0.5)
                        RoundedRectangle(cornerRadius: 54)
                            .strokeBorder(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.8), Color(red: 0.93, green: 0.94, blue: 0.97, opacity: 1)]), startPoint: .top, endPoint: .bottom)
                            , lineWidth: 6)
                            .frame(width: 108, height: 468)


                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 26, height: 390)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 7)
                            .opacity(0.5)
                            .blendMode(.overlay)
                            .offset(x: 16, y: 0)

                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(width: 12, height: 370)
                            .mask(RoundedRectangle(cornerRadius: 48))
                            .blur(radius: 4)
                            .opacity(0.3)
                            .blendMode(.overlay)
                            .offset(x: -24, y: 0)

                    }

                        .frame(width: size.width, height: size.height, alignment: .center)
                        .onAppear {
                        withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: false)) {
                            startAnimation = size.width
                            didSetInitialVolume = true
                        }
                    }
                    ZStack {
                        VStack {
                            ZStack {

                                Rectangle()
                                    .fill(getModifiedColor(Color.teal))
                                    .frame(height: 1000)
                                    .cornerRadius(10)
                                    .padding(8)

                                Rectangle()
                                    .fill(.red)
                                    .frame(width: 100, height: 100)
                                    .blur(radius: 8)
                            }
                                .mask(Image("curve-nob"))
                                .offset(x: -24, y: position.y + 210 - sliderHeight)

                        }
                            .frame(width: 200)
                            .mask(
                            LinearGradient(gradient: Gradient(colors: [.clear, .black, .black, .black, .clear]), startPoint: .top, endPoint: .bottom)
                                .frame(height: maxHeight + 100)
                        )

                        VStack {
                            ZStack(alignment: .bottom, content: {
                                Rectangle()
                                    .fill(Color(.gray).opacity(0.01))
                            })
                                .frame(width: 120, height: maxHeight)
                                .cornerRadius(32)
                                .gesture(DragGesture(minimumDistance: 0).onChanged({ (value) in
                                    let translation = value.translation
                                    sliderHeight = -translation.height + lastDragValue
                                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                                    let progres = sliderHeight / maxHeight
                                    sliderProgress = progres <= 1.0 ? progres : 1


                                    let formattedValue = String(format: "%.2f", sliderProgress)

                                    SocketManager.shared.sendData(actionType: .volume, data: formattedValue)


                                }).onEnded({ (value) in
                                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                                    lastDragValue = sliderHeight
                                    UserDefaultsManager.shared.set(sliderHeight, for: .sliderHeight)
                                    UserDefaultsManager.shared.set(lastDragValue, for: .lastDragValue)
                                }))

                        }.offset(y: 0)
                        VStack {
                            Image("nob")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .offset(x: 0, y: -sliderHeight)
                        }
                            .frame(width: 120, height: maxHeight + 48, alignment: .bottom)
                            .zIndex(-1)
                    }
                        .frame(width: 200, height: 600)
                        .offset(x: 130)
                }
            }
        }.onReceive(SocketManager.shared.$currentVolume) { newVolume in
            if didSetInitialVolume {
                receivedVolume = CGFloat(newVolume)
                sliderProgress = receivedVolume
                if let height = UserDefaultsManager.shared.get(for: .sliderHeight) as? CGFloat {
                    sliderHeight = height
                }
                
                if let dragValue = UserDefaultsManager.shared.get(for: .lastDragValue) as? CGFloat {
                    lastDragValue = dragValue
                }
            }
        }
    }
    
    private func getModifiedColor(_ color: Color) -> Color {
        let teal = Color.teal
        let green = Color.green
        let yellow = Color.yellow
        let orange = Color.orange
        let red = Color.red

        switch sliderProgress {
        case 0..<0.125:
            return blendColors(teal, green, fraction: sliderProgress / 0.125)
        case 0.125..<0.25:
            return blendColors(green, yellow, fraction: (sliderProgress - 0.125) / 0.125)
        case 0.25..<0.5:
            return blendColors(yellow, orange, fraction: (sliderProgress - 0.25) / 0.25)
        case 0.5..<0.75:
            return blendColors(orange, red, fraction: (sliderProgress - 0.5) / 0.25)
        case 0.75...1:
            return red
        default:
            return color
        }
    }

    private func blendColors(_ color1: Color, _ color2: Color, fraction: Double) -> Color {
        let cgColor1 = color1.cgColor
        let cgColor2 = color2.cgColor

        guard let components1 = cgColor1?.components, let components2 = cgColor2?.components else {
            return color1
        }

        let red = components1[0] * (1 - fraction) + components2[0] * fraction
        let green = components1[1] * (1 - fraction) + components2[1] * fraction
        let blue = components1[2] * (1 - fraction) + components2[2] * fraction
        let alpha = components1[3] * (1 - fraction) + components2[3] * fraction

        return Color(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
    }
}

struct VolumeView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeView()
    }
}
