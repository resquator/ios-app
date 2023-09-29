//
//  BackupFiles.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 09.09.23.
//

import SwiftUI

struct BackupFiles: View {
    struct FilesName: Identifiable {
        var id = UUID()
        var name: String
        var path: String

    }
    

    
    let fileManager = FileManager.default

    func deleteFiles(fileToDelete: String) {

        print(fileToDelete)
        let fName = "competitions_2023133787mer.13sept.2023"
        let fExtension = "data"
        
        let fURL = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let deleteAtURL = fURL.appendingPathComponent(fName).appendingPathExtension(fExtension)
        print("----------------------")
        print(deleteAtURL.path)
        print("----------------------")
        
        do {
            //try FileManager.default.removeItem(at: deleteAtURL)
            try FileManager.default.removeItem(atPath: fileToDelete)
            print("Image backup has been deleted")
        } catch {
            print(error)
        }
    }
    
    func fullDirectory() -> [FilesName] {
        var listFiles: [FilesName] = []
        do {
            let resourceKeys : [URLResourceKey] = [.creationDateKey, .isDirectoryKey]
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let enumerator = FileManager.default.enumerator(at: documentsURL,
                                    includingPropertiesForKeys: resourceKeys,
                                                       options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
                                                                print("directoryEnumerator error at \(url): ", error)
                                                                return true
            })!

            for case let fileURL as URL in enumerator {
                let resourceValues = try fileURL.resourceValues(forKeys: Set(resourceKeys))
                print(fileURL.path, resourceValues.creationDate!, resourceValues.isDirectory!)
                let s = FilesName(name: fileURL.path.components(separatedBy: "/Documents/")[1], path:fileURL.path)
                listFiles.append(s)
                //listOfFiles.append(FilesName(name: fileURL.path))
            }
        } catch {
            print(error)
        }
        
        return listFiles
    }

    
    var body: some View {
        VStack {
            Text("Files List")
            NavigationView {
                List {
                    //Text("File 1")
                    //Text("File 2")
                    ForEach(fullDirectory()) { item in
                        NavigationLink {
                            Text(item.path)
                        } label: {
                            Text(item.name)
                        }.onTapGesture {
                            print("TapGesture activated")
                            //deleteFiles(fileToDelete: item.path)
                            //print("delete Done !")
                        }

                        
                    }
                }
                .navigationTitle("List Files")
                .background(Image("background_tlsp")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    //.scaledToFit()
                    .opacity(0.9)
                    .brightness(0.64)
                )
            }

        }

    }
}



struct BackupFiles_Previews: PreviewProvider {
    static var previews: some View {
        BackupFiles()
    }
}



