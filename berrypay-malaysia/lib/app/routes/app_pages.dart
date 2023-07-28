import 'package:get/get.dart';

import '../modules/forgot_password_my/bindings/forgot_password_my_binding.dart';
import '../modules/forgot_password_my/forgot_password_form/bindings/forgot_password_form_binding.dart';
import '../modules/forgot_password_my/forgot_password_form/views/forgot_password_form_view.dart';
import '../modules/forgot_password_my/views/forgot_password_my_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_second/bindings/login_second_binding.dart';
import '../modules/login_second/views/login_second_view.dart';
import '../modules/malaysia/bill_payment/bindings/bill_payment_binding.dart';
import '../modules/malaysia/bill_payment/postpaid_topup/bindings/postpaid_topup_binding.dart';
import '../modules/malaysia/bill_payment/postpaid_topup/views/postpaid_topup_view.dart';
import '../modules/malaysia/bill_payment/prepaid_topup/bindings/prepaid_topup_binding.dart';
import '../modules/malaysia/bill_payment/prepaid_topup/prepaid_topup_form/bindings/prepaid_topup_form_binding.dart';
import '../modules/malaysia/bill_payment/prepaid_topup/prepaid_topup_form/views/prepaid_topup_form_view.dart';
import '../modules/malaysia/bill_payment/prepaid_topup/views/prepaid_topup_view.dart';
import '../modules/malaysia/bill_payment/views/bill_payment_view.dart';
import '../modules/malaysia/fpx/bindings/fpx_binding.dart';
import '../modules/malaysia/fpx/views/fpx_view.dart';
import '../modules/malaysia/kyc/bindings/kyc_my_binding.dart';
import '../modules/malaysia/kyc/kyc_result/bindings/kyc_result_my_binding.dart';
import '../modules/malaysia/kyc/kyc_result/views/kyc_result_my_view.dart';
import '../modules/malaysia/kyc/views/kyc_my_view.dart';
import '../modules/malaysia/layout/bindings/layout_my_binding.dart';
import '../modules/malaysia/layout/views/layout_my_view.dart';
import '../modules/malaysia/profile/about/bindings/about_binding.dart';
import '../modules/malaysia/profile/about/views/about_view.dart';
import '../modules/malaysia/profile/change_mobile_no/bindings/change_mobile_no_binding.dart';
import '../modules/malaysia/profile/change_mobile_no/views/change_mobile_no_view.dart';
import '../modules/malaysia/profile/contact/bindings/contact_binding.dart';
import '../modules/malaysia/profile/contact/views/contact_view.dart';
import '../modules/malaysia/profile/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/malaysia/profile/edit_profile/views/edit_profile_my_view.dart';
import '../modules/malaysia/profile/manual_kyc/bindings/manual_kyc_binding.dart';
import '../modules/malaysia/profile/manual_kyc/kyc_image/bindings/kyc_image_binding.dart';
import '../modules/malaysia/profile/manual_kyc/kyc_image/views/kyc_image_view.dart';
import '../modules/malaysia/profile/manual_kyc/views/manual_kyc_view.dart';
import '../modules/malaysia/profile/sender_information/bindings/sender_information_binding.dart';
import '../modules/malaysia/profile/sender_information/views/sender_information_view.dart';
import '../modules/malaysia/receipt/bindings/receipt_my_binding.dart';
import '../modules/malaysia/receipt/views/receipt_my_view.dart';
import '../modules/malaysia/register_wallet_my/bindings/register_wallet_my_binding.dart';
import '../modules/malaysia/register_wallet_my/register_wallet_form/bindings/register_wallet_form_my_binding.dart';
import '../modules/malaysia/register_wallet_my/register_wallet_form/views/register_wallet_form_my_view.dart';
import '../modules/malaysia/register_wallet_my/views/register_wallet_my_view.dart';
import '../modules/malaysia/register_wallet_my/wallet_result/bindings/wallet_result_my_binding.dart';
import '../modules/malaysia/register_wallet_my/wallet_result/views/wallet_result_my_view.dart';
import '../modules/malaysia/remittance/beneficiary_info/bindings/beneficiary_info_my_binding.dart';
import '../modules/malaysia/remittance/beneficiary_info/views/beneficiary_info_my_view.dart';
import '../modules/malaysia/remittance/bindings/remittance_my_binding.dart';
import '../modules/malaysia/remittance/confirmation_remittance_my/bindings/confirmation_remittance_my_binding.dart';
import '../modules/malaysia/remittance/confirmation_remittance_my/views/confirmation_remittance_my_view.dart';
import '../modules/malaysia/remittance/exchange_rate_my/bindings/exchange_rate_my_binding.dart';
import '../modules/malaysia/remittance/exchange_rate_my/views/exchange_rate_my_view.dart';
import '../modules/malaysia/remittance/payment_method_my/bindings/payment_method_my_binding.dart';
import '../modules/malaysia/remittance/payment_method_my/views/payment_method_my_view.dart';
import '../modules/malaysia/remittance/remittance_beneficiary_my/bindings/remittance_beneficiary_my_binding.dart';
import '../modules/malaysia/remittance/remittance_beneficiary_my/views/remittance_beneficiary_my_view.dart';
import '../modules/malaysia/remittance/remittance_form/bindings/remittance_form_my_binding.dart';
import '../modules/malaysia/remittance/remittance_form/views/remittance_form_my_view.dart';
import '../modules/malaysia/remittance/remittance_receipt_my/bindings/remittance_receipt_my_binding.dart';
import '../modules/malaysia/remittance/remittance_receipt_my/views/remittance_receipt_my_view.dart';
import '../modules/malaysia/remittance/views/remittance_my_view.dart';
import '../modules/malaysia/request/bindings/request_my_binding.dart';
import '../modules/malaysia/request/request_money/bindings/request_money_my_binding.dart';
import '../modules/malaysia/request/request_money/views/request_money_my_view.dart';
import '../modules/malaysia/request/request_receipt/bindings/request_receipt_my_binding.dart';
import '../modules/malaysia/request/request_receipt/views/request_receipt_my_view.dart';
import '../modules/malaysia/request/views/request_my_view.dart';
import '../modules/malaysia/spending/RecipientDetail/bindings/recipient_detail_binding.dart';
import '../modules/malaysia/spending/RecipientDetail/views/recipient_detail_view.dart';
import '../modules/malaysia/spending/bindings/spending_my_binding.dart';
import '../modules/malaysia/spending/qr_code/bindings/qr_code_my_binding.dart';
import '../modules/malaysia/spending/qr_code/views/qr_code_my_view.dart';
import '../modules/malaysia/spending/views/spending_my_view.dart';
import '../modules/malaysia/topup/bindings/topup_my_binding.dart';
import '../modules/malaysia/topup/views/topup_my_view.dart';
import '../modules/malaysia/transfer/bindings/transfer_my_binding.dart';
import '../modules/malaysia/transfer/scan_transfer/bindings/scan_transfer_my_binding.dart';
import '../modules/malaysia/transfer/scan_transfer/views/scan_transfer_my_view.dart';
import '../modules/malaysia/transfer/views/transfer_my_view.dart';
import '../modules/malaysia/wallet/wallet_info/bindings/wallet_info_my_binding.dart';
import '../modules/malaysia/wallet/wallet_info/views/wallet_info_my_view.dart';
import '../modules/malaysia/withdraw/bindings/withdraw_my_binding.dart';
import '../modules/malaysia/withdraw/views/withdraw_my_view.dart';
import '../modules/nationality/bindings/nationality_binding.dart';
import '../modules/nationality/views/nationality_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/referrel_code/bindings/referrel_code_binding.dart';
import '../modules/referrel_code/views/referrel_code_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/register_form/bindings/register_form_binding.dart';
import '../modules/register/register_form/views/register_form_view.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/wallet_benefit/bindings/wallet_benefit_binding.dart';
import '../modules/wallet_benefit/views/wallet_benefit_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.LAYOUT_MY,
      page: () => const LayoutMyView(),
      binding: LayoutMyBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_MY,
      page: () => const AboutMyView(),
      binding: AboutMyBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_MOBILE_NO_MY,
      page: () => const ChangeMobileNoMyView(),
      binding: ChangeMobileNoMyBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_MY,
      page: () => const EditProfileMyView(),
      binding: EditProfileMyBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_MY,
      page: () => const ContactMyView(),
      binding: ContactMyBinding(),
    ),
    GetPage(
      name: _Paths.TOPUP_MY,
      page: () => const TopupMyView(),
      binding: TopupMyBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_MY,
      page: () => const WithdrawMyView(),
      binding: WithdrawMyBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFER_MY,
      page: () => const TransferMyView(),
      binding: TransferMyBinding(),
    ),
    GetPage(
      name: _Paths.RECEIPT_MY,
      page: () => const ReceiptMyView(),
      binding: ReceiptMyBinding(),
    ),
    GetPage(
      name: _Paths.SPENDING_MY,
      page: () => const SpendingMyView(),
      binding: SpendingMyBinding(),
    ),
    GetPage(
      name: _Paths.RECIPIENT_DETAIL_MY,
      page: () => const RecipientDetailMyView(),
      binding: RecipientDetailMyBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_INFO_MY,
      page: () => const WalletInfoMyView(),
      binding: WalletInfoMyBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_MY,
      page: () => const RequestMyView(),
      binding: RequestMyBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_MONEY_MY,
      page: () => const RequestMoneyMyView(),
      binding: RequestMoneyMyBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_RECEIPT_MY,
      page: () => const RequestReceiptMyView(),
      binding: RequestReceiptMyBinding(),
    ),
    GetPage(
      name: _Paths.KYC_MY,
      page: () => const KycMyView(),
      binding: KycMyBinding(),
    ),
    GetPage(
      name: _Paths.KYC_RESULT_MY,
      page: () => const KycResultMyView(),
      binding: KycResultMyBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_WALLET_MY,
      page: () => const RegisterWalletMyView(),
      binding: RegisterWalletMyBinding(),
    ),
    GetPage(
      name: _Paths.REMITTANCE_MY,
      page: () => const RemittanceMyView(),
      binding: RemittanceMyBinding(),
    ),
    GetPage(
      name: _Paths.REMITTANCE_FORM_MY,
      page: () => const RemittanceFormMyView(),
      binding: RemittanceFormMyBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_TRANSFER_MY,
      page: () => const ScanTransferMyView(),
      binding: ScanTransferMyBinding(),
    ),
    GetPage(
      name: _Paths.QR_CODE_MY,
      page: () => const QrCodeMyView(),
      binding: QrCodeMyBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_RESULT_MY,
      page: () => const WalletResultMyView(),
      binding: WalletResultMyBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_WALLET_FORM_MY,
      page: () => const RegisterWalletFormMyView(),
      binding: RegisterWalletFormMyBinding(),
    ),
    GetPage(
      name: _Paths.EXCHANGE_RATE_MY,
      page: () => const ExchangeRateMyView(),
      binding: ExchangeRateMyBinding(),
    ),
    GetPage(
      name: _Paths.REMITTANCE_BENEFICIARY_MY,
      page: () => const RemittanceBeneficiaryMyView(),
      binding: RemittanceBeneficiaryMyBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRMATION_REMITTANCE_MY,
      page: () => const ConfirmationRemittanceMyView(),
      binding: ConfirmationRemittanceMyBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD_MY,
      page: () => const PaymentMethodMyView(),
      binding: PaymentMethodMyBinding(),
    ),
    GetPage(
      name: _Paths.FPX_MY,
      page: () => const FpxMyView(),
      binding: FpxMyBinding(),
    ),
    GetPage(
      name: _Paths.REMITTANCE_RECEIPT_MY,
      page: () => const RemittanceReceiptMyView(),
      binding: RemittanceReceiptMyBinding(),
    ),
    GetPage(
      name: _Paths.BENEFICIARY_INFO_MY,
      page: () => const BeneficiaryInfoMyView(),
      binding: BeneficiaryInfoMyBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_MY,
      page: () => const ForgotPasswordMyView(),
      binding: ForgotPasswordMyBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD_FORM,
      page: () => const ForgotPasswordFormView(),
      binding: ForgotPasswordFormBinding(),
    ),
    GetPage(
      name: _Paths.NATIONALITY,
      page: () => const NationalityView(),
      binding: NationalityBinding(),
    ),
    GetPage(
      name: _Paths.MANUAL_KYC,
      page: () => const ManualKycView(),
      binding: ManualKycBinding(),
    ),
    GetPage(
      name: _Paths.SENDER_INFORMATION,
      page: () => const SenderInformationView(),
      binding: SenderInformationBinding(),
    ),
    GetPage(
      name: _Paths.KYC_IMAGE,
      page: () => const KycImageView(),
      binding: KycImageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SECOND,
      page: () => const LoginSecondView(),
      binding: LoginSecondBinding(),
    ),
    GetPage(
      name: _Paths.BILL_PAYMENT,
      page: () => const BillPaymentView(),
      binding: BillPaymentBinding(),
    ),
    GetPage(
      name: _Paths.PREPAID_TOPUP,
      page: () => const PrepaidTopupView(),
      binding: PrepaidTopupBinding(),
    ),
    GetPage(
      name: _Paths.PREPAID_TOPUP_FORM,
      page: () => const PrepaidTopupFormView(),
      binding: PrepaidTopupFormBinding(),
    ),
    GetPage(
      name: _Paths.POSTPAID_TOPUP,
      page: () => const PostpaidTopupView(),
      binding: PostpaidTopupBinding(),
    ),
    GetPage(
      name: _Paths.REFERREL_CODE,
      page: () => const ReferrelCodeView(),
      binding: ReferrelCodeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_FORM,
      page: () => const RegisterFormView(),
      binding: RegisterFormBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_BENEFIT,
      page: () => const WalletBenefitView(),
      binding: WalletBenefitBinding(),
    ),
  ];
}
