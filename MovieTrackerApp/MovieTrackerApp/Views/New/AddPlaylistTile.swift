
import SwiftUI


struct AddPlaylistTile: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .cornerRadius(12)
                
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            
            Text("Add List")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 80)
    }
}
