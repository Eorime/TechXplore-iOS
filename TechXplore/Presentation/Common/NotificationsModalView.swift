import SwiftUI

struct NotificationsModalView: View {
    @ObservedObject var manager: NotificationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Notifications")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color("AppCyan"))
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 16)
            
            if manager.notifications.isEmpty {
                Spacer()
                Text("No notifications yet.")
                    .font(.system(size: 14))
                    .foregroundStyle(Color("AppCyan").opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(manager.notifications) { notification in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(notification.title)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color("AppBlack"))
                                Text(notification.body)
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color("AppBlack").opacity(0.6))
                                Text(notification.timestamp.formatted(date: .abbreviated, time: .shortened))
                                    .font(.system(size: 10))
                                    .foregroundStyle(Color("AppCyan").opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            
                            Divider()
                                .background(Color("AppCyan").opacity(0.2))
                        }
                    }
                }
            }
        }
        .onAppear {
            manager.markAsRead()
        }
    }
}
