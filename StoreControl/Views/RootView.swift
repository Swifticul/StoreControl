//
//  RootView.swift
//  StoreControl
//
//  Created by Tristan on 25/02/2023.
//

import SwiftUI
import Foundation

struct RootView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var buildNumber: String {
            guard let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return "" }
            return "    \(buildNumber)    "
        }
    @StateObject var appState = AppState()
    @State var restoreText = ("Restore DemoLoop")
    @State var showUnrestoreProcess = false
    @State var presentResetMenu = false
    var body: some View {
        NavigationView {
            List {
                Image("IconInApp")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130)
                    .clipped()
                Text("StoreControl")
                    .font(.largeTitle.weight(.bold))
                HStack {
                    Text("Version \(appVersion ?? "AppVersion")")
                    Capsule(style: .continuous)
                        .frame(width: getWidth(text: buildNumber), height: 30)
                        .clipped()
                        .foregroundColor(.blue)
                        .overlay(
                            Text("\(buildNumber)")
                                .font(.footnote.weight(.semibold))
                                .foregroundColor(.white)
                        )
                }
                NavigationLink(destination:
                    appState.demoloopon ? AnyView(ThemeSelectorUI().environmentObject(appState)) : AnyView(DemoUpdateSetup().environmentObject(appState))
                ) {
                    Text("\(appState.ButtonText)")
                        .font(Font.body.weight(.medium))
                        .padding(.vertical, 12)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 14.0, style: .continuous)
                                .fill(Color.blue)
                        )
                        .opacity(1.0)
                    
                }
                Button("Unrestore DemoLoop") {
                    showUnrestoreProcess = true
                } .disabled(appState.demoloopon == false) .buttonStyle(ButtonFromInteractfulROFL())
                Section {
                    Button("Toggle Console View") {
                        if consoleManager.isVisible == false {
                            consoleManager.isVisible = true
                        } else {
                            consoleManager.isVisible = false
                        }
                    }
                    NavigationLink(destination: ExperimentsInterface()) {
                        Text("Experimental Features")
                    }
                    Button("Reset All Settings") {
                        presentResetMenu = true
                    } .fullScreenCover(isPresented: $presentResetMenu) {
                        ResetConfirm()
                    }
                } header: {
                    Text("options")
                } footer: {
                    Text("LocalConsole by duraidabdul\nMDC and TCCD exploits by Ian Beer & zhuowei - Initial patch method by iBaDev")
                }
            }
        } .navigationViewStyle(StackNavigationViewStyle()) .fullScreenCover(isPresented: $showUnrestoreProcess) {
            surgeryRemoveProcess()
}
    }
    
    func SurgeryRemove() {
        let fileManager = FileManager.default
        if let folderName = searchForFolderName() {
            consoleManager.print("Found folder: \(folderName)")
            let appBundlePath = Bundle.main.bundlePath
            consoleManager.print("Application Support Source: \(appBundlePath)")
            let revokePath = "/private/var/mobile/Containers/Data/Application/\(folderName)/Library/Application Support"
            consoleManager.print("Unrestore Path: \(revokePath)")
            do {
                if fileManager.fileExists(atPath: revokePath) {
                    try fileManager.removeItem(atPath: revokePath)
                    consoleManager.print("Existing folder removed successfully or was not found!")
                } else {
                    consoleManager.print("File does not exist at path \(revokePath)")
                }
            } catch {
                consoleManager.print("Error removing file at path \(revokePath): \(error.localizedDescription)")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                appState.demoloopon = false
                appState.ButtonText = "Restore DemoLoop"
            }
        } else {
            consoleManager.print("Could not find folder")
            return
        }
    }
    func searchForFolderName() -> String? {
        if appState.customappid == true {
            let fileManager = FileManager.default
            let appDirectory = "/private/var/mobile/Containers/Data/Application/"
            do {
                let folderNames = try fileManager.contentsOfDirectory(atPath: appDirectory)
                for folderName in folderNames {
                    let metadataFilePath = appDirectory + folderName + "/.com.apple.mobile_container_manager.metadata.plist"
                    let metadataData = try Data(contentsOf: URL(fileURLWithPath: metadataFilePath))
                    let metadataPlist = try PropertyListSerialization.propertyList(from: metadataData, format: nil) as? [String: Any]
                    
                    if let bundleId = metadataPlist?["MCMMetadataIdentifier"] as? String, bundleId == "\(appState.appidstring)" {
                        return folderName
                    }
                }
            } catch {
                consoleManager.print("Error: \(error.localizedDescription)")
            }
            return nil
        } else {
            let fileManager = FileManager.default
            let appDirectory = "/private/var/mobile/Containers/Data/Application/"
            do {
                let folderNames = try fileManager.contentsOfDirectory(atPath: appDirectory)
                for folderName in folderNames {
                    let metadataFilePath = appDirectory + folderName + "/.com.apple.mobile_container_manager.metadata.plist"
                    let metadataData = try Data(contentsOf: URL(fileURLWithPath: metadataFilePath))
                    let metadataPlist = try PropertyListSerialization.propertyList(from: metadataData, format: nil) as? [String: Any]
                    
                    if let bundleId = metadataPlist?["MCMMetadataIdentifier"] as? String, bundleId == "com.apple.ist.demoloop" {
                        return folderName
                    }
                }
            } catch {
                consoleManager.print("Error: \(error.localizedDescription)")
            }
            return nil
        }
    }
    func ChangeRestoreText() {
        if appState.demoloopon == false {
            restoreText = ("Restore DemoLoop")
        } else {
            restoreText = ("Change Theme or Reinstall")
        }
    }
}

func getWidth(text: String) -> CGFloat {
    let font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)
    return size.width
}

public struct ButtonFromInteractfulROFL: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 12)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14.0, style: .continuous)
                    .fill(Color.accentColor)
            )
            .opacity(configuration.isPressed ? 0.1 : 1.0)
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

struct surgeryRemoveProcess: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var appState = AppState()
    var body: some View {
        VStack {
            Image(systemName: "\(appState.operationStatusSymbol)")
                        .imageScale(.medium)
                        .font(.system(size: 150, weight: .regular, design: .default))
                    Spacer()
                        .frame(height: 41)
                        .clipped()
                    Text("Unrestoring DemoLoop")
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .frame(width: 350)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
                    Text("Are you sure you would like to Unrestore DemoLoop?\n\nYou should only perform this function if DemoLoop has been showing unexpected behavior with the theme you have selected.")
                        .font(.subheadline.weight(.regular))
                        .frame(width: 320)
                        .clipped()
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
            Button("I'm Sure, Continue") {
                
                exit(0)
                }
            } .buttonStyle(ButtonFromInteractfulROFL()) .frame(width: 350)
            Spacer()
                    .frame(maxHeight: 17)
            Button("No Thanks, Return") {
                self.presentationMode.wrappedValue.dismiss()
            }
                }
        }

struct ResetConfirm: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var appState = AppState()
    var body: some View {
        VStack {
                    Image(systemName: "questionmark.folder")
                        .imageScale(.medium)
                        .font(.system(size: 150, weight: .regular, design: .default))
                    Spacer()
                        .frame(height: 41)
                        .clipped()
                    Text("Resetting StoreControl")
                        .font(.largeTitle.weight(.bold))
                        .multilineTextAlignment(.center)
                        .frame(width: 350)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
                    Text("Are you sure you would like to reset StoreControl?\n\nYou should only perform this function if DemoLoop was uninstalled and StoreControl has not unrestored, or if StoreControl is experiencing issues that unrestoring DemoLoop cannot fix.")
                        .font(.subheadline.weight(.regular))
                        .frame(width: 320)
                        .clipped()
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(height: 20)
                        .clipped()
            Button("I'm Sure, Continue") {
                consoleManager.isVisible = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    appState.demoloopon = false
                    appState.ButtonText = ("Restore DemoLoop")
                    appState.selectedtheme = ("Pommes")
                    appState.customappid = false
                    appState.appidstring = ("")
                    appState.lariotheme = false
                    exit(0)
                }
            } .buttonStyle(ButtonFromInteractfulROFL()) .frame(width: 350)
            Spacer()
                    .frame(maxHeight: 17)
            Button("No Thanks, Return") {
                self.presentationMode.wrappedValue.dismiss()
            }
                }
        }
    }
