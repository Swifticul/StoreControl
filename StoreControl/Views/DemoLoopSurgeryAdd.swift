//
//  DemoLoopSurgeryAddAdd.swift
//  StoreControl
//
//  Created by Tristan on 26/02/2023.
//

import SwiftUI

var SurgerySuccessful = false

struct DemoLoopSurgeryAdd: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var appState = AppState()
    @State var EnablePerformButton = true
    @State var showSuccess = false
    var body: some View {
        VStack(spacing: 25) {
            Image("SurgeryIndicatorIconInApp")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .clipped()
            Text("Patching DemoLoop")
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)
                .frame(width: 350)
            Text("StoreControl will try to restore DemoLoop and apply the selected \(appState.selectedtheme) theme.\n\n You can override this theme with a new one without having to unrestore. Unrestoring is only useful for removing a faulty theme and for other issues.")
                .font(.subheadline.weight(.regular))
                .frame(width: 340)
                .clipped()
                .multilineTextAlignment(.center)
            Button("\(appState.ButtonText)") {
                SurgeryAdd()
                EnablePerformButton = false
            } .disabled(EnablePerformButton == false) .buttonStyle(ButtonFromInteractfulROFL()) .frame(width: 350)
        } .sheet(isPresented: $showSuccess) {
            surgerySuccess()
        }
    }
    func SurgeryAdd() {
        let fileManager = FileManager.default
        if let folderName = searchForFolderName() {
            consoleManager.print("Found folder: \(folderName)")
            let appBundlePath = Bundle.main.bundlePath
            consoleManager.print("Application Support Source: \(appBundlePath)/Themes/\(appState.selectedtheme)")
            let originalPath = "\(appBundlePath)/Themes/\(appState.selectedtheme)/Application Support"
            let destinationPath = "/private/var/mobile/Containers/Data/Application/\(folderName)/Library/Application Support"
            consoleManager.print("Destination Path: \(destinationPath)")
            do {
                if fileManager.fileExists(atPath: destinationPath) {
                    try fileManager.removeItem(atPath: destinationPath)
                    consoleManager.print("Existing folder removed successfully or was not found!")
                }
                try fileManager.copyItem(atPath: originalPath, toPath: destinationPath)
                consoleManager.print("Folder copied successfully!")
            } catch {
                consoleManager.print("Error copying folder: \(error.localizedDescription)")
                return
            }
        } else {
            consoleManager.print("Could not find folder")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SurgerySuccessful = true
            EnablePerformButton = true
            appState.ButtonText = "Reinstall Resources"
            appState.demoloopon = true
            showSuccess = true
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
    
    struct DemoLoopSurgeryAdd_Previews: PreviewProvider {
        static var previews: some View {
            DemoLoopSurgeryAdd()
        }
    }
    
    struct surgerySuccess: View {
        @Environment(\.presentationMode) var presentationMode
        var body: some View {
            VStack {
                Image(systemName: "app.badge.checkmark.fill")
                    .imageScale(.medium)
                    .font(.system(size: 150, weight: .regular, design: .default))
                Spacer()
                    .frame(height: 41)
                    .clipped()
                Text("Patching Successful!")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                    .frame(width: 350)
                Spacer()
                    .frame(height: 20)
                    .clipped()
                Text("DemoLoop has been successfully patched using the selected theme.\n\nRestart StoreControl to unlock new options.")
                    .font(.subheadline.weight(.regular))
                    .frame(width: 320)
                    .clipped()
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 20)
                    .clipped()
                Button("Dismiss and Restart") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        exit(0)
                    }
                }
            }
        }
    }
}
