import SwiftUI
import CoreData

struct ItemDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: Item
    
    @State private var editedTitle: String = ""
    @State private var editedContent: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                TextField("Title", text: $editedTitle)
                    .font(.headline)
                
                TextEditor(text: $editedContent)
                    .frame(minHeight: 200)
            }
            
            Section(header: Text("Metadata")) {
                if let timestamp = item.timestamp {
                    HStack {
                        Text("Created")
                        Spacer()
                        Text(timestamp, formatter: itemFormatter)
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    Text("ID")
                    Spacer()
                    Text(item.id?.uuidString ?? "N/A")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveChanges()
                }
            }
        }
        .onAppear {
            editedTitle = item.title ?? ""
            editedContent = item.content ?? ""
        }
    }
    
    private func saveChanges() {
        item.title = editedTitle
        item.content = editedContent
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Error saving: \(nsError), \(nsError.userInfo)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()
