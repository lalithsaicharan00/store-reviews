import Foundation

// Semantic contract v1. Android/iPad/watch/web are reserved vocabulary, not implemented adapters.
nonisolated enum AnalyticsHabitType: String, Codable, CaseIterable, Sendable {
    case check, amount, duration, checklist, quit, cutDown = "cut_down", notApplicable = "not_applicable"
    var entity: String { self == .notApplicable ? "task" : "habit" }
}
nonisolated enum AnalyticsOrigin: String, Codable, CaseIterable, Sendable {
    case today, manual, routine, reminder, timer, history, shortcut, widget, watch, web
    var surface: String {
        switch self { case .reminder: return "notification"; case .shortcut, .widget, .watch, .web: return rawValue; default: return "app" }
    }
}
nonisolated enum AnalyticsScreen: String, Codable, CaseIterable, Sendable {
    case today, myTasks = "my_tasks", allHabits = "all_habits", progress, habitDetail = "habit_detail"
    case historyDay = "history_day", newHabit = "new_habit", newTask = "new_task", routinePlayer = "routine_player"
    case menu, timesOfDay = "times_of_day", dayAndWeek = "day_and_week", reminders, appearance
    case widgetsSettings = "widgets_settings", backupSync = "backup_sync", account, plus, privacy, help, about, onboarding
}
nonisolated enum AnalyticsCounter: String, Codable, CaseIterable, Sendable {
    case undo = "undo_count", editEntry = "edit_entry_count", deleteEntry = "delete_entry_count", historyLog = "history_log_count"
    case taskCompleted = "task_completed_count", taskReopened = "task_reopened_count", taskDeleted = "task_deleted_count"
    case groupCreated = "group_created_count", groupAssigned = "group_assigned_count", reorder = "reorder_count"
    case filterUsed = "filter_used", sectionFold = "section_fold_used", completedFilter = "completed_filter_used"
    case routineStarted = "routine_started_count", routineFinished = "routine_finished_count", routineCancelled = "routine_cancelled_count"
    case timerStarted = "timer_started_count", timerStopped = "timer_stopped_count"
    case scheduleEdited = "schedule_edited_count", goalEdited = "goal_edited_count", reminderEdited = "reminder_edited_count"
    case paused = "habit_paused_count", resumed = "habit_resumed_count", archived = "habit_archived_count", deleted = "habit_deleted_count"
    case progressWeek = "progress_week_used", progressMonth = "progress_month_used", progressYear = "progress_year_used"
    case progressGroup = "progress_group_filter_used", habitCalendar = "habit_calendar_used", weekdayChart = "weekday_chart_used"
    case runsChart = "runs_chart_used", moneyView = "money_view_used", yearShare = "year_share_started_count"
    case noteSaved = "note_saved_count", milestones = "milestones_opened", faq = "faq_opened_count", helpSearch = "help_search_used"
    case contactSupport = "contact_support_opened_count", welcomeReplay = "welcome_replay_count", reviewRequested = "review_prompt_requested_count"
    case widgetAccepted = "widget_action_accepted_count", widgetOpen = "widget_deeplink_opened_count", widgetPage = "widget_page_changed_count"
    case shortcutAccepted = "shortcut_action_accepted_count"
    var isFlag: Bool { rawValue.hasSuffix("_used") || self == .milestones }
}

nonisolated enum AnalyticsEvent: String, Codable, CaseIterable, Sendable {
    case entityCreated = "entity_created", activation = "activation_reached"
    case features = "feature_usage_daily", screens = "screen_engagement_daily", configuration = "configuration_snapshot"
    case onboardingStep = "onboarding_step_reached", onboardingFinished = "onboarding_finished"
    case account = "account_flow_result", paywall = "paywall_opened", purchase = "purchase_flow_result", purchaseRestore = "purchase_restore_result"
    case backup = "backup_restore_result", reliability = "reliability_state_changed", preference = "preference_changed", widgetInventory = "widget_inventory"
}

/// Only scalar, allowlisted properties can reach the wire. No dictionaries of application data/errors.
nonisolated enum AnalyticsValue: Codable, Equatable, Sendable {
    case text(String), number(Int), flag(Bool)
    var json: Any { switch self { case .text(let s): return s; case .number(let n): return n; case .flag(let b): return b } }
    var text: String? { if case .text(let s) = self { return s }; return nil }
}

nonisolated enum AnalyticsContract {
    static let maximumCount = 100_000
    static let common = Set(["schema_version", "platform", "form_factor", "app_version", "app_build", "os_major", "release_channel",
                             "origin_surface", "plan", "sample_rate", "sampling_version", "analytics_record_id"])
    static let enums: [String: Set<String>] = [
        "entity_type": ["task", "habit"], "habit_type": Set(AnalyticsHabitType.allCases.map(\.rawValue)),
        "creation_origin": ["manual", "suggestion"], "milestone": ["first_observed_tracking_write"],
        "cohort": ["fresh_first_run", "restored", "existing", "unknown"], "flow_mode": ["first_run", "replay", "restore"],
        "step": ["welcome", "free_plan", "build", "quit", "tasks", "day_week", "first_item", "returning", "sign_in", "restore_source", "transfer_code"],
        "outcome": ["completed", "skipped", "restore_handoff", "started_fresh", "signed_in", "restored", "transferred", "kept_on_device"],
        "action": ["register", "sign_in", "link", "sign_out", "delete"], "provider": ["apple", "google", "not_applicable", "local", "server", "icloud", "google_drive", "unknown"],
        "result": ["success", "cancelled", "failed", "verified", "pending", "restored", "no_entitlement"],
        "new_account": ["true", "false", "unknown"], "failure_code": ["none", "storage_write", "storage_read", "unavailable", "network", "invalid_backup", "newer_version", "verification", "unknown"],
        "entry_point": ["menu", "habit_limit", "widget_configuration", "feature_gate"], "product_tier": ["plus", "family", "family_upgrade"],
        "verification": ["store", "server"], "operation": ["export", "manual_backup", "restore"],
        "format": ["checked_backup", "csv", "legacy", "unknown"], "restore_mode": ["replace", "merge", "not_applicable"],
        "subsystem": ["storage", "backup", "sync", "widget", "reminder"], "state": ["degraded", "recovered"],
        "account_state": ["no_account", "signed_in", "unknown"], "account_provider": ["apple", "google", "multiple", "not_applicable"],
        "backup_primary": ["server", "icloud", "google_drive", "local_only", "unknown"], "primary_source": ["automatic", "user_selected", "unknown"],
        "secondary_copy": ["icloud", "google_drive", "disabled", "unknown"],
        "effective_backup_status": ["verified_recent", "problem", "never_verified", "os_managed_unobservable", "unknown"],
        "sync_state": ["enabled", "disabled", "not_entitled", "no_account", "unknown"], "onboarding_state": ["not_started", "in_progress", "completed", "skipped", "unknown"],
        "widget_privacy_source": ["default", "user_selected", "unknown"], "theme_source": ["default", "user_selected", "unknown"], "haptics_source": ["default", "user_selected", "unknown"],
        "sound_source": ["default", "user_selected", "unknown"], "streaks_source": ["default", "user_selected", "unknown"], "app_lock_source": ["default", "user_selected", "unknown"],
        "theme": ["automatic", "light", "dark"], "reminder_permission": ["authorized", "denied", "not_determined", "unknown"],
        "reminder_mode": ["notification", "alarm", "disabled", "unknown"], "widget_privacy": ["hidden", "visible", "unknown"],
        "setting": ["backup_primary", "secondary_copy", "reminder_mode", "widget_privacy", "theme", "feedback", "streaks"],
        "value": ["automatic", "light", "dark", "enabled", "disabled", "server", "icloud", "google_drive", "local_only", "notification", "alarm", "hidden", "visible"],
        "query_result": ["success", "failed"], "host": ["unknown"]
    ]
    static let fields: [AnalyticsEvent: Set<String>] = [
        .entityCreated: ["entity_type", "habit_type", "creation_origin"], .activation: ["milestone", "entity_type", "habit_type", "cohort"],
        .onboardingStep: ["flow_mode", "step"], .onboardingFinished: ["flow_mode", "outcome"],
        .account: ["action", "provider", "result", "new_account", "failure_code"], .paywall: ["entry_point"],
        .purchase: ["product_tier", "result", "verification", "failure_code"], .purchaseRestore: ["result", "verification", "failure_code"],
        .backup: ["operation", "provider", "format", "restore_mode", "result", "failure_code"],
        .reliability: ["subsystem", "state", "failure_code"], .preference: ["setting", "value"],
        .configuration: ["account_state", "account_provider", "backup_primary", "primary_source", "secondary_copy", "effective_backup_status", "sync_state", "onboarding_state", "widget_privacy_source", "theme", "theme_source", "haptics_source", "sound_source", "streaks_source", "app_lock_source", "reminder_permission", "reminder_mode", "widget_privacy", "haptics", "sound", "streaks", "app_lock", "capability_set_version", "capability_account", "capability_purchase", "capability_sync", "capability_widgets", "capability_onboarding", "capability_progress", "capability_alarm"],
        .widgetInventory: ["query_supported", "query_result", "host"]
    ]
    static let daily = Set(["period_start_utc", "period_end_utc", "collection_started_mid_period", "foreground_active", "external_action_active", "coverage_complete", "coverage_version", "delivery_loss_count"])
    static let booleans = Set(["collection_started_mid_period", "foreground_active", "external_action_active", "coverage_complete", "haptics", "sound", "streaks", "app_lock", "query_supported", "capability_account", "capability_purchase", "capability_sync", "capability_widgets", "capability_onboarding", "capability_progress", "capability_alarm"])
    static let counterKeys: Set<String> = Set(AnalyticsCounter.allCases.map(\.rawValue))
        .union(["tracking_write_count", "task_write_count"])
        .union(AnalyticsHabitType.allCases.filter { $0 != .notApplicable }.map { "habit_write_" + $0.rawValue })
        .union(AnalyticsOrigin.allCases.map { "write_origin_" + $0.rawValue })
        .union(["storage", "backup", "sync", "widget", "reminder"].flatMap { ["\($0)_success_count", "\($0)_failure_count"] })
    // iPhone coverage v2: zero-fill only working adapters. Reserved/unimplemented counters remain absent.
    static let measuredCounterKeys = Set(AnalyticsCounter.allCases.filter {
        ![.deleteEntry, .completedFilter, .yearShare].contains($0)
    }.map(\.rawValue))
        .union(["tracking_write_count", "task_write_count"])
        .union(AnalyticsHabitType.allCases.filter { $0 != .notApplicable }.map { "habit_write_" + $0.rawValue })
        .union(AnalyticsOrigin.allCases.filter { ![.watch, .web].contains($0) }.map { "write_origin_" + $0.rawValue })
        .union(["storage", "backup", "widget"].flatMap { ["\($0)_success_count", "\($0)_failure_count"] })
    static let screenKeys = Set(AnalyticsScreen.allCases.flatMap { ["visits_" + $0.rawValue, "active_seconds_" + $0.rawValue] })

    static func valid(_ event: AnalyticsEvent, _ properties: [String: AnalyticsValue]) -> Bool {
        if let required = fields[event], ![.configuration, .widgetInventory].contains(event),
           !required.isSubset(of: Set(properties.keys)) { return false }
        var allowed = fields[event] ?? []
        if event == .features { allowed.formUnion(counterKeys) }
        if event == .screens { allowed.formUnion(screenKeys) }
        if [.features, .screens, .configuration].contains(event) { allowed.formUnion(daily) }
        if event == .widgetInventory {
            allowed.formUnion(["today", "item", "lock_today", "icons", "history", "tasks"].map { "kind_" + $0 + "_count" })
            allowed.formUnion(["small", "medium", "large", "accessory_inline", "accessory_circular", "accessory_rectangular"].map { "family_" + $0 + "_count" })
        }
        for (key, value) in properties {
            guard allowed.contains(key) else { return false }
            if let options = enums[key] { guard let s = value.text, options.contains(s) else { return false } }
            else if booleans.contains(key) { guard case .flag = value else { return false } }
            else { guard case .number(let n) = value, n >= 0, n <= (key.hasSuffix("_utc") ? 4_102_444_800 : maximumCount) else { return false } }
        }
        // A task is never reported as a habit subtype. Reject inconsistent pairs.
        if let entity = properties["entity_type"]?.text, let type = properties["habit_type"]?.text {
            if (entity == "task") != (type == "not_applicable") { return false }
        }
        if event == .purchase, !["verified", "pending", "cancelled", "failed"].contains(properties["result"]?.text ?? "") { return false }
        if event == .purchaseRestore, !["restored", "no_entitlement", "cancelled", "failed"].contains(properties["result"]?.text ?? "") { return false }
        if [.account, .backup].contains(event), !["success", "cancelled", "failed"].contains(properties["result"]?.text ?? "") { return false }
        if event == .account, properties["new_account"]?.text == "true", properties["result"]?.text != "success" { return false }
        return true
    }
}
