//
//  ContentView.swift
//  exploPersistingData
//
//  Created by Daryl FELIX on 31.08.23.
//

import SwiftUI
import Charts



struct ContentView: View {
    
    
    @Binding var competitions: [Competitions]
    @Binding var history: [History]
    
    @StateObject private var store = CompetitionsStore()

    @Environment(\.scenePhase) private var scenePhase
    
    
    let saveAction: ()->Void
    let backgroundGradient = LinearGradient(
        colors: [Color.red, Color.blue],
        startPoint: .top, endPoint: .bottom)

    
    // everything to load history add current items and erase data
    private static func fileURL(fname: String) throws -> URL {

        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("\(fname)")

    }

    func loadHistory() async throws {
        let task = Task<[History], Error> {
            let fileURL = try Self.fileURL(fname: "history.data")
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let gameCompetitions = try JSONDecoder().decode([History].self, from: data)
            return gameCompetitions
        }
        let competitions = try await task.value
        self.history = competitions
    }

    func saveHistory(competitions: [History]) async throws {
        print("Save called")
        let task = Task {
            let data = try JSONEncoder().encode(history)
            let outfile = try Self.fileURL(fname: "history.data")
            try data.write(to: outfile)
        }
        _ = try await task.value
        print("Backup Save called")
    }

    
    @StateObject private var histoStore = HistoryStore()
    
    
    
    var body: some View {

        VStack {

            NavigationView {
                VStack {
                    Spacer()
                    NavigationLink(destination: CompetitionList(competitions: $competitions )) {
                        Text("ScoreCard").bold().font(.title)
                        Image(systemName: "tablecells.badge.ellipsis")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }.padding(10)
                    NavigationLink(destination: CompetitionDetail(compet: $competitions )) {
                        Text("New Holes").bold().font(.title)
                        Image(systemName: "text.insert")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }.padding(10)
                    NavigationLink(destination: StatisticsView(competitions: $competitions )) {
                        Text("Statistics").bold().font(.title)
                            Image(systemName: "chart.line.uptrend.xyaxis")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }.padding(10)
                    NavigationLink(destination: TlspView(competitions: $competitions )) {
                        Text("TLSP System").bold().font(.title)
                            Image(systemName: "chart.xyaxis.line")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }.padding(10)
                    NavigationLink(destination: HistoryView(history: $history )) {
                        Text("Historic").bold().font(.title)
                            Image(systemName: "chart.pie")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }.padding(10)

                    NavigationLink(destination: InfoText()) {
                        Text("Help").bold().font(.title)
                            Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }.padding(10)

                    
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Delete pushed")
                            // here i want to add competitions content to history
                            // and then erase the file
                            //histoStore.load()
                            if competitions.count>0 {
                            let c = competitions.count - 1
                                for i in 0...c {
                                    //print(competitions[i].competition)
                                    //history.append(competitions[i])
                                    var newEntry = History.emptyHistory
                                    newEntry.competition = competitions[i].competition
                                    newEntry.date_competition = competitions[i].date_competition
                                    newEntry.score = competitions[i].score
                                    newEntry.details = competitions[i].details
                                    history.append(newEntry)
                                    
                                }
                            }
                            print("History \(history.count)")
                            
                            //loadHistory()
                            competitions.removeAll()
                            print("Competitions \(competitions.count)")
                        }) {
                            Image(systemName: "eraser.line.dashed")
                                .resizable()
                                .frame(width: 36.0, height: 36.0)
                        }
                        Divider()
                        //Spacer()
                        Button(action: {
                            print("Button +  pressed")
                            saveAction()
                            
                            //CompetitionDetail($compet: competitions.)
                        }) {
                            //Text("Save session")
                            Image(systemName: "square.and.arrow.down")
                                //.imageScale(.large)
                                .resizable()
                                .frame(width: 36.0, height: 36.0)
                                .foregroundColor(.accentColor)
                            
                        }
                        Divider()
                        NavigationLink(destination: BackupFiles()) {
                            //Text("Backup").bold().font(.title)
                                Image(systemName: "folder")
                                .resizable()
                                .frame(width: 36.0, height: 36.0)
                                .foregroundColor(.accentColor)
                        }.padding(10)
                            
                        Divider()
                        VStack {
                            Text("Holes Stored = \(competitions.count)")
                            Text("Historic Data = \(history.count)")
                        }
                        Spacer()
           
                    }
                    
                }.navigationTitle("T.L.S.P System")
                    .padding(10)
                    .background(Image("background_tlsp")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        //.scaledToFit()
                        .opacity(0.8)
                        .brightness(0.64)
                    )

                
                

            }.navigationViewStyle(.stack)
                //.background(Image("background_tlsp"))
            
            
            
            

            
        }.background(Image("background_tlsp"))
            
     
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
                print("Save activated")
            } else {
                print("active")
            }
        }.background(Color.gray)

        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(competitions: .constant(Competitions.sampleData),
                    history: .constant(History.sampleData),
                    saveAction: {})
    }
}


