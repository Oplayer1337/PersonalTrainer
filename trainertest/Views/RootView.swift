import SwiftUI

struct RootView: View {
    @EnvironmentObject var timerController: TimerController
    @State private var selectedTab: Int = 0
    @State var programDataList: [ProgramData] = []

    var body: some View {
        TabView(selection: $selectedTab) {
            MainTimerView()
                .tabItem {
                    Label("", systemImage: "timer")
                        .foregroundColor(.black)
                        .background(Color.black)
                }
                .tag(0)
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.hidden , for: .tabBar)
            MainProgramView(programDataList: $programDataList)
                .tabItem {
                    Label("", systemImage: "list.bullet")
                        .foregroundColor(.black)
                        .background(Color.black)
                        .foregroundColor(.white)
                }
                .tag(1)
                .background(Color.black)
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.hidden , for: .tabBar)
                .accentColor(.white)
        }
        .accentColor(.white)
        .toolbarBackground(.black, for: .tabBar)
        .toolbarBackground(.hidden , for: .tabBar)
        .onAppear {
            programDataList = DataLoader().loadProgramDatas() ?? []
        }
        .onChange(of: selectedTab) { _ in
            timerController.saveTimerState()
        }
    }
}

#Preview {
    RootView()
}




//struct RootView: View {
//    @State private var selectedTab: Int = 0
//    @State var programDataList: [ProgramData] = []
//    var body: some View {
//        
//        TabView(selection: $selectedTab) {
//            MainTimerView()
//                .tabItem {
//                    Label("", systemImage: "timer")
//                        .foregroundColor(.black)
//                        .background(Color.black)
////                        .imageScale(.large)
//                }
//                .tag(0)
//                .toolbarBackground(.black, for: .tabBar)
//                .toolbarBackground(.hidden , for: .tabBar)
//            MainProgramView(programDataList: $programDataList)
//                .tabItem {
//                    Label("", systemImage: "list.bullet")
//                        .foregroundColor(.black)
//                        .background(Color.black)
//                        .foregroundColor(.white)
//                }
//                .tag(1)
//                .background(Color.black)
//                .toolbarBackground(.black, for: .tabBar)
//                .toolbarBackground(.hidden , for: .tabBar)
//                .accentColor(.white)
//        }
//        .accentColor(.white)
//        .toolbarBackground(.black, for: .tabBar)
//        .toolbarBackground(.hidden , for: .tabBar)
//        .onAppear {
//        programDataList = DataLoader().loadProgramDatas() ?? []
//    }
//    }
//}
//
//#Preview {
//    RootView()
//}
