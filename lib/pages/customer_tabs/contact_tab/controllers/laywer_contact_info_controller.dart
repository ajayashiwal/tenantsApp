import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../models/lawyer_contact_list.dart';
import '../../../../utils/app_strings.dart';

class LawyerContactInfoPageController extends GetxController {
  var argumentData = Get.arguments;
  LawyerContactListModel? lawyerContactListModel;
  String? profile="";
  String firstName="";
  String? phoneNo="";
  String? email="";
  String? faxNo="";
  String? workAddress="";
  String website="";
  String moreInfo="";
  String? id="";
  String? type="";
  String typeValue="";
  String role="";
  String lastName="";

  @override
  void onInit() {
    lawyerContactListModel  =argumentData[0][AppStrings.name] as LawyerContactListModel;
    id  =argumentData[0]["id"].toString();
    Representatives? representatives=lawyerContactListModel!.data!.representatives!.toList().firstWhereOrNull((element)=> element.id.toString()==id);
    Contacts? contacts=lawyerContactListModel!.data!.contacts!.toList().firstWhereOrNull((element)=> element.id.toString()==id);
    Contractor? contractor =lawyerContactListModel!.data!.contractor!.toList().firstWhereOrNull((element)=> element.id.toString()==id);
    Lawyer? lawyer =lawyerContactListModel!.data!.lawyer!.toList().firstWhereOrNull((element)=> element.id.toString()==id);
    if(representatives!=null){
      profile=representatives.profileImage;
      firstName=representatives.firstName.toString();
      email=representatives.email;
      faxNo=representatives.phone;
      workAddress=representatives.streetName;
      phoneNo=representatives.phone;
      lastName=representatives.lastName;

    }
    if(contacts!=null){
      profile=contacts.image;
      firstName=contacts.name.toString();
      email=contacts.email;
      faxNo=contacts.fax;
      workAddress=contacts.address;
      phoneNo=contacts.phone;
      role=contacts.role;
      lastName="";

    }
    if(contractor!=null){
      profile=contractor.image.toString();
      firstName=contractor.firstName.toString();
      email=contractor.officeEmail.toString();
      website=contractor.website.toString();
      phoneNo=contractor.officePhone.toString();
      workAddress=contractor.officeAddress.toString();
      moreInfo=contractor.moreInfo.toString();
      lastName=contractor.lastName.toString();
    }
    if(lawyer!=null){
      profile=lawyer.profileImage;
      firstName=lawyer.firstName.toString();
      email=lawyer.email.toString();
      phoneNo=lawyer.phone.toString();
      workAddress=lawyer.addressData.toString();
      lastName=lawyer.lastName.toString();
      website=lawyer.officeInfo!.website!=null?lawyer.officeInfo!.website.toString():"";
      moreInfo=lawyer.officeInfo!.moreInfo!=null?lawyer.officeInfo!.moreInfo.toString():"";

    }
    typeValue=argumentData[0][AppStrings.type].toString();
    if(typeValue==AppStrings.tenantRepresentative){
      type="נציג דיירים";
    }else if(typeValue==AppStrings.selectContacts){
      type=role;
    }else if(typeValue==AppStrings.selectProjectContractor){
      type="קבלן הפרוייקט";
    }else{
      type="עורך דין הקבוצה";
    }
    if (kDebugMode) {
      print("profile: $profile");
      print("firstName: $firstName");
      print("email: $email");
      print("faxNo: $faxNo");
      print("workAddress: $workAddress");
      print("phoneNo: $phoneNo");
      print("type: $type");
      print("moreInfo: $moreInfo");
    }
    super.onInit();

  }
}
