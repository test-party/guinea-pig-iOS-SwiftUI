/*
   Copyright 2023-2024 CVS Health and/or one of its affiliates

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 */

import SwiftUI

struct ContactReno: View {
    @State private var showingAlert = false
    @AccessibilityFocusState private var isTriggerFocused: Bool


    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var message = ""
    @State private var nameErrorVisible = false
    @AccessibilityFocusState private var isNameA11yFocused: Bool
    @FocusState private var isNameFocused: Bool
    @State private var nameLabel = "User ID (required)"
    @State private var nameInstructions = "The last 5 digits of your account number."
    @State private var nameError = "⚠ User ID is required. Please enter the last 5 digits of your account number."
    @State private var emailLabel = "Email (required)"
    @State private var emailError = "⚠ Email is required. Please enter your email address."
    @State private var emailErrorVisible = false
    @AccessibilityFocusState private var isEmailA11yFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @State private var messageLabel = "Message (required)"
    @State private var messageInstructions = "Questions, Comments, or Feedback"
    @State private var messageError = "⚠ Message is required. Please enter your question, comment, or feedback in the message field."
    @State private var messageErrorVisible = false
    @AccessibilityFocusState private var isMessageA11yFocused: Bool
    @FocusState private var isMessageFocused: Bool


    
   
    
    private var darkGreen = Color(red: 0 / 255, green: 102 / 255, blue: 0 / 255)
    private var darkRed = Color(red: 220 / 255, green: 20 / 255, blue: 60 / 255)
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack {
                Text("Use the contact form below to send the Reno office a question or comment.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                //This is the LabeledContent and .accessibilityValue coded form
                LabeledContent(nameLabel) {
                      TextField("", text:$name)
                        .textFieldStyle(.roundedBorder)
                        .border(nameErrorVisible ? colorScheme == .dark ? Color(.systemRed) : darkRed : .secondary)
                        .accessibilityValue(nameErrorVisible ? name+", "+nameError+", "+nameInstructions : name+", "+nameInstructions)
                        .autocorrectionDisabled(true)
                        .textContentType(.username)
                        .keyboardType(.numberPad)
                        .accessibilityFocused($isNameA11yFocused)
                        .focused($isNameFocused)
                }.padding(.top)
                Text(nameInstructions)
                    .italic()
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if nameErrorVisible {
                    Text(nameError)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(colorScheme == .dark ? Color(.systemRed) : darkRed)
                }
                LabeledContent("Phone Number (optional)") {
                      TextField("", text:$phone)
                        .textFieldStyle(.roundedBorder)
                        .border(.secondary)
                        .keyboardType(.phonePad)
                }.padding(.top)
                LabeledContent(emailLabel) {
                      TextField("", text:$email)
                        .textFieldStyle(.roundedBorder)
                        .border(emailErrorVisible ? colorScheme == .dark ? Color(.systemRed) : darkRed : .secondary)
                        .accessibilityValue(emailErrorVisible ? email+", "+emailError : email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .accessibilityFocused($isEmailA11yFocused)
                        .focused($isEmailFocused)
                }.padding(.top)
                if emailErrorVisible {
                    Text(emailError)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(colorScheme == .dark ? Color(.systemRed) : darkRed)
                }
                LabeledContent(messageLabel) {
                      TextEditor(text: $message)
                        .textFieldStyle(.roundedBorder)
                        .border(messageErrorVisible ? colorScheme == .dark ? Color(.systemRed) : darkRed : .secondary)
                        .accessibilityValue(messageErrorVisible ? message+", "+messageError+", "+messageInstructions : message+", "+messageInstructions)
                        .accessibilityFocused($isMessageA11yFocused)
                        .focused($isMessageFocused)
                        .frame(minHeight:100, maxHeight: .infinity)
                        .padding(.horizontal, 1)
                }.padding(.top)
                Text(messageInstructions)
                    .italic()
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if messageErrorVisible {
                    Text(messageError)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(colorScheme == .dark ? Color(.systemRed) : darkRed)
                }
                Button(action: {
                    // Handle button action
                    nameErrorVisible = false
                    isNameFocused = false
                    isNameA11yFocused = false
                    emailErrorVisible = false
                    isEmailFocused = false
                    isEmailA11yFocused = false
                    messageErrorVisible = false
                    isMessageFocused = false
                    isMessageA11yFocused = false
                    if message.isEmpty {
                        messageErrorVisible = true
                        isMessageFocused = true
                        isMessageA11yFocused = true
                    }
                    if email.isEmpty {
                        emailErrorVisible = true
                        isEmailFocused = true
                        isEmailA11yFocused = true
                    }
                    if name.isEmpty {
                        nameErrorVisible = true
                        isNameFocused = true
                        isNameA11yFocused = true
                    }
                    if !message.isEmpty && !name.isEmpty && !email.isEmpty {
                        showingAlert = true
                    }
                }) {
                    Text("Send Message")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .font(.title3)
                        .fontWeight(.bold)
                        .opacity(0.8)
                }.padding(.top).frame(maxWidth: .infinity, alignment: .leading)
                    .alert("Thanks for contacting Reno office!", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) {
                            isTriggerFocused = true
                        }
                    } message: {
                        Text("We'll reply as soon as possible.")
                    }
                Spacer(minLength: 100)
                Text("LC .aV").frame(maxWidth: .infinity, alignment: .trailing).font(.caption2).foregroundStyle(.gray).accessibilityHidden(true)

            }
            .padding()
            .navigationTitle("Contact Reno Office")
        }
 
    }
}
 
struct ContactReno_Previews: PreviewProvider {
    static var previews: some View {
        ContactReno()
    }
}
