//
//  ContentView.swift
//  Hemlock
//
//  Created by WhitetailAni on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var showSettings = false
    
    @State var showCloseConfirm = false
    @State var selectedWindow = 1
    @State var windowList: [TerminalView] = [TerminalView()]
    //swiftUI views are structs, so they are a variable type...
    //which means you can create arrays of them...
    //this is so cursed
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if #available(tvOS 14.0, *) {
                        Button(action: {
                            if UserDefaults.settings.bool(forKey: "bypassCloseConfirm") {
                                windowList.remove(at: selectedWindow)
                            } else {
                                showCloseConfirm = true
                            }
                        }) {
                            Image(systemName: "multiply")
                                .foregroundColor(.red)
                        }
                        .contextMenu {
                            Button(action: {
                                //idk how to do this yet
                            }) {
                                Text(localizedString: "WINDOW_CLEAR")
                            }
                            Button(action: {
                                windowList[selectedWindow] = TerminalView()
                            }) {
                                Text(localizedString: "WINDOW_RESET")
                            }
                            Button(action: {
                                windowList = [TerminalView()]
                            }) {
                                Text(localizedString: "WINDOW_CLOSEALL")
                                    .foregroundColor(.red)
                            }
                            .foregroundColor(.red)
                            
                            Button(action: { }) { Text(localizedString: "DISMISS") }
                        }
                        .alert(isPresented: $showCloseConfirm) {
                            Alert(
                                title: Text(LocalizedString("WINDOW_CLOSECONFIRMTITLE")),
                                message: Text(LocalizedString("WINDOW_CLOSECONFIRM")),
                                primaryButton: .default(Text(LocalizedString("CANCEL")).foregroundColor(.red), action: {
                                    showCloseConfirm = false
                                }),
                                secondaryButton: .default(Text(LocalizedString("CLOSE")), action: {
                                    windowList.remove(at: selectedWindow)
                                })
                            )
                        }
                    } else {
                        Button(action: {
                            if UserDefaults.settings.bool(forKey: "bypassCloseConfirm") {
                                windowList.remove(at: selectedWindow)
                            } else {
                                showCloseConfirm = true
                            }
                        }) {
                            Image(systemName: "multiply")
                                .foregroundColor(.red)
                        }
                        .alert(isPresented: $showCloseConfirm) {
                            Alert(
                                title: Text(LocalizedString("WINDOW_CLOSECONFIRMTITLE")),
                                message: Text(LocalizedString("WINDOW_CLOSECONFIRM")),
                                primaryButton: .default(Text(LocalizedString("CANCEL")).foregroundColor(.red), action: {
                                    showCloseConfirm = false
                                }),
                                secondaryButton: .default(Text(LocalizedString("CLOSE")), action: {
                                    windowList.remove(at: selectedWindow)
                                })
                            )
                        }
                    }
                    
                    VStack {
                        Text(LocalizedString("WINDOWSELECTED"))
                            .if(UserDefaults.settings.bool(forKey: "sheikahFontApply")) { view in
                                view.scaledFont(name: "BotW Sheikah Regular", size: 25)
                            }
                            .font(.system(size: 25))
                            .multilineTextAlignment(.center)
                        StepperTV(value: $selectedWindow, lowerBound: 1, upperBound: windowList.count, isHorizontal: true) { }
                    }
                    Button(action: {
                        windowList.append(TerminalView())
                    }) {
                        Image(systemName: "plus")
                    }
                    Spacer()
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gear")
                    }
                } //hstack
                windowList[selectedWindow - 1] //this is a view! not cursed At All
                //It's [selectedWindow - 1] because the displayed window is 1 below what the selected one says it is - because having window 0 would be confusing for new people
                //i say this as if new people will use it
            } //vstack
            if showSettings {
                //background element
                SettingsView()
            }
        } //zstack
    }
}
