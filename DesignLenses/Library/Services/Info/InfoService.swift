//
//  InfoService.swift
//  DesignLenses
//
//  Created by Baby on 3/2/19.
//  Copyright © 2019 baby. All rights reserved.
//

import Foundation

final class InfoService {
	func makePrivacyPolicy() -> NSMutableAttributedString {
		let attributedString = NSMutableAttributedString()
		attributedString.bold("\nPrivacy Policy\n\n")
			.normal(PolicyConstants.GeneralPolicy)
			.bold("\nInformation Collection and Use\n\n")
			.normal(PolicyConstants.InformationCollectionSection)
			.bold("\nLog Data\n\n")
			.normal(PolicyConstants.LogDataSection)
			.normal("\n   • Google Analytics\n")
			.bold("\nCookies\n\n")
			.normal(PolicyConstants.CookiesSection)
			.bold("\nService Providers\n\n")
			.normal(PolicyConstants.ServiceProvidersSection)
			.bold("\nSecurity\n\n")
			.normal(PolicyConstants.SecuritySection)
			.bold("\nLinks to Other Sites\n\n")
			.normal(PolicyConstants.OtherLinksSection)
			.bold("\nChanges to This Privacy Policy\n\n")
			.normal(PolicyConstants.PolicyChangesSection)
			.bold("\nContact Us\n\n")
			.normal(PolicyConstants.ContactSection)

		return attributedString
	}

	func makeCredits() -> NSMutableAttributedString {
		let attributedString = NSMutableAttributedString()
		attributedString.bold("\nLenses\n\n")
			.normal(CreditsConstants.LensesCredits)
			.bold("\n\nImages\n\n")
			.normal(CreditsConstants.ImagesCredits)

		return attributedString
	}
}

private struct CreditsConstants {
	static let LensesCredits = """
	I am not trying to claim credits on this content in any way. I took them from a book: "The Art of Game Design: A Book of Lenses" by Jesse Schell and lenses copyrights belong to author.
	"""

	static let ImagesCredits = """
	Images were not created by developer and I'm not trying to claim credits for them in any way as well. Those are just images from internet.
	"""
}

private struct PolicyConstants {
	static let GeneralPolicy = """
Developer built the Design Lenses app as a Free app. This SERVICE is provided by Developer at no cost and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Design Lenses unless otherwise defined in this Privacy Policy.

"""
	static let InformationCollectionSection = """
For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request will be retained on your device and is not collected by me in any way.

The app does use third party services that may collect information used to identify you.

Third party services used in this app:

"""
	static let LogDataSection = "I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.\n"

	static let CookiesSection = """
Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

"""
	static let ServiceProvidersSection = """
I may employ third-party companies and individuals due to the following reasons:
   • To facilitate our Service;
   • To provide the Service on our behalf;
   • To perform Service-related services; or
   • To assist us in analyzing how our Service is used.
I want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

"""

	static let SecuritySection = "I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.\n"

	static let OtherLinksSection = "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n"

	static let PolicyChangesSection = "I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.\n"

	static let ContactSection = "If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me from the settings page in the app."

	static let DropboxPolicyLink = "https://www.dropbox.com/en_GB/privacy"
}
