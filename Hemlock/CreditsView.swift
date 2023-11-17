//
//  CreditsView.swift
//  Hemlock
//
//  Created by WhitetailAni on 11/16/23.
//

import SwiftUI

struct CreditsView: View {
    @State var secret = [false, false]
    @State var creditsTitle = "Hemlock, © 2023 by WhitetailAni"

    var body: some View {
        ZStack {
            VStack {
                if secret[0] {
                    Text("Hemlock, © 2023 by WhitetailAni 🏳️‍⚧️")
                        .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                            view.scaledFont(name: "BotW Sheikah Regular", size: 60)
                        }
                        .font(.system(size: 60))
                } else {
                    Text("Hemlock, © 2023 by WhitetailAni")
                        .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                            view.scaledFont(name: "BotW Sheikah Regular", size: 60)
                        }
                        .font(.system(size: 60))
                }
                Text("""
                "A tvOS terminal app for masochists"
                """)
                    .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                        view.scaledFont(name: "BotW Sheikah Regular", size: 25)
                    }
                Text("")
                Text("""
                Credits to:
                Hashbang Productions: NewTerm source code so I could learn how to set up a terminal session (probably)
                Capt Inc: The Zefram malware included
                """)
                .multilineTextAlignment(.center)
                .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                    view.scaledFont(name: "BotW Sheikah Regular", size: 25)
                }
            }
            .focusable(true)
            .onPlayPauseCommand {
                withAnimation(.spring) {
                    secret[0].toggle()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
                    withAnimation(.easeIn) {
                        secret[1] = true
                    }
                }
            }
            VStack {
                Spacer()
                if secret[1] {
                    Text("You should try pressing the Play/Pause button")
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                withAnimation(.easeIn) {
                                    secret[1] = false
                                }
                            }
                        }
                        .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                            view.scaledFont(name: "BotW Sheikah Regular", size: 17)
                        }
                }
            }
        }
    }
}
