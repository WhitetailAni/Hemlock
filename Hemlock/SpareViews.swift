//
//  SpareViews.swift
//  Hemlock
//
//  Created by WhitetailAni on 11/13/23.
//

import SwiftUI

struct UIKitTextView: UIViewRepresentable {
    @Binding var text: String
    @State var fontSize: CGFloat

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        let opacity = 0.25
        textView.delegate = context.coordinator
        textView.isUserInteractionEnabled = !text.isEmpty
        textView.isSelectable = true
        
        if #available(tvOS 15.0, *) {
            if let dynamicColor = UIColor(named: "systemBackground") {
                textView.backgroundColor = dynamicColor.withAlphaComponent(opacity)
            } else {
                textView.backgroundColor = UIColor.darkGray.withAlphaComponent(opacity)
            }
        } else {
            textView.backgroundColor = UIColor.darkGray.withAlphaComponent(opacity)
        }
        if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) {
            textView.font = UIFont(name: "BotW Sheikah Regular", size: fontSize)
        } else {
            textView.font = UIFont(name: "SF Mono Regular", size: fontSize)
        }
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.isUserInteractionEnabled = !text.isEmpty
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        let parent: UIKitTextView
    
        init(_ parent: UIKitTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

extension Font {
    init(cgFont: CGFont, size: CGFloat) {
        let fontName = cgFont.postScriptName as String?
        self = Font.custom(fontName!, size: size) // Adjust the size as per your requirements
    }
}

func LocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

struct StepperTV: View {
    @Binding var value: Int
    @State var valueToIncrementBy = -1
    @State var lowerBound = Int.min
    @State var upperBound = Int.max
    @State var isHorizontal: Bool
    let onCommit: () -> Void
    
    var body: some View {
        if(isHorizontal) {
            HStack {
                minus
                valueText
                plus
            }
        } else {
            VStack {
                plus
                valueText
                minus
            }
        }
    }
    
    var minus: some View {
        Button(action: {
            if !(value == lowerBound) {
                if valueToIncrementBy != -1 {
                    value -= valueToIncrementBy
                } else {
                    value -= 1
                }
            }
            onCommit()
        }) {
            Image(systemName: "minus")
                .font(.system(size: 30))
                .frame(width: 30, height: 30)
        }
    }
    
    var valueText: some View {
        Text("\(value)")
            .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                view.scaledFont(name: "BotW Sheikah Regular", size: 40)
            }
            .font(.headline)
    }
    
    var plus: some View {
        Button(action: {
            if !(value == upperBound) {
                if valueToIncrementBy != -1 {
                    value += valueToIncrementBy
                } else {
                    value += 1
                }
            }
            onCommit()
        }) {
            Image(systemName: "plus")
                .font(.system(size: 30))
                .frame(width: 30, height: 30)
        }
    }
}

extension View {
    public func blending(color: Color) -> some View {
        modifier(ColorBlended(color: color))
    }
    
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    } //this is one of the best things I've ever written tbh
}

struct nullView: View { var body: some View { Text("") } }

public struct ColorBlended: ViewModifier {
    fileprivate var color: Color
  
    public func body(content: Content) -> some View {
        VStack {
            ZStack {
                content
                color.blendMode(.sourceAtop)
            }
            .drawingGroup(opaque: false)
        }
    }
}

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension Text {
    init(localizedString: String) {
        self = Text(LocalizedString(localizedString))
        return
    }
}
