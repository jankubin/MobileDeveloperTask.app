//
//  DailyView.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import SwiftUI

struct DailyView: View {
    @StateObject var viewModel = DailyViewModel()
    @State private var highResLoaded = false
    
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ZStack{
                    if let imageUrl = URL(string: viewModel.daily?.url ?? "") {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                                .cornerRadius(10)
                        }
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onAppear{
                            highResLoaded = true
                        }
                    }
                    if highResLoaded, let hdImageUrl = URL(string: viewModel.daily?.hdurl ?? "") {
                        AsyncImage(url: hdImageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            EmptyView()
                        }
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    HStack{
                        VStack{
                            Text(viewModel.daily?.copyright ?? "")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.top)
                            Spacer()
                            Text(viewModel.daily?.date ?? "")
                                .foregroundColor(.white)
                                .padding(.leading)
                            Text("Today")
                                .foregroundColor(.white)
                                .font(.title.bold())
                                .padding(.bottom)
                        }
                        .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                
                Text(viewModel.daily?.title ?? "")
                    .font(.largeTitle)
                Text(viewModel.daily?.explanation ?? "")
            }
            .padding(30)
        }
        .task {
            do {
                viewModel.daily = try await viewModel.getDaily()
            } catch DailyError.invalidURL {
                print("Invalid url!")
            } catch DailyError.invalidResponse {
                print("Invalid response!")
            } catch DailyError.invalidData {
                print("Invalid data!")
            } catch {
                print("Unexpected error!")
            }
        }
        
    }
    

}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView()
    }
}
