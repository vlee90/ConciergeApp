//
//  Constants.swift
//  Concierge
//
//  Created by Vincent Lee on 11/17/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

enum ViewControllerIdenifiers: String {
    case ProfileVC = "PROFILE_VC"
    case ConciergeNavCrtl = "CONCIERGE_NAV_C"
    case ConciergeDetailVC = "CONCIERGE_DETAIL_VC"
    case SettingVC = "SETTING_VC"
    case JobNavCrtl = "JOB_NAV_C"
    case JobDetailVC = "JOB_DETAIL_VC"
    case ConfirmationVC = "CONFIRMATION_VC"
    case SignUpVC = "SIGN_UP_VC"
}

enum POSTRoutes: String {
    case User = "/users"
    case Confirm = "/confirm"
    case Concierge = "/concierge"
    case ConciergeAvailable = "/conciergeAvailable"
    case ConciergeUnavailable = "/conciergeUnavailable"
    case Jobs = "/jobs"
}