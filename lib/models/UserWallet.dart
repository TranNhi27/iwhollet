class UserWallet {
  String address;
  String privateKey;
  String icxReceiver;
  double balance;

  UserWallet({this.address = '', this.icxReceiver ='', this.privateKey ='', this.balance = 0.0});
}

UserWallet testWallet = UserWallet(
  address: "hxb85462f267165db9efbd27ac31b16d2283e074ad",
  privateKey: "155707fbccd14fc188f0102b9cd5f260e6f64699f4588d036937d7a374ea720c"
);
