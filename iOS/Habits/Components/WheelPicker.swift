import SwiftUI
import UIKit

/// Figma's Wheel picker: two wheels on one band, as Calendar's Repeat › Custom › On the… (iOS 26.5). "first | Friday",
/// "October | 23": two values that belong together, chosen in one control.
///
/// SwiftUI has no such control: two `Picker(.wheel)` side by side draw a band each and read as two controls, so this is
/// UIKit's own `UIPickerView` with two components, which iOS draws with one band across both. Everything it draws
/// (the band, the fading and leaning rows, the sounds and haptics, VoiceOver's adjustable wheels) is iOS's.
/// A list ends where it ends; nothing wraps round. Place it inline in a list card at its own height (216).
///
/// The second list may depend on the first (the days a month has): pass the new list, and clamp the second value in the
/// first's setter, as the caller already does for a pop-up.
struct WheelPicker<First: Hashable, Second: Hashable>: UIViewRepresentable {
    let first: [(value: First, title: String)]
    let second: [(value: Second, title: String)]
    @Binding var firstSelection: First
    @Binding var secondSelection: Second
    /// What VoiceOver calls each wheel, e.g. ("Which one", "Weekday").
    var labels: (first: String, second: String)

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        // Fit the card's width rather than ask for the picker's own.
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        picker.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return picker
    }

    func updateUIView(_ picker: UIPickerView, context: Context) {
        let coordinator = context.coordinator
        let countsChanged = coordinator.parent.first.count != first.count || coordinator.parent.second.count != second.count
        coordinator.parent = self
        if countsChanged { picker.reloadAllComponents() }
        select(firstSelection, in: first, component: 0, of: picker)
        select(secondSelection, in: second, component: 1, of: picker)
    }

    private func select<V: Hashable>(_ value: V, in list: [(value: V, title: String)], component: Int, of picker: UIPickerView) {
        guard let row = list.firstIndex(where: { $0.value == value }), picker.selectedRow(inComponent: component) != row
        else { return }
        picker.selectRow(row, inComponent: component, animated: false)
    }

    @MainActor
    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate {
        var parent: WheelPicker

        init(_ parent: WheelPicker) { self.parent = parent }

        func numberOfComponents(in pickerView: UIPickerView) -> Int { 2 }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            component == 0 ? parent.first.count : parent.second.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            component == 0 ? parent.first[row].title : parent.second[row].title
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                parent.firstSelection = parent.first[row].value
            } else {
                parent.secondSelection = parent.second[row].value
            }
        }

        func pickerView(_ pickerView: UIPickerView, accessibilityLabelForComponent component: Int) -> String? {
            component == 0 ? parent.labels.first : parent.labels.second
        }
    }
}
