import SwiftUI



struct MainProgramView: View {
    @Binding var programDataList: [ProgramData]
    
    init(programDataList: Binding<[ProgramData]>) {
        
        self._programDataList = programDataList
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)

            // Apply the custom appearance
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().tintColor = .white
        }
    
    var body: some View {
        
        VStack(alignment:.center, spacing: 10) {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight:4)
                            .foregroundColor(.black)
            Text("PROGRAMS")
                .font(.custom("Khand-SemiBold",size: 46))
                .kerning(4)
                .foregroundStyle(Color.white)
                .background(Color.black.edgesIgnoringSafeArea(.all))

            NavigationView {
                ScrollView {
                    VStack(alignment: .center, spacing: 40) {
                        Rectangle()
                            .frame(maxHeight: 16)
                            .foregroundColor(.black)
                        ForEach(programDataList) { programData in
                                            NavigationLink(destination: BaseProgram(programData: programData)) {
                                                ProgramView(programData: programData)
                                            }
                                        }
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight:4)
                            .frame(alignment: .bottom)
                            .background(Color.black)
                            .foregroundColor(.black)
                            
                    }
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all)
                }
                .navigationBarHidden(true)
            }
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight:4)
                .frame(alignment: .bottom)
                .background(Color.black)
                .foregroundColor(.white)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight:16)
                .frame(alignment: .bottom)
                .background(Color.black)
                .foregroundColor(.black)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
        
}

