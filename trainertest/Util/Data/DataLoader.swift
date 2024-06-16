import Foundation
class DataLoader {
    func loadProgramDatas() -> [ProgramData]? {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("Failed to locate data.json in app bundle.")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let programDatas = try decoder.decode([ProgramData].self, from: data)
            return programDatas
        } catch {
            print("Error loading or decoding data from JSON: \(error)")
            return nil
        }
    }
}

