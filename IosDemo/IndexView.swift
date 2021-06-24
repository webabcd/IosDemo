//
//  IndexView.swift
//  IosDemo
//
//  Created by 王磊 on 2021/6/15.
//

import SwiftUI

struct IndexView: View {
    
   
    
    var body: some View {
        let siteMap: [SiteMap] = load("site_map.json")

        List {
            ForEach(siteMap, id: \.self) { parent in
                Section(header: Text("\(parent.title)")) {
                    ForEach(parent.items, id: \.self) { child in
             
                        Row(name: child.title, url: child.url)
                    }
                }
            }
        }
    }
    
    struct Row: View {
        @State private var xxx = false
        
        var name: String
        var url: String
        
        var body: some View {
            Button("\(name)") {
                self.xxx = true
            }.sheet(isPresented: $xxx) {
                switch self.url {
                case "SwiftView01": SwiftView01()
                case "SwiftView02": SwiftView02()
                case "SwiftView03": SwiftView03()
                case "SwiftView04": SwiftView04()
                case "SwiftView05": SwiftView05()
                case "SwiftView06": SwiftView06()
                case "SwiftView07": SwiftView07()
                case "SwiftView08": SwiftView08()
                case "SwiftView09": SwiftView09()
                case "SwiftView10": SwiftView10()
                case "SwiftView11": SwiftView11()
                case "SwiftView12": SwiftView12()
                case "SwiftView13": SwiftView13()
                case "SwiftView14": SwiftView14()
                case "SwiftView15": SwiftView15()
                default: SwiftView01()
                }
            }
        }
    }
    
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    
    struct SiteMap: Hashable, Codable {
        var title: String
        var items: [Item]
    }
    
    struct Item: Hashable, Codable {
        var title: String
        var url: String
    }
}
