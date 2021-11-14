//
//  NEUButtonStyle.swift
//  Qin
//
//  Created by 林少龙 on 2021/11/10.
//

import SwiftUI

public protocol NEUButtonStyle: ButtonStyle, NEUStyle {
    
}

public struct NEUDefaultButtonStyle<S: Shape>: NEUButtonStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let shape: S
    let toggle: Bool
    
    public init (shape: S, toggle: Bool = false) {
        self.shape = shape
        self.toggle = toggle
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed || toggle ? 0.9 : 1.0)
            .contentShape(shape)
            .background(
                GeometryReader { geometry in
                    let backgroundColors: [Color] = neuBacgroundColors(colorScheme)
                    let pressedBackgroundColors: [Color] = neuPressedBacgroundColors(colorScheme)
                    
                    if configuration.isPressed || toggle {
                        shape.fill(                            LinearGradient(gradient: Gradient(colors: pressedBackgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                    }else {
                        shape.fill(LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .modifier(NEUShadowModifier())
                    }
                }
            )
    }
}

public struct NEUBorderButtonStyle<S: Shape>: NEUButtonStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let shape: S
    let toggle: Bool
    
    public init (shape: S, toggle: Bool = false) {
        self.shape = shape
        self.toggle = toggle
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed || toggle ? 0.9 : 1.0)
            .contentShape(shape)
            .background(
                GeometryReader { geometry in
                    
                    let backgroundColors: [Color] = colorScheme == .light ? Color.lightBackgroundColors : Color.darkBackgroundColors
                    let pressedBackgroundColors: [Color] = backgroundColors.reversed()
                    
                    if !configuration.isPressed && !toggle {
                        LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .modifier(NEUBorderModifier(shape: shape))
                    } else {
                        LinearGradient(gradient: Gradient(colors: pressedBackgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(shape)
                    }
                }
            )
    }
}

public struct NEUConvexBorderButtonStyle<S: Shape>: NEUButtonStyle {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let shape: S
    let toggle: Bool
    
    public init (shape: S, toggle: Bool = false) {
        self.shape = shape
        self.toggle = toggle
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed || toggle ? 0.9 : 1.0)
            .contentShape(shape)
            .background(
                GeometryReader { geometry in
                    let minLength: CGFloat = min(geometry.size.width, geometry.size.height)
                    
                    let backgroundColors: [Color] = colorScheme == .light ? Color.lightBackgroundColors : Color.darkBackgroundColors
                    
                    let borderColors: [Color] = neuBorderColors(colorScheme)
                    let borderStrokeWidth: CGFloat = minLength / 15
                    
                    let strokeWidth: CGFloat = minLength / 20
                    let topLeftStrokeColor: Color = colorScheme == .light ? .white : .white.opacity(0.11)
                    
                    shape.fill(LinearGradient(colors: backgroundColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .modifier(NEUShadowModifier())
                    shape.stroke(LinearGradient(colors: borderColors, startPoint: .topLeading, endPoint: .bottomTrailing),
                                 lineWidth: borderStrokeWidth)
                    
                    if !configuration.isPressed && !toggle {
                        shape.stroke(topLeftStrokeColor, lineWidth: strokeWidth)
                            .blur(radius: 1)
                            .offset(x: strokeWidth, y: strokeWidth)
                            .mask(shape.padding(borderStrokeWidth / 2))
                    }
                }
            )
    }
}

#if DEBUG
fileprivate struct NEUButtonStyleDebugView: View {
    @State private var onOff = false
    
    var body: some View {
        ZStack {
            NEUBackgroundView()
            VStack(spacing: 50.0) {
                HStack(spacing: 20) {
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: Circle()))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: Circle(), toggle: onOff))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous)))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUDefaultButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous), toggle: onOff))

                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: Circle()))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: Circle(), toggle: onOff))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous)))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous), toggle: onOff))

                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: Circle()))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: Circle(), toggle: onOff))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous)))
                    Button(action: {
                        onOff.toggle()
                    }) {
                        NEUSFView(systemName: "heart.fill", size: .medium)
                    }
                    .buttonStyle(NEUConvexBorderButtonStyle(shape: RoundedRectangle(cornerRadius: 10, style: .continuous), toggle: onOff))

                }
            }
        }
    }
}

struct NEUButtonStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        NEUButtonStyleDebugView()
            .preferredColorScheme(.light)
        NEUButtonStyleDebugView()
            .preferredColorScheme(.dark)
    }
}
#endif

struct NEUSFView: View {
    
    let systemName: String
    let size: NEUButtonSize
    
    init(systemName: String, size: NEUButtonSize = .medium) {
        self.systemName = systemName
        self.size = size
    }
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .font(.system(size: size.fontSize, weight: .bold))
                .foregroundColor(.neuMainText)
                .frame(width: size.width, height: size.height)
        }
    }
}

extension NEUSFView {
    enum NEUButtonSize {
        case small
        case medium
        case big
        case large
        
        var size: CGSize {
            switch self {
            case .small:
                return CGSize(width: 35, height: 35)
            case .medium:
                return CGSize(width: 50, height: 50)
            case .big:
                return CGSize(width: 60, height: 60)
            case .large:
                return CGSize(width: 80, height: 80)
            }
        }
        
        var width: CGFloat { size.width }
        
        var height: CGFloat { size.height }
        
        var fontSize: CGFloat {
            switch self {
            case .small:
                return 10
            case .medium:
                return 15
            case .big:
                return 20
            case .large:
                return 25
            }
        }
    }
}
