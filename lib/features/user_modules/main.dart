import "admin.dart";
main(){
  Admin newAdmin = Admin("admin_username", "admin_password", firstName: "Soeuchelle", lastName: "Michel", email: "soeuchelle.michel@amicae.com");
  print(newAdmin);

  newAdmin.firstName = "Soeuchelle";
  print(newAdmin);
  }