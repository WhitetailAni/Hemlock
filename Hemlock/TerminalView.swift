//
//  TerminalView.swift
//  Hemlock
//
//  Created by WhitetailAni on 11/16/23.
//

import SwiftUI

struct TerminalView: View {
    @State var writeToStdin: String = ""
    @State var terminal: String = ""
    @State var fontSize = UserDefaults.settings.integer(forKey: "terminalFontSize")
    
    var body: some View {
        UIKitTextView(text: $terminal, fontSize: CGFloat(fontSize))
            .focusable(true)
        HStack {
            TextField(LocalizedString("STDIN_INPUT"), text: $writeToStdin)
            Button(action: {
                //write to stdin
            }) {
                Image("arrow.up")
            }
        }
    }
}
