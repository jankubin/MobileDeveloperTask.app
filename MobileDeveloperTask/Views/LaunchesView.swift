//
//  LaunchesView.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import SwiftUI

struct LaunchesView: View {
    
    @StateObject var viewModel = LaunchesViewModel()
    @State private var searchText = ""
    
    var filteredLaunches: [Response] {
            if searchText.isEmpty {
                return viewModel.spaceXLaunch
            } else {
                return viewModel.spaceXLaunch.filter { launch in
                    launch.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    var body: some View {
        NavigationView {
                ScrollView {
                    ForEach(filteredLaunches, id: \.self) { space in
                        HStack {
                            if let small = space.links.patch?.small {
                                AsyncImage(url: URL(string: small)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding()
                            }
                            VStack(alignment: .leading, spacing: 20) {
                                Text(space.name)
                                    .font(.title3)
                                Text(space.dateLocal)
                            }
                        }
                        
                        HStack{
                            if let webcast = space.links.webcast, let webcastURL = URL(string: webcast) {
                                Link(destination: webcastURL) {
                                    Rectangle()
                                        .frame(width: 150, height: 30)
                                        .foregroundColor(.red.opacity(0.6))
                                        .cornerRadius(5)
                                        .overlay(
                                            HStack {
                                                Image(systemName: "arrowtriangle.forward.fill")
                                                    .foregroundColor(.white)
                                                Text("Livestream")
                                                    .foregroundColor(.white)
                                            }
                                        )
                                }
                            }
                            
                            if let wiky = space.links.wikipedia, let wikyURL = URL(string: wiky) {
                                Link(destination: wikyURL) {
                                    HStack {
                                        Image(systemName: "link")
                                            .foregroundColor(.black)
                                        Text("Wiky")
                                            .foregroundColor(.black)
                                            .font(.headline)
                                    }
                                    .padding(.leading)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("SpaceX")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, prompt: "Type in mission name or payload name")
            }
            .onAppear {
                viewModel.fetch()
            }
        }
    }

struct LaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesView()
    }
}
