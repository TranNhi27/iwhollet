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


UserWallet receiveWallet = UserWallet(
    address: "hx32804b5b1c41aa1b2aefcf1632bc3c31e99aebb1",
    privateKey: "4bdac85fae76a0f9d1739011a6cd3c70b77b7adf638c07c36529d50eb4b8e8ef"
);

//0x5dc7239df82f4df9278b0b1782fe8e9e2b59497284de702786862c8e035a2d30