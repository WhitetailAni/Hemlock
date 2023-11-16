//
//  SettingsView.swift
//  Hemlock
//
//  Created by WhitetailAni on 11/16/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var showView: [Bool] = [Bool](repeating: false, count: 3)
    @State private var bypassCloseConfirmPre = UserDefaults.settings.bool(forKey: "bypassCloseConfirm")
    @State private var terminalFontSizePre = UserDefaults.settings.integer(forKey: "terminalFontSize")
    @State private var sheikahFontApplyPre = UserDefaults.settings.bool(forKey: "sheikahFontApply")

    var body: some View {
        ScrollView {
            Text(NSLocalizedString("SETTINGS", comment: "But choose carefully because you'll stay in the job you pick for the rest of your life."))
                .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                    view.scaledFont(name: "BotW Sheikah Regular", size: 60)
                }
                .font(.system(size: 60))
            
            StepperTV(value: $terminalFontSizePre, isHorizontal: true) {
                UserDefaults.settings.set(terminalFontSizePre, forKey: "terminalFontSize")
                UserDefaults.settings.synchronize()
            }
            .padding(5)
            Text(NSLocalizedString("SETTINGS_TERMFONTSIZE", comment: "The same job the rest of your life?"))
                .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                    view.scaledFont(name: "BotW Sheikah Regular", size: 25)
                }
                .font(.system(size: 25))
                
            Text(" ")
            sheikahFont
            Text(" ")
            
            /*Button(action: {
                showView[2] = true
            }) {
                HStack {
                    Image(systemName: "applepencil")
                    Text(NSLocalizedString("APPICON", comment: """
                    LET'S GO BABY LOVE THE [[METS]] HIT A HOME RUN BABY
                    1987 *CAN* HAPPEN AGAIN
                    """))
                    .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                        view.scaledFont(name: "BotW Sheikah Regular", size: 25)
                    }
                }
            }*/
            
            Button(action: { //info
                showView[0] = true
            }) {
                HStack {
                    Image(systemName: "info.circle")
                        .frame(width: 50, height: 50)
                    Text(NSLocalizedString("CREDITS", comment: """
                    "What's the difference?"
                    """))
                    .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                        view.scaledFont(name: "BotW Sheikah Regular", size: 40)
                    }
                }
            }
            
            Text(" ")
                .font(.system(size: 25))
            Text("Hemlock v\((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "Don't edit") (\((Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "Info.plists"))")
                .foregroundColor(.secondary)
                .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                    view.scaledFont(name: "BotW Sheikah Regular", size: 20)
                }
                .font(.footnote)
        }
        .sheet(isPresented: $showView[0], content: {
            CreditsView()
        })
        /*.sheet(isPresented: $showView[2], content: {
            IconView()
        })*/
    }
    
    @ViewBuilder
    var sheikahFont: some View {
        Button(action: {
            sheikahFontApplyPre.toggle()
            UserDefaults.settings.set(sheikahFontApplyPre, forKey: "sheikahFontApply")
            UserDefaults.settings.synchronize()
            /*if(sheikahFontApplyPre) {
                buttonWidth *= 1.5
            } else {
                buttonWidth /= 1.5
            }*/
        }) {
            Text(LocalizedString("SETTINGS_SHEIKAH"))
                .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                    view.scaledFont(name: "BotW Sheikah Regular", size: 40)
                }
            Image(systemName: sheikahFontApplyPre ? "checkmark.square" : "square")
        }
    }
}

struct IconView: View {
    var body: some View {
        VStack {
            Text(NSLocalizedString("APPICON_TITLE", comment: "But choose carefully because you'll stay in the job you pick for the rest of your life."))
                .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                    view.scaledFont(name: "BotW Sheikah Regular", size: 60)
                }
                .font(.system(size: 60))
            VStack {
                HStack {
                    IconButton(iconName: "Hemlock", creator: "WhitetailAni")
                    IconButton(iconName: "Socrates", creator: "WhitetailAni")
                    
                }
                HStack {
                    
                }
            }
        }
    }
}

struct IconButton: View {
    @State var iconName: String
    @State var creator: String

    var body: some View {
        Button(action: {
            UIApplication.shared.setAlternateIconName(iconName) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }) {
            VStack {
                Image(uiImage: UIImage(named: iconName)!)
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: 300, height: 180)
                Text(iconName)
                        .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                            view.scaledFont(name: "BotW Sheikah Regular", size: 30)
                        }
                Text(creator)
                    .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                        view.scaledFont(name: "BotW Sheikah Regular", size: 25).foregroundColor(.gray)
                    }
                    .foregroundColor(.gray)
            }
            .frame(width: 350, height: 300)
        }
    }
}
